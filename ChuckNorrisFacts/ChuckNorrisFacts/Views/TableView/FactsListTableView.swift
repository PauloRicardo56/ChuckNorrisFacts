//
//  FactsListTableView.swift
//  ChuckNorrisFacts
//
//  Created by Paulo Ricardo on 21/12/20.
//

import Foundation
import UIKit

class FactsListTableView: UITableView, ReactiveUI {
    
    init() {
        super.init(frame: .zero, style: .plain)
        register(FactCell.self, forCellReuseIdentifier: "factCell")
        
        backgroundColor = .clear
        separatorStyle = .none
        allowsSelection = false
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func didMoveToSuperview() {
        guard let superview = superview else { return }
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor),
            bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor),
            centerXAnchor.constraint(equalTo: superview.centerXAnchor),
            widthAnchor.constraint(equalTo: superview.widthAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
