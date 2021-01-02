//
//  FactsSearchBar.swift
//  ChuckNorrisFacts
//
//  Created by Paulo Ricardo on 22/12/20.
//

import Foundation
import UIKit
import RxSwift

class FactSearchBar: UISearchBar {
    
    let bag = DisposeBag()
    
    var bindIndicator: Binder<Bool> {
        indicator.rx.isHidden
    }
    
    private let indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(frame: .zero)
        indicator.startAnimating()
        indicator.isHidden = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupTextField()
        sizeToFit()
        
        setCancelButtonShown()
        setCancelButtonClicked()
    }
    
    // MARK: Private methods
    private func setupTextField() {
        guard let textField = value(forKey: "searchField") as? UITextField else { return }
        let searchIcon = textField.leftView
        
        textField.font = Fonts.courier(size: 17).font
        textField.backgroundColor = Colors.background.uiColor
        searchIcon?.tintColor = Colors.orange.uiColor
        
        textField.addSubview(indicator)
        NSLayoutConstraint.activate([
            indicator.heightAnchor.constraint(equalTo: textField.heightAnchor, multiplier: 0.9),
            indicator.widthAnchor.constraint(equalTo: indicator.heightAnchor),
            indicator.trailingAnchor.constraint(equalTo: textField.trailingAnchor),
            indicator.centerYAnchor.constraint(equalTo: textField.centerYAnchor)
        ])
    }
    
    private func setCancelButtonShown() {
        let beginEditing: Observable<Bool> = rx.textDidBeginEditing
            .map { true }
        let endEditing: Observable<Bool> = rx.textDidEndEditing
            .map { false }
        
        Observable.merge(beginEditing, endEditing)
            .startWith(false)
            .subscribe(rx.showsCancelButton)
            .disposed(by: bag)
    }
    
    private func setCancelButtonClicked() {
        rx.cancelButtonClicked
            .subscribe(onNext: { [weak self] in self?.resignFirstResponder() })
            .disposed(by: bag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension Reactive where Base: UISearchBar {
    var resignFirstResponder: Binder<Bool> {
        Binder<Bool>(base) {
            if $1 { $0.resignFirstResponder() }
        }
    }
}
