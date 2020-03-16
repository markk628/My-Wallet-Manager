//
//  ViewController.swift
//  Budget
//
//  Created by Mark Kim on 3/16/20.
//  Copyright © 2020 Mark Kim. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    @IBOutlet weak var seg: UISegmentedControl!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBAction func loginBtnPressed(_ sender: Any) {
        if seg.selectedSegmentIndex == 0 {
            login()
        } else if seg.selectedSegmentIndex == 1 {
            signUp()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func login() {
        if self.email.text == "" || self.password.text == "" {
            print("enter sth")
        } else {
            Auth.auth().signIn(withEmail: self.email.text!, password: self.password.text!) { (user, error) in
                if error == nil {
                    print("logged in")
                } else {
                    print("error")
                }
            }
        }
    }
    
    func signUp() {
        if email.text == "" {
            print("error")
        } else {
            Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (user, error) in
                if error == nil {
                    print("Signed up")
                } else {
                    print("error")
                }
            }
        }
    }


}

