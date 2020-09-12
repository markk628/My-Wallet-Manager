//
//  LoginViewController.swift
//  Budget
//
//  Created by Mark Kim on 3/16/20.
//  Copyright © 2020 Mark Kim. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    let appLabel: UILabel = {
        let appLabel = UILabel()
        appLabel.text = "My Wallet Manager"
        appLabel.font = .boldSystemFont(ofSize: 19)
        appLabel.textAlignment = .center
        appLabel.translatesAutoresizingMaskIntoConstraints = false
        return appLabel
    }()
    
    let seg: UISegmentedControl = {
        let segmentItems = ["Log In", "Sign Up"]
        let seg = UISegmentedControl(items: segmentItems)
        seg.selectedSegmentIndex = 0
        seg.translatesAutoresizingMaskIntoConstraints = false
        return seg
    }()
    
    let email: UITextField = {
        let email = UITextField()
        email.placeholder = "Email"
        email.font = .systemFont(ofSize: 14)
        email.translatesAutoresizingMaskIntoConstraints = false
        return email
    }()
    
    let password: UITextField = {
        let password = UITextField()
        password.placeholder = "Password"
        password.font = .systemFont(ofSize: 14)
        password.translatesAutoresizingMaskIntoConstraints = false
        return password
    }()
    
    let logInButton: UIButton = {
        let logInBtn = UIButton()
        logInBtn.backgroundColor = .blue
        logInBtn.layer.cornerRadius = 10
        logInBtn.setTitle("👉👉👉", for: UIControl.State.normal)
        logInBtn.titleLabel?.font = .systemFont(ofSize: 15)
        logInBtn.translatesAutoresizingMaskIntoConstraints = false
        return logInBtn
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        password.isSecureTextEntry = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLogInVC()
        view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        logInButton.addTarget(self, action: #selector(loginBtnPressed(_:)), for: .touchUpInside)
    }
    
    @objc func loginBtnPressed(_ sender: UIButton) {
        if seg.selectedSegmentIndex == 0 {
            login()
        } else if seg.selectedSegmentIndex == 1 {
            signUp()
        }
    }
    
    func setUpLogInVC() {
        view.addSubview(appLabel)
        view.addSubview(seg)
        view.addSubview(email)
        view.addSubview(password)
        view.addSubview(logInButton)
        
        NSLayoutConstraint.activate([
            appLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            appLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            appLabel.heightAnchor.constraint(equalToConstant: 85),
            appLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height * 0.15),
            
            seg.heightAnchor.constraint(equalToConstant: 30),
            seg.topAnchor.constraint(equalTo: appLabel.bottomAnchor, constant: 50),
            seg.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            seg.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            email.heightAnchor.constraint(equalToConstant: 30),
            email.topAnchor.constraint(equalTo: seg.bottomAnchor, constant: 15),
            email.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            email.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            password.heightAnchor.constraint(equalToConstant: 30),
            password.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 15),
            password.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            password.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            logInButton.heightAnchor.constraint(equalToConstant: 30),
            logInButton.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 15),
            logInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 150),
            logInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -150)
        ])
    }
    
    func login() {
        if self.email.text == "" || self.password.text == "" {
            showErrorAlert(title: "Login Error", message: "Enter email/password")
        } else {
            Auth.auth().signIn(withEmail: self.email.text!, password: self.password.text!) { [weak self] user, error in
                guard let strongSelf = self else { return }
                
                if error == nil {
                    UserDefaults.standard.set(user?.user.uid, forKey: "UserId")
                    let tabBarVC = CAndETabBarController()
                    strongSelf.navigationController?.initRootViewController(vc: tabBarVC, navbarHidden: false)
                } else {
                    self?.showErrorAlert(title: "Login Error", message: "Incorrect email/password")
                }
            }
        }
    }
    
    func signUp() {
        if email.text == "" {
            showErrorAlert(title: "Register", message: "Enter email/password")
        } else {
            Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (user, error) in
                if error == nil {
                    Auth.auth().signIn(withEmail: self.email.text!, password: self.password.text!) { [weak self] user, error in
                        guard let strongSelf = self else { return }
                        
                        if error == nil {
                            UserDefaults.standard.set(user?.user.uid, forKey: "UserId")
                            let tabBarVC = CAndETabBarController()
                            strongSelf.navigationController?.initRootViewController(vc: tabBarVC, navbarHidden: false)
                        } else {
                            self?.showErrorAlert(title: "Login Error", message: "Incorrect email/password")
                        }
                    }
                }
            }
        }
    }
    
    func showErrorAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}

