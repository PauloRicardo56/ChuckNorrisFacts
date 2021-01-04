//
//  Colors.swift
//  ChuckNorrisFacts
//
//  Created by Paulo Ricardo on 31/12/20.
//

import Foundation
import UIKit

enum Colors: String {
    case background
    case foreground
    case font
    case orange
    
    var uiColor: UIColor? {
        UIColor(named: rawValue)
    }
    
    var cgColor: CGColor? {
        uiColor?.cgColor
    }
}
