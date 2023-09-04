//
//  SignInViewController.swift
//  Music-App
//
//  Created by Алексей Орловский on 09.05.2023.
//

import SwiftUI
import UIKit
import Firebase
import FirebaseAuth
import SnapKit

class SignInViewController: UIViewController {
    
    // MARK: Add elements on scene
    let label: UILabel = {
        let label = UILabel()
        label.text = "Sign in"
        label.textColor = UIColor(red: 207/255, green: 207/255, blue: 207/255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 22, weight: .black)
        return label
    }()
    
    let emailField: UITextField = {
        let emailField = UITextField()
        emailField.backgroundColor = UIColor(red: 35/255, green: 35/255, blue: 35/255, alpha: 1)
        emailField.layer.cornerRadius = 10
        emailField.font = .boldSystemFont(ofSize: 22)
        emailField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)
        emailField.textColor = UIColor(red: 121/255, green: 121/255, blue: 121/255, alpha: 1)
        emailField.attributedPlaceholder = NSAttributedString(
            string: "Email",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 121/255, green: 121/255, blue: 121/255, alpha: 1)])
        return emailField
    }()
    
    let passwordField: UITextField = {
        let passField = UITextField()
        passField.isSecureTextEntry = true
        passField.backgroundColor = UIColor(red: 35/255, green: 35/255, blue: 35/255, alpha: 1)
        passField.layer.cornerRadius = 10
        passField.font = .boldSystemFont(ofSize: 22)
        passField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)
        passField.textColor = UIColor(red: 121/255, green: 121/255, blue: 121/255, alpha: 1)
        passField.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 121/255, green: 121/255, blue: 121/255, alpha: 1)])
        return passField
    }()
    
    let enterButton: UIButton = {
        let button = UIButton()
        button.setTitle("Enter", for: .normal)
        button.setTitleColor(UIColor(red: 207/255, green: 207/255, blue: 207/255, alpha: 1), for: .normal)
        button.backgroundColor = UIColor(red: 35/255, green: 35/255, blue: 35/255, alpha: 1)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .black)
        return button
    }()
    
//    let googleButton: UIButton = {
//        let button = UIButton()
//        button.setImage(UIImage(named: "googleButton"), for: .normal)
//        return button
//    }()
    
    let createButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create", for: .normal)
        button.setTitleColor(UIColor(red: 207/255, green: 207/255, blue: 207/255, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return button
    }()
    
    // MARK: Add object on View, and target for button
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 11/255, green: 11/255, blue: 11/255, alpha: 1)
        view.addSubview(label)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(enterButton)
        //view.addSubview(googleButton)
        view.addSubview(createButton)
        
        enterButton.addTarget(self, action: #selector(enterButtonTarget), for: .touchUpInside)
        createButton.addTarget(self, action: #selector(actionButtonTarget), for: .touchUpInside)
    }
    
    // MARK: Constraints for elements

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(266)
        }
        
        emailField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(338)
            make.width.equalTo(320)
            make.height.equalTo(50)
        }
        
        passwordField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(400)
            make.width.equalTo(320)
            make.height.equalTo(50)
        }
        
        enterButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(486)
            make.width.equalTo(160)
            make.height.equalTo(50)
        }
        
//        googleButton.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
//            make.top.equalToSuperview().inset(560)
//        }
        
        createButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(660)
        }
    }
}

// MARK: Target button
extension SignInViewController {
    
    // Ection button
    @objc func actionButtonTarget() {
        present(SignUpViewController(), animated: true)
    }
    
    // Enter button
    // MARK: Conect registration with Firebase
    @objc private func enterButtonTarget() {
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let email = emailField.text, let password = passwordField.text,
              !email.isEmpty, !password.isEmpty, password.count >= 6 else {
            showEmptyFields()
            return
        }
        
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { authResults, error in
            guard let result = authResults, error == nil else {
                self.showInvalidLogin()
                print("Failed to log in user with email: \(email)")
                return
            }
            
            _ = result.user
            UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
            NavigationManager.shared.showAuthorizedUserStage()
        }
    }
}

// MARK: Alert on login error

extension SignInViewController {
    func showEmptyFields() {
        let alert = UIAlertController(title: "Empty!", message: "Fill in all the fields. Email and password", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true)
        
    }
    
    func showInvalidLogin() {
        let alert = UIAlertController(title: "This account does not exist!", message: "This account does not exist, check the data or create a new account", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
}

struct SignInCanvas: PreviewProvider {
    static var previews: some View {
        conteinerView().ignoresSafeArea(.all)
    }
    
    struct conteinerView: UIViewControllerRepresentable {
        
        func makeUIViewController(context: Context) -> SignInViewController {
            return SignInViewController()
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            //
        }
    }
}

