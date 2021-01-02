//
//  InitialViewController.swift
//  ChuckNorrisFacts
//
//  Created by Paulo Ricardo on 21/12/20.
//

import UIKit
import RxSwift
import RxCocoa

class InitialViewController: UIViewController {
    // MARK: Properties
    let bag = DisposeBag()
    let viewModel: TextSearchViewModel
    var coordinator: AppCoordinator?
    
    // MARK: Views
    let tableView = FactsListTableView()
    let loadingView = LoadingView()
    var searchBar = FactSearchBar()
    
    init(viewModel: TextSearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        view.addSubview(loadingView)
        view.backgroundColor = Colors.background.uiColor
        
        navigationItem.leftBarButtonItem = .init(customView: searchBar)
        navigationController?.navigationBar.barTintColor = Colors.foreground.uiColor
        navigationController?.navigationBar.isTranslucent = false
        
        bindViewModel()
        subscribeSearchActivity()
        changeViewWhenAPIResponse()
        setupTableViewDataSrouce()
    }
    
    // MARK: - View model binds
    private func bindViewModel() {
        bindSearchFact()
        bindErrors()
    }
    
    private func bindSearchFact() {
        searchInput()
            .subscribe { [weak self] search in self?.viewModel.searchFact(search) }
            .disposed(by: bag)
    }
    
    private func bindErrors() {
        viewModel.error
            .asDriver(onErrorJustReturn: .singleMessage(.serverError))
            .do { [weak self] _ in self?.loadingView.activityIndicator.isHidden = true }
            .drive { [weak self] err in
                self?.present(ErrorMessageAlert(with: err), animated: true)
            }
            .disposed(by: bag)
    }
    
    // MARK: - View binds
    private func subscribeSearchActivity() {
        searchInput()
            .map { _ in false }
            .subscribe(loadingView.activityIndicator.rx.isHidden)
            .disposed(by: bag)
        
        searchInput()
            .map { _ in false }
            .subscribe(loadingView.rx.isHidden)
            .disposed(by: bag)
        
        searchInput()
            .map { _ in true }
            .subscribe(searchBar.rx.resignFirstResponder)
            .disposed(by: bag)
    }
    
    private func searchInput() -> Observable<String> {
        searchBar.rx.searchButtonClicked
            .map { [weak self] in self?.searchBar.text ?? "" }
            .filter { !$0.isEmpty }
    }
    
    private func changeViewWhenAPIResponse() {
        viewModel.facts
            .map { _ in true }
            .subscribe(loadingView.rx.isHidden)
            .disposed(by: bag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - TableView DataSource
extension InitialViewController {
    
    private func setupTableViewDataSrouce() {
        self.viewModel.facts
            .bind(to: self.tableView.rx.items) { (tableView: UITableView, index: Int, element: Fact) in
                let indexPath = IndexPath(row: index, section: 0)
                let cell = tableView.dequeueReusableCell(withIdentifier: "factCell", for: indexPath) as! FactCell
                return CellBuilder(build: cell)
                    .withValueText(text: element.value)
                    .withShareButton(image: "square.and.arrow.up")
                    .withShareButtonAction { [weak self] in self?.coordinator?.share(url: element.url) }
                    .withCategoryText(text: element.categories.first)
                    .build()
            }
            .disposed(by: bag)
    }
}
