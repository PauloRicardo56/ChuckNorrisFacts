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
    
    init(viewModel: TextSearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        
        searchBarSetup()
        bindViewModel()
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
                cell.category.text = element.categories.first ?? "uncategorized"
                return cell
            }
            .disposed(by: self.bag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



