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
    let bag = DisposeBag()
    let tableView: FactsListTableView = { .init() }()
    var cellHeight = BehaviorRelay(value: UITableView.automaticDimension)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        
        ChuckNorrisAPI.shared
            .searchFact("ant")
            .map { $0.result }
            .bind(to: tableView.rx.items) { (tableView: UITableView, index: Int, element: Fact) in
                let indexPath = IndexPath(row: index, section: 0)
                let cell = tableView.dequeueReusableCell(withIdentifier: "factCell", for: indexPath) as! FactCell
                cell.valueText.text = element.value
//                self.cellHeight.accept(cell.valueText.frame.height)
                cell.share.setImage(UIImage(systemName: "check"), for: .normal)
                cell.category.text = "Uncategorized"
                return cell
            }
            .disposed(by: bag)
    }
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .orange
        
        self.view = view
    }
}
