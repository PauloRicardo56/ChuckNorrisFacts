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
    let tableView: FactsListTableView = { .init() }()
    lazy var searchBar = FactSearchBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        
        let cancelButton = UIButton()
        cancelButton.setTitle("Cancel", for: .normal)
        
        navigationItem.leftBarButtonItem = .init(customView: searchBar)
        navigationItem.rightBarButtonItem = .init(customView: cancelButton)
        
        searchBar.rx.searchButtonClicked
            .map { self.searchBar.text ?? "" }
            .filter { !$0.isEmpty }
            .asDriver(onErrorJustReturn: "")
            .drive(onNext: { [weak self] text in
                guard let self = self else { return }
                
                self.tableView.dataSource = nil
                ChuckNorrisAPI.shared.searchFact(text)
                    .map { $0.result }
                    .bind(to: self.tableView.rx.items) { (tableView: UITableView, index: Int, element: Fact) in
                        let indexPath = IndexPath(row: index, section: 0)
                        let cell = tableView.dequeueReusableCell(withIdentifier: "factCell", for: indexPath) as! FactCell
                        cell.valueText.text = element.value
                        cell.share.setImage(UIImage(systemName: "check"), for: .normal)
                        cell.category.text = "Uncategorized"
                        return cell
                    }
                    .disposed(by: self.bag)
            })
            .disposed(by: bag)
    }
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .orange
        
        self.view = view
    }
}
