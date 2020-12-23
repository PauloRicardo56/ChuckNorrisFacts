//
//  Coordinator.swift
//  ChuckNorrisFacts
//
//  Created by Paulo Ricardo on 23/12/20.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    
    func start()
}
