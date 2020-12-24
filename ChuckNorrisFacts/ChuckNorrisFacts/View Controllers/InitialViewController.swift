//
//  InitialViewController.swift
//  ChuckNorrisFacts
//
//  Created by Paulo Ricardo on 21/12/20.
//

import UIKit
import RxSwift

class InitialViewController: UIViewController {
    let bag = DisposeBag()
    let tableView = FactsListTableView()
    var searchBar = FactSearchBar()
    let viewModel: TextSearchViewModel
    var coordinator: AppCoordinator?
    
    init(viewModel: TextSearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        
        searchBarSetup()
        bindViewModel()
        tableViewSetup()
    }
    
    private func searchBarSetup() {
        navigationItem.leftBarButtonItem = .init(customView: searchBar)
        searchBar.rx.searchButtonClicked
            .map { [weak self] in self?.searchBar.text ?? "" }
            .filter { !$0.isEmpty }
            .subscribe(onNext: { [weak self] in self?.viewModel.searchFacts($0) })
            .disposed(by: bag)
    }
    
    // MARK: TableView DataSource
    private func bindViewModel() {
        viewModel.facts
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
                cell.category.text?.append(" \(element.value.count)")
                return cell
            }
            .disposed(by: self.bag)
    }
    
    private func tableViewSetup() {
        viewModel.facts
            .asDriver()
            .compactMap { [weak self] _ in self?.tableView.contentSize.height }
            .drive(onNext: { [weak self] contentHeight in
                guard let self = self else { return }
                let height = self.tableView.constraints.first { constraint in
                    constraint.firstAttribute == .height
                }
                height?.constant = contentHeight > self.view.frame.height ? self.view.frame.height : contentHeight
                self.tableView.layoutIfNeeded()
            })
            .disposed(by: bag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
