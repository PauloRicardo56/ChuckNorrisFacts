//
//  Fonts.swift
//  ChuckNorrisFacts
//
//  Created by Paulo Ricardo on 01/01/21.
//

import Foundation
import UIKit

enum Fonts {
    case body(size: CGFloat)
    case category(size: CGFloat)
    
    var font: UIFont? {
        switch self {
        case .body(let size):
            return UIFont(name: "Courier", size: size)
        case .category(let size):
            return UIFont(name: "Courier-Bold", size: size)
        }
    }
}
