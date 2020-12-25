//
//  ReactiveUIMock.swift
//  ChuckNorrisFactsTests
//
//  Created by Paulo Ricardo on 23/12/20.
//

import Foundation
import UIKit
import RxSwift
@testable import ChuckNorrisFacts

class ReactiveUIMock: ReactiveUI {
    let bag = DisposeBag()
    let textLabel = UILabel()
    
    init() {
        textLabel.text = ""
        reactiveFontSize(of: textLabel)
            .subscribe(textLabel.rx.font)
            .disposed(by: bag)
    }
}
