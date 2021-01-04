//
//  CategoryLabel.swift
//  ChuckNorrisFacts
//
//  Created by Paulo Ricardo on 01/01/21.
//

import Foundation
import UIKit

class CategoryLabel: UILabel {
    
    private let topInset: CGFloat = 7
    private let leftInset: CGFloat = 15
    private let bottomInset: CGFloat = 5
    private let rightInset: CGFloat = 15
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return .init(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }
}
