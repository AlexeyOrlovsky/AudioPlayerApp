//
//  NavigationManeger.swift
//  Music-App
//
//  Created by Алексей Орловский on 09.05.2023.
//

import UIKit

// To display screens. Authorization and Registered

class NavigationManager {
    static let shared = NavigationManager()
    
    // MARK: show Login View
    func showNotAuthorizedUserStage() {
        
        let controller = SignInViewController() // SignIn
        let navigationController = UINavigationController(rootViewController: controller)
        
        let sceneDelegate = UIApplication.shared.connectedScenes
            .first!.delegate as! SceneDelegate
        sceneDelegate.window?.rootViewController = navigationController
        sceneDelegate.window?.makeKeyAndVisible()
    }
    
    // MARK: show Login in View
    func showAuthorizedUserStage() {

        let controller = UINavigationController(rootViewController: HomeViewController())

        let sceneDelegate = UIApplication.shared.connectedScenes
            .first!.delegate as! SceneDelegate

        sceneDelegate.window?.rootViewController = controller
        sceneDelegate.window?.makeKeyAndVisible()
    }
}
