//
//  InitialCoordinator.swift
//  ChuckNorrisFacts
//
//  Created by Paulo Ricardo on 23/12/20.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get }
    
    func start()
}

class AppCoordinator: Coordinator {
    var window: UIWindow?
    var navigationController: UINavigationController
    var initialViewModel: FactSearchViewModel
    
    init(window: UIWindow?) {
        self.window = window
        initialViewModel = DefaultFactSearchViewModel()
        
        let vc = InitialViewController(viewModel: initialViewModel)
        navigationController = .init(rootViewController: vc)
        vc.coordinator = self
    }
    
    func start() {
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func share(url: String) {
        let vc = UIActivityViewController(activityItems: [URL(string: url)!], applicationActivities: nil)
        navigationController.present(vc, animated: true)
    }
}
