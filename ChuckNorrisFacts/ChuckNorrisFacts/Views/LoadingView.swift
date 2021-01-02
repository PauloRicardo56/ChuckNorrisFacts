//
//  EmptyFactsListView.swift
//  ChuckNorrisFacts
//
//  Created by Paulo Ricardo on 24/12/20.
//

import Foundation
import UIKit
import RxSwift


class LoadingView: UIView {
    
    // MARK: Views
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let title: UILabel = {
        let label = UILabel()
        label.text = "Chuck Norris\nFacts"
        label.font = Fonts._04b(size: 30).font
        label.textColor = Colors.orange.uiColor
        label.numberOfLines = 0
        label.textAlignment = .center
        label.layer.shadowOffset = .init(width: 1, height: 1)
        label.layer.shadowRadius = 0
        label.layer.shadowOpacity = 1
        label.layer.shadowColor = Colors.font.cgColor
        return label
    }()
    
    let icon: UIImageView = {
        let view = UIImageView(image: UIImage(named: "chuckNorris"))
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let copyright: UILabel = {
        let label = UILabel()
        label.text = "Powered by:\napi.chucknorris.io"
        label.font = Fonts.courierBold(size: 14).font
        label.textColor = Colors.font.uiColor
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.startAnimating()
        indicator.isHidden = true
        indicator.color = Colors.orange.uiColor
        return indicator
    }()
    
    init() {
        super.init(frame: .zero)
        setupView()
        
        backgroundColor = Colors.background.uiColor
        alpha = 0.9
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

extension LoadingView: ViewCodable {
    func setupViewHierarchy() {
        addSubview(stackView)
        stackView.addArrangedSubview(icon)
        stackView.addArrangedSubview(title)
        stackView.addArrangedSubview(copyright)
        stackView.addArrangedSubview(activityIndicator)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
