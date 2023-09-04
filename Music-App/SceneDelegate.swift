//
//  SceneDelegate.swift
//  Music-App
//
//  Created by Алексей Орловский on 09.05.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        // Проверяем тип сцены, чтобы убедиться, что это окно сцены
        guard let windowScene = scene as? UIWindowScene else { return }
        
        // Создаем новое окно сцены и связываем его с windowScene
        let newWindow = UIWindow(windowScene: windowScene)
        
        // Проверяем значение isUserLoggedIn
        let isUserLoggedIn = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
        
        // Определяем, какой ViewController должен быть отображен
        let initialViewController = isUserLoggedIn ? UINavigationController(rootViewController:HomeViewController()) : UINavigationController(rootViewController: SignInViewController())
        
        // Устанавливаем initialViewController в качестве корневого ViewController
        newWindow.rootViewController = initialViewController
        
        // Устанавливаем новое окно сцены в качестве основного окна приложения
        window = newWindow
        newWindow.makeKeyAndVisible()
    }
}

