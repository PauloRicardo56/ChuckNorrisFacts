//
//  FactsListTableView.swift
//  ChuckNorrisFacts
//
//  Created by Paulo Ricardo on 21/12/20.
//

import Foundation
import UIKit

class FactsListTableView: UITableView {
    
    init() {
        super.init(frame: .zero, style: .plain)
        translatesAutoresizingMaskIntoConstraints = false
        register(FactCell.self, forCellReuseIdentifier: "factCell")
    }
    
    override func didMoveToSuperview() {
        guard let superview = superview else { return }
        
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalTo: superview.widthAnchor),
            centerXAnchor.constraint(equalTo: superview.centerXAnchor),
            heightAnchor.constraint(equalTo: superview.heightAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
