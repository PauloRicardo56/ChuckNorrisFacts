//
//  InitialCoordinator.swift
//  ChuckNorrisFacts
//
//  Created by Paulo Ricardo on 23/12/20.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    var window: UIWindow?
    var navigationController: UINavigationController
    var initialViewModel: TextSearchViewModel
    
    init(window: UIWindow?) {
        self.window = window
        initialViewModel = .init()
        
        let vc = InitialViewController(viewModel: initialViewModel)
        navigationController = .init(rootViewController: vc)
        vc.coordinator = self
    }
    
    func start() {
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func share(url: String) {
        let vc = ShareFactViewController(activityItems: [URL(string: url)!], applicationActivities: nil)
        navigationController.present(vc, animated: true)
    }
}
