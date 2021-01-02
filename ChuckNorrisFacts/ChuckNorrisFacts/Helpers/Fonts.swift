//
//  Fonts.swift
//  ChuckNorrisFacts
//
//  Created by Paulo Ricardo on 01/01/21.
//

import Foundation
import UIKit

enum Fonts {
    case courier(size: CGFloat)
    case courierBold(size: CGFloat)
    case _04b(size: CGFloat)
    
    var font: UIFont? {
        switch self {
        case .courier(let size):
            return UIFont(name: "Courier", size: size)
        case .courierBold(let size):
            return UIFont(name: "Courier-Bold", size: size)
        case ._04b(let size):
            return UIFont(name: "04B30", size: size)
        }
    }
}
