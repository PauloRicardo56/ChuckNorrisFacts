//
//  FactsListTableView.swift
//  ChuckNorrisFacts
//
//  Created by Paulo Ricardo on 21/12/20.
//

import Foundation
import RxSwift
import UIKit

class FactsListTableView: UITableView, ReactiveUI {
    
    let bag = DisposeBag()
    
    init() {
        super.init(frame: .zero, style: .plain)
        translatesAutoresizingMaskIntoConstraints = false
        register(FactCell.self, forCellReuseIdentifier: "factCell")
        
        
        
//        reactiveHeight(of: self)
//            .subscribe(rx.frame)
//            .disposed(by: bag)
    }
    
    override func didMoveToSuperview() {
        guard let superview = superview else { return }
        
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalTo: superview.widthAnchor),
            centerXAnchor.constraint(equalTo: superview.centerXAnchor),
            topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor),
            heightAnchor.constraint(equalToConstant: 50)
//            heightAnchor.constraint(equalTo: superview.heightAnchor)
        ])
    }
    
    func reactiveHeight() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
