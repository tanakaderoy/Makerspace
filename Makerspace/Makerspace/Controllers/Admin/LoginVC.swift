//
//  LoginVC.swift
//  Makerspace
//
//  Created by Rob McMahon on 5/9/19.
//  Copyright © 2019 Rob McMahon. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

class LoginVC: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var buttonSignIn: UIButton!
    
    
    //Navigation
    func navigate() {
        let main = UIStoryboard(name: "Main", bundle: nil)
        let createUserPage = main.instantiateViewController(withIdentifier: "CreateUserVC")
        self.present(createUserPage, animated: true, completion: nil)
    }
    
    
    //sign in has been tapped
    @IBAction func buttonSignInTouched(_ sender: UIButton) {
        if let email = emailTextField.text {
            if let password = passwordTextField.text {
                Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                    if let error = error {
                        print("Error Signing in \(error)")
                        //create an alert with the error message
                    }
                    else {
                        print("Successfully signed in as admin!")
                        self.navigate()
                    }
                }
            }
            else {
                //create an alert, password field not entered
            }
        }
        else {
            //create an alert, email field not entered
        }
    }
    
    
    override func viewDidLoad() {
        buttonSignIn.layer.cornerRadius = 8
        super.viewDidLoad()
    }
    
} //end class
