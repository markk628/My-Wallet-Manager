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
    
//    @IBOutlet weak var seg: UISegmentedControl!
//    @IBOutlet weak var email: UITextField!
//    @IBOutlet weak var password: UITextField!
//    @IBOutlet weak var loginButton: UIButton!
//    @IBOutlet weak var statusLabel: UILabel!
//    @IBAction func loginBtnPressed(_ sender: Any) {
//        if seg.selectedSegmentIndex == 0 {
//            login()
//        } else if seg.selectedSegmentIndex == 1 {
//            signUp()
//        }
//    }
    
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
        email.translatesAutoresizingMaskIntoConstraints = false
        return email
    }()
    
    let password: UITextField = {
        let password = UITextField()
        password.placeholder = "Password"
        password.translatesAutoresizingMaskIntoConstraints = false
        return password
    }()
    
    let logInButton: UIButton = {
        let logInBtn = UIButton()
        logInBtn.setTitle("👉👉👉", for: UIControl.State.normal)
        logInBtn.translatesAutoresizingMaskIntoConstraints = false
        return logInBtn
    }()
    
    let statusLabel: UILabel = {
        let statusLabel = UILabel()
        statusLabel.text = "It's ok we all spend more than we should"
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
        // Do any additional setup after loading the view.
    }
    
    func login() {
        if self.email.text == "" || self.password.text == "" {
            statusLabel.text = "Enter Email/Password"
        } else {
            Auth.auth().signIn(withEmail: self.email.text!, password: self.password.text!) { (user, error) in
                if error == nil {
                    self.statusLabel.text = "Hello"
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

