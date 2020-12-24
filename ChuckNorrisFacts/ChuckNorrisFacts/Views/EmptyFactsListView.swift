//
//  EmptyFactsListView.swift
//  ChuckNorrisFacts
//
//  Created by Paulo Ricardo on 24/12/20.
//

import Foundation
import UIKit
import RxSwift


class EmptyFactsListView: UIView {
    
    // MARK: Views
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let icon: UIImageView = {
        let view = UIImageView(image: UIImage(named: "chuckNorris"))
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "Powered by:\napi.chucknorris.io"
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.startAnimating()
        indicator.isHidden = true
        return indicator
    }()
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    override func didMoveToSuperview() {
        guard let superview = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor),
            bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor),
            widthAnchor.constraint(equalTo: superview.widthAnchor),
            centerXAnchor.constraint(equalTo: superview.centerXAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EmptyFactsListView: ViewCodable {
    func setupViewHierarchy() {
        addSubview(stackView)
        stackView.addArrangedSubview(icon)
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(activityIndicator)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.widthAnchor.constraint(
                equalTo: widthAnchor,
                multiplier: 0.5)
        ])
    }
}
