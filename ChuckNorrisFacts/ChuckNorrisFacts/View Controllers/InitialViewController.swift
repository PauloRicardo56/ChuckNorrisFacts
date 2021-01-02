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
    var searchInput: Driver<String>?

    // MARK: Views
    let tableView: FactsListTableView = {
        let table = FactsListTableView()
        table.backgroundColor = .clear
        table.separatorStyle = .none
        table.allowsSelection = false
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    let loadingView: LoadingView = {
        let view = LoadingView()
        view.backgroundColor = Colors.background.uiColor
        view.alpha = 0.9
        return view
    }()
    
    var searchBar: FactSearchBar = {
        let search = FactSearchBar()
        search.tintColor = Colors.font.uiColor
        return search
    }()
    
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
        
        bindSearchInput()
        bindViewModel()
        subscribeSearchActivity()
        changeViewWhenAPIResponse()
        setupTableViewDataSrouce()
    }
    
    private func bindSearchInput() {
        self.searchInput = searchBar.rx.searchButtonClicked
            .map { [weak self] in self?.searchBar.text ?? "" }
            .filter { !$0.isEmpty }
            .share(replay: 1)
            .asDriver(onErrorJustReturn: "")
    }
    
    // MARK: - View model binds
    private func bindViewModel() {
        bindSearchFact()
        bindErrors()
    }
    
    private func bindSearchFact() {
        searchInput?
            .drive { [weak self] search in self?.viewModel.searchFact(search) }
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
        searchInput?
            .map { _ in false }
            .drive(loadingView.activityIndicator.rx.isHidden)
            .disposed(by: bag)
        
        searchInput?
            .map { _ in false }
            .drive(loadingView.rx.isHidden)
            .disposed(by: bag)
        
        searchInput?
            .map { _ in true }
            .drive(searchBar.rx.resignFirstResponder)
            .disposed(by: bag)
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
