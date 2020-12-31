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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
        
        setCancelButtonShown()
        setCancelButtonClicked()
    }
    
    // MARK: Private methods
    private func setupLayout() {
        let textField = value(forKey: "searchField") as? UITextField
        let searchIcon = textField?.leftView
        
        textField?.backgroundColor = Colors.background.uiColor
        searchIcon?.tintColor = Colors.orange.uiColor
        tintColor = Colors.font.uiColor
        sizeToFit()
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
