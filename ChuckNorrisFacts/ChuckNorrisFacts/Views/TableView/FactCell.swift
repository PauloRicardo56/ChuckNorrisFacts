//
//  FactCell.swift
//  ChuckNorrisFacts
//
//  Created by Paulo Ricardo on 21/12/20.
//

import Foundation
import RxSwift
import UIKit

class FactCell: UITableViewCell, ReactiveUI {
    var bag = DisposeBag()
    
    // MARK: Views
    var icon: UIImageView = {
        let view = UIImageView(image: UIImage(named: "chuckNorris"))
        view.contentMode = .scaleAspectFit
        return view
    }()
    var valueText: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = Colors.font.uiColor
        return label
    }()
    var share: UIButton = {
        let button = UIButton()
        button.tintColor = Colors.orange.uiColor
        return button
    }()
    let category: CategoryLabel = {
        let label = CategoryLabel()
        label.font = Fonts.courierBold(size: 14).font
        label.textColor = .white
        label.layer.cornerRadius = 7
        label.layer.backgroundColor = Colors.orange.cgColor
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
        stack.distribution = .equalSpacing
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        setupLayout()
        
        reactiveFontSize(of: valueText)
            .subscribe(valueText.rx.font)
            .disposed(by: bag)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        /// Necessário para não termos mais de um subscriber por cell quando no dequeue da tableView
        bag = DisposeBag()
        reactiveFontSize(of: valueText)
            .subscribe(valueText.rx.font)
            .disposed(by: bag)
    }
    
    private func setupLayout() {
        backgroundColor = .clear
        backgroundStack.spacing = 10
        backgroundStack.layer.cornerRadius = 15
        backgroundStack.backgroundColor = Colors.foreground.uiColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - View setups
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
            iconStack.leadingAnchor.constraint(
                equalTo: backgroundStack.leadingAnchor,
                constant: 10),
            iconStack.topAnchor.constraint(
                equalTo: backgroundStack.topAnchor,
                constant: 10),
            innerStack.topAnchor.constraint(
                equalTo: backgroundStack.topAnchor,
                constant: 10),
            innerStack.bottomAnchor.constraint(
                equalTo: backgroundStack.bottomAnchor,
                constant: -10),
            innerStack.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -30)
        ])
    }
    
    private func setupIcon() {
        iconStack.distribution = .equalSpacing
        iconStack.addArrangedSubview(icon)
        iconStack.addArrangedSubview(UIView())
        backgroundStack.addArrangedSubview(iconStack)
    }
    
    private func setupRightStack() {
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
