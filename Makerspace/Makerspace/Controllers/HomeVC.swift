//
//  HomeVC.swift
//  Makerspace
//
//  Created by Rob McMahon on 5/6/19.
//  Copyright © 2019 Rob McMahon. All rights reserved.
//

import Foundation
import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var signInTableView: UITableView!
    @IBOutlet weak var signOutTableView: UITableView!
    
    @IBAction func singInButtonTouched(_ sender: CustomButton) {
        
    }
    
    @IBAction func signOutButtonTouched(_ sender: CustomButton) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    //newUser button has been touched
    @IBAction func newUserButtonTouched(_ sender: CustomButton) {
        if let createAccountVC = storyboard?.instantiateViewController(withIdentifier: "CreateAccountVC") as? CreateAccountVC {
            self.present(createAccountVC, animated: true, completion: nil) //segue to createAccount screen
        }
    }
    
} //end class

extension HomeVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == signInTableView {
            return UserManager.instance.users.count // -active users
        }
        else {
            return /*active users - */ UserManager.instance.users.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == signInTableView {
            guard let cell = signInTableView.dequeueReusableCell(withIdentifier: "signinCell") else {
                preconditionFailure("Check reuse ID")
            }
        }
        else {
            guard let cell = signOutTableView.dequeueReusableCell(withIdentifier: "signoutCell") else {
                preconditionFailure("Check reuse ID")
            }
        }
        //blah blah cell
    }
    return cell
    
    
    
} //end extension
