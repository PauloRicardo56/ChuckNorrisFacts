//
//  FactCell.swift
//  ChuckNorrisFacts
//
//  Created by Paulo Ricardo on 21/12/20.
//

import Foundation
import UIKit

class FactCell: UITableViewCell {
    // MARK: Views
    var icon: UIImageView = {
        let view = UIImageView(image: UIImage(named: "chuckNorris"))
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var valueText: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var share: UIButton = {
        let button = UIButton()
        button.setTitle("Share", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    // TODO: category view
    let category: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    // MARK: StackViews
    var backgroundStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    var iconStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    var innerStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    var bottomStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .equalCentering
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FactCell: ViewCodable {
    func setupViewHierarchy() {
        contentView.addSubview(backgroundStack)
        
        setupIcon()
        setupRightStack()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundStack.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 10),
            backgroundStack.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 10),
            backgroundStack.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -10),
            backgroundStack.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            iconStack.widthAnchor.constraint(
                equalTo: backgroundStack.widthAnchor,
                multiplier: 0.1),
            innerStack.widthAnchor.constraint(
                equalTo: backgroundStack.widthAnchor,
                multiplier: 0.85),
            innerStack.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 10),
            innerStack.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -10)
        ])
    }
    
    private func setupIcon() {
        iconStack.distribution = .equalSpacing
        iconStack.addArrangedSubview(icon)
        iconStack.addArrangedSubview(UIView())
        backgroundStack.addArrangedSubview(iconStack)
    }
    
    private func setupRightStack() {
        innerStack.backgroundColor = .red
        innerStack.addArrangedSubview(valueText)
        setupBottomViews()
        backgroundStack.addArrangedSubview(innerStack)
    }
    
    private func setupBottomViews() {
        bottomStack.addArrangedSubview(category)
        bottomStack.addArrangedSubview(share)
        innerStack.addArrangedSubview(bottomStack)
    }
}
