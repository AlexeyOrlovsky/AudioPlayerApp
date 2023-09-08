//
//  NavigationManeger.swift
//  Music-App
//
//  Created by Алексей Орловский on 09.05.2023.
//

import UIKit

class NavigationManager {
    static let shared = NavigationManager()
    
    /// Show Login View
    func showNotAuthorizedUserStage() {
        
        let controller = SignInViewController()
        let navigationController = UINavigationController(rootViewController: controller)
        
        let sceneDelegate = UIApplication.shared.connectedScenes
            .first!.delegate as! SceneDelegate
        sceneDelegate.window?.rootViewController = navigationController
        sceneDelegate.window?.makeKeyAndVisible()
    }
    
    /// Show Login in View
    func showAuthorizedUserStage() {

        let controller = UINavigationController(rootViewController: HomeViewController())

        let sceneDelegate = UIApplication.shared.connectedScenes
            .first!.delegate as! SceneDelegate
        sceneDelegate.window?.rootViewController = controller
        sceneDelegate.window?.makeKeyAndVisible()
    }
}
