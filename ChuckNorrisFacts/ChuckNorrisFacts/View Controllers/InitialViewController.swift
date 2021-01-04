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
    let viewModel: FactSearchViewModel
    var coordinator: AppCoordinator?
    var searchQuery: Driver<String>?

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
        search.searchTextField.accessibilityIdentifier = AccessibilityIdentifier.searchBar
        return search
    }()
    
    init(viewModel: FactSearchViewModel) {
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
    }
    
    func setSubscribers() {
        bind(to: viewModel)
        bindSearchBarQuery()
        searchButtonClicked()
        showLoadingView()
        hideLoadingView()
        bindKeyboardDismiss()
    }
    
    // MARK: - View model bind
    private func bind(to viewModel: FactSearchViewModel) {
        viewModel.facts
            .bind(to: self.tableView.rx.items) { (tableView: UITableView, index: Int, element: Fact) in
                let indexPath = IndexPath(row: index, section: 0)
                let cell = tableView.dequeueReusableCell(withIdentifier: "factCell", for: indexPath) as! FactCell
                return CellBuilder(cell)
                    .withValueText(text: element.value)
                    .withShareButton(image: "square.and.arrow.up")
                    .withShareButtonAction { [weak self] in self?.coordinator?.share(url: element.url) }
                    .withCategoryText(text: element.categories.first)
                    .build()
            }
            .disposed(by: bag)
        
        viewModel.error
            .asDriver(onErrorJustReturn: .singleMessage(.serverError))
            .do { [weak self] _ in
                self?.loadingView.activityIndicator.isHidden = true
            }
            .drive { [weak self] err in
                self?.coordinator?.error(vc: self, err: err)
            }
            .disposed(by: bag)
    }
    
    // MARK: - View binds
    private func bindSearchBarQuery() {
        searchQuery = searchBar.rx.searchButtonClicked
            .map { [weak self] in self?.searchBar.text ?? "" }
            .filter { !$0.isEmpty }
            .asDriver(onErrorJustReturn: "")
    }
    
    private func searchButtonClicked() {
        searchQuery?
            .drive { [weak self] in
                self?.viewModel.didSearch(query: $0)
            }
            .disposed(by: bag)
    }
    
    private func showLoadingView() {
        searchQuery?
            .map { _ in false }
            .drive(loadingView.activityIndicator.rx.isHidden,
                   loadingView.rx.isHidden)
            .disposed(by: bag)
    }
    
    private func hideLoadingView() {
        viewModel.facts
            .filter { fact in
                !fact.isEmpty
            }
            .map { _ in true }
            .subscribe(loadingView.rx.isHidden)
            .disposed(by: bag)
    }
    
    private func bindKeyboardDismiss() {
        searchQuery?
            .map { _ in true }
            .drive(searchBar.rx.resignFirstResponder)
            .disposed(by: bag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
