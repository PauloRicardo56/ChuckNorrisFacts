//
//  ReactiveUI.swift
//  ChuckNorrisFacts
//
//  Created by Paulo Ricardo on 23/12/20.
//

import Foundation
import RxSwift
import UIKit

protocol ReactiveUI {}

extension ReactiveUI {
    
    func reactiveFontSize(
        of label: UILabel,
        with charLimit: Int = 80,
        smallerFontSize: CGFloat = 14,
        biggerFontSize: CGFloat = 24
    ) -> Observable<UIFont> {
        
        label.rx.observe(String.self, "text")
            .compactMap { $0?.count }
            .map { textCount -> UIFont in
                switch textCount {
                case ...charLimit:
                    return Fonts.courier(size: biggerFontSize).font ?? .systemFont(ofSize: biggerFontSize)
                default:
                    return Fonts.courier(size: smallerFontSize).font ?? .systemFont(ofSize: biggerFontSize)
                }
            }
    }
}
