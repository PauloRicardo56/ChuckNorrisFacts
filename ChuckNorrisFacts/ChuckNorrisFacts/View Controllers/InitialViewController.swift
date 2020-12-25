//
//  InitialViewController.swift
//  ChuckNorrisFacts
//
//  Created by Paulo Ricardo on 21/12/20.
//

import UIKit
import RxSwift

class InitialViewController: UIViewController {
    // MARK: Properties
    let bag = DisposeBag()
    let viewModel: TextSearchViewModel
    var coordinator: AppCoordinator?
    
    // MARK: Views
    let tableView = FactsListTableView()
    let emptyView = EmptyFactsListView()
    var searchBar = FactSearchBar()
    
    init(viewModel: TextSearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(emptyView)
        view.backgroundColor = .white
        
        navigationItem.leftBarButtonItem = .init(customView: searchBar)
        
        subscribeSearchActivity()
        changeViewWhenAPIResponse()
        setupTableViewDataSrouce()
    }
    
    // MARK: - Methods
    private func subscribeSearchActivity() {
        searchInput()
            .map { _ in false }
            .subscribe(emptyView.activityIndicator.rx.isHidden)
            .disposed(by: bag)
    }
    
    private func searchInput() -> Observable<String> {
        searchBar.rx.searchButtonClicked
            .map { [weak self] in self?.searchBar.text ?? "" }
            .filter { !$0.isEmpty }
    }
    
    private func changeViewWhenAPIResponse() {
        APIResponse()
            .take(1)
            .asDriver(onErrorJustReturn: [])
            .map { _ in true }
            .drive{ [weak self] _ in
                guard let self = self else { return }
                self.emptyView.removeFromSuperview()
                self.view.addSubview(self.tableView)
            }
            .disposed(by: bag)
    }
    
    private func APIResponse() -> Observable<[Fact]> {
        searchInput()
            .flatMapLatest { self.viewModel.searchFacts($0) }
    }
    
    private func setupTableViewDataSrouce() {
        APIResponse()
            .bind(to: self.tableView.rx.items) { (tableView: UITableView, index: Int, element: Fact) in
                let indexPath = IndexPath(row: index, section: 0)
                let cell = tableView.dequeueReusableCell(withIdentifier: "factCell", for: indexPath) as! FactCell
                cell.valueText.text = element.value
                cell.share.setImage(UIImage(systemName: "check"), for: .normal)
                cell.share.rx.tap
                    .asSignal()
                    .emit(onNext: { [weak self] in self?.coordinator?.share(url: element.url) })
                    .disposed(by: cell.bag)
                cell.category.text = element.categories.first ?? "uncategorized"
                return cell
            }
            .disposed(by: bag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
