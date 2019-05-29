//
//  LoginVC.swift
//  Makerspace
//
//  Created by Rob McMahon on 5/9/19.
//  Copyright © 2019 Rob McMahon. All rights reserved.
// Edited by Tanaka Mazivanhanga May 2019
//

import Foundation
import UIKit
import FirebaseAuth

class LoginVC: UIViewController {
    
    
    //MARK: - Outlet declarations
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var buttonSignIn: UIButton! {
        didSet {
            self.buttonSignIn.layer.cornerRadius = 8
        }
    }
    
    //MARK: - User Interaction Function
    @IBAction func buttonSignInTouched(_ sender: Any?) {
        if let email = emailTextField.text {
            if let password = passwordTextField.text {
                Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                    if let error = error {
                        print("Error Signing in \(error)")
                    }
                    else {
                        print("Successfully signed in as admin!")
                        self.navigate()
                    }
                }
            }
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    //MARK - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        emailTextField.becomeFirstResponder()
    }
    
    
    //MARK - Navigation
    func navigate() {
        let main = UIStoryboard(name: "Main", bundle: nil)
        let createUserPage = main.instantiateViewController(withIdentifier: "CreateUserVC")
        self.present(createUserPage, animated: true, completion: nil)
    }
} //end class


//MARK: - Text Field Delegate
extension LoginVC: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            textField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            textField.resignFirstResponder()
            buttonSignInTouched(nil)
        }
        return true
    }
} //end extension
