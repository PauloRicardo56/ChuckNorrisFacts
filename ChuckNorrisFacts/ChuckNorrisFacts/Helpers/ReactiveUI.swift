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
    
//    func reactiveHeight<T: UIView>(of view: T) -> Observable<CGRect> {
//        tableView.rx.prefetchRows
//            .map { _ in tableView.contentSize.height }
//            .map { CGRect(origin: tableView.frame.origin, size: .init(width: tableView.frame.width, height: $0)) }
//    }
    
    func reactiveFontSize(
        of label: UILabel,
        with charLimit: Int = 80,
        smallerFontSize: CGFloat = 14,
        biggerFontSize: CGFloat = 22
    ) -> Observable<UIFont> {
        
        label.rx.observe(String.self, "text")
            .compactMap { $0?.count }
            .map { textCount -> UIFont in
                switch textCount {
                case ...charLimit:
                    return .systemFont(ofSize: biggerFontSize)
                default:
                    return .systemFont(ofSize: smallerFontSize)
                }
            }
    }
}
