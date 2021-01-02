//
//  CellBuilder.swift
//  ChuckNorrisFacts
//
//  Created by Paulo Ricardo on 02/01/21.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class CellBuilder {
    private let cell: FactCell
    
    init(build cell: FactCell) {
        self.cell = cell
    }
    
    // MARK: Build methods
    func withValueText(text: String) -> CellBuilder {
        cell.valueText.text = text
        return self
    }
    
    func withShareButton(image: String) -> CellBuilder {
        let image = UIImage(systemName: image)
        cell.share.setImage(image, for: .normal)
        return self
    }
    
    func withShareButtonAction(onNext: @escaping () -> Void) -> CellBuilder {
        cell.share.rx.tap
            .asSignal()
            .emit(onNext: onNext)
            .disposed(by: cell.bag)
        return self
    }
    
    func withCategoryText(text: String?) -> CellBuilder {
        cell.category.text = text ?? "uncategorized"
        return self
    }
    
    // MARK: Build
    func build() -> FactCell {
        return cell
    }
}
