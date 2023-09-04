//
//  AppDelegate.swift
//  Music-App
//
//  Created by Алексей Орловский on 09.05.2023.
//

import Firebase
import FirebaseAuth
import FirebaseCore
import AVFoundation
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default)
        } catch let error as NSError {
            print("playback failed: \(error)")
        }
        
        // MARK: Reg
        let isUserLoggedIn = UserDefaults.standard.bool(forKey: "isUserLoggedIn")

        let initialViewController = isUserLoggedIn ? HomeViewController() : SignInViewController()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}

