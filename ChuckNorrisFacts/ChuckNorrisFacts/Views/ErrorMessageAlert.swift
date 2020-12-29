//
//  ErrorMessage.swift
//  ChuckNorrisFacts
//
//  Created by Paulo Ricardo on 25/12/20.
//

import Foundation
import UIKit

class ErrorMessageAlert: UIAlertController {
    
    init(with error: APIErrorMessage?) {
        super.init(nibName: nil, bundle: nil)
        title = "Chuck Norris API ERROR"
        message = error?.message ?? ""
        
        addAction(.init(title: "OK", style: .default))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
