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
        logInBtn.setTitle("👉👉👉", for: UIControl.State.normal)
        logInBtn.titleLabel?.font = .systemFont(ofSize: 15)
        logInBtn.translatesAutoresizingMaskIntoConstraints = false
        return logInBtn
    }()
    
    let statusLabel: UILabel = {
        let statusLabel = UILabel()
        statusLabel.text = "It's ok we all spend more than we should"
        statusLabel.font = .systemFont(ofSize: 17)
        statusLabel.textAlignment = .center
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        return statusLabel
    }()
    
    @objc func loginBtnPressed(_ sender: UIButton) {
        if seg.selectedSegmentIndex == 0 {
            login()
        } else if seg.selectedSegmentIndex == 1 {
            signUp()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        password.isSecureTextEntry = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLogInVC()
    }
    
    func setUpLogInVC() {
        view.addSubview(appLabel)
        view.addSubview(seg)
        view.addSubview(email)
        view.addSubview(password)
        view.addSubview(logInButton)
        view.addSubview(statusLabel)
        
        NSLayoutConstraint.activate([
            appLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            appLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            appLabel.heightAnchor.constraint(equalToConstant: 85),
            appLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height * 0.25),
            
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
            logInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            logInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            statusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            statusLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            statusLabel.heightAnchor.constraint(equalToConstant: 32),
            statusLabel.topAnchor.constraint(equalTo: logInButton.bottomAnchor, constant: 15),
        ])
    }
    
    func login() {
        if self.email.text == "" || self.password.text == "" {
            statusLabel.text = "Enter Email/Password"
        } else {
            Auth.auth().signIn(withEmail: self.email.text!, password: self.password.text!) { (user, error) in
                if error == nil {
                    self.statusLabel.text = "Hello"
                    
                    
                    
                    //must change after deleting main
                    
                    self.performSegue(withIdentifier: "loggedIn", sender: self)
                    
                    
                    
                    
                    
                } else {
                    self.statusLabel.text = "Incorrect Email/Password"
                }
            }
        }
    }
    
    func signUp() {
        if email.text == "" {
            statusLabel.text = "Enter Email/Password"
        } else {
            Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (user, error) in
                if error == nil {
                    self.statusLabel.text = "Signed Up"
                    self.seg.selectedSegmentIndex = 0
                } else {
                    self.statusLabel.text = "Enter Email/Password"
                }
            }
        }
    }
}

