//
//  SignUpViewController.swift
//  Music-App
//
//  Created by Алексей Орловский on 09.05.2023.
//

import SwiftUI
import UIKit
import Firebase
import FirebaseAuth
import SnapKit

class SignUpViewController: UIViewController {
    
    // MARK: Add elements on scene
    let label: UILabel = {
        let label = UILabel()
        label.text = "Create"
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
    
    let repeatPassword: UITextField = {
        let repeatField = UITextField()
        repeatField.isSecureTextEntry = true
        repeatField.backgroundColor = UIColor(red: 35/255, green: 35/255, blue: 35/255, alpha: 1)
        repeatField.layer.cornerRadius = 10
        repeatField.font = .boldSystemFont(ofSize: 22)
        repeatField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)
        repeatField.textColor = UIColor(red: 121/255, green: 121/255, blue: 121/255, alpha: 1)
        repeatField.attributedPlaceholder = NSAttributedString(
            string: "Repeat password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 87/255, green: 87/255, blue: 87/255, alpha: 1)])
        return repeatField
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
        view.backgroundColor = UIColor(red: 15/255, green: 15/255, blue: 15/255, alpha: 1)
        view.addSubview(label)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(repeatPassword)
        view.addSubview(enterButton)
        
        enterButton.addTarget(self, action: #selector(enterButtonTarget), for: .touchUpInside)
    }
    
    // MARK: Constraints for elements
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(200)
        }
        
        emailField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(272)
            make.width.equalTo(320)
            make.height.equalTo(50)
        }
        
        passwordField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(334)
            make.width.equalTo(320)
            make.height.equalTo(50)
        }
        
        repeatPassword.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(396)
            make.width.equalTo(320)
            make.height.equalTo(50)
        }
        
        enterButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(486)
            make.width.equalTo(160)
            make.height.equalTo(50)
        }
    }
}

// MARK: Target button

extension SignUpViewController {
    @objc func enterButtonTarget() {
        print("Enter button tapped")
        
        guard let email = emailField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty,
                let passwordRepeat = repeatPassword.text, !passwordRepeat.isEmpty
        else {
            print("Missimg field data")
            showInvalidRegister()
            return
        }
        
        Firebase.Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self] result, error in
            guard let strongSelf = self else {
                return
            }
            
            guard error == nil else {
                // show account creation
                strongSelf.showLoginIn(email: email, password: password)
                return
            }
            print("You have signed in ")
            self?.dismiss(animated: true)
        })
        
        guard passwordField.text == repeatPassword.text else {
            showMatchPass()
            return
        }
        if passwordField.text!.count < 6 {
            showMinimumCharacters()
            return
        }
        return
    }
}

// MARK: Alert on registration error

extension SignUpViewController {
    func showMinimumCharacters() {
        let alert = UIAlertController(title: "Password is too short!", message: "the minimum number of characters in the password is 6, the more complex your password, the more secure your account", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    func showInvalidRegister() {
        let alert = UIAlertController(title: "Not all fields are filled!", message: "Fill in the fields", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
    func showMatchPass() {
        let alert = UIAlertController(title: "Fields do not match", message: "The password and repeat password fields do not match. check if the characters are entered correctly", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
    func showLoginIn(email: String, password: String) {
        let alert = UIAlertController(title: "Create account",
                                      message: "Would you like to create an account",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Create",
                                      style: .default,
                                      handler: {_ in

            Firebase.Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in

                guard let _ = self else {
                    return
                }
                // Условие создающее аккаунт
                guard error == nil else {
                    // show account creation
                    print("Account creation failed")
                    return
                }
                // В этом блоке создана переменная userId = которая передается в document при обращении к firebase
                let userId = result?.user.uid
                let email = email
                let data: [String: Any] = ["email": email]
                Firestore.firestore().collection("users").document(userId!).setData(data)
                // Если аккаун создался
                
                print("You have signed in")
                self?.dismiss(animated: true)
            }

        }))
        alert.addAction(UIAlertAction(title: "Cancel",
                                      style: .cancel))

        present(alert, animated: true)
    }
}

struct SignUpCanvas: PreviewProvider {
    static var previews: some View {
        conteinerView().ignoresSafeArea(.all)
    }
    
    struct conteinerView: UIViewControllerRepresentable {
        
        func makeUIViewController(context: Context) -> SignUpViewController {
            return SignUpViewController()
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            //
        }
    }
}

