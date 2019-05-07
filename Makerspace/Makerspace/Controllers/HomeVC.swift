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
    @IBOutlet weak var gradientView: UIView!
    var users = UserManager.instance.users //reference to the array of users in UserManager
    
    
    
    override func viewDidLoad() {
        gradientView.setGradient(colorOne: #colorLiteral(red: 0.9955865741, green: 0.004449881148, blue: 0.04543405771, alpha: 0.5997431507), colorTwo: #colorLiteral(red: 0.7566201091, green: 0.0825580731, blue: 0.1118213311, alpha: 0.950395976))
        signInTableView.dataSource = self
        signOutTableView.dataSource = self
        UserManager.instance.delegate = self
        users = UserManager.instance.loadUsers()

       
        updateUI()
        super.viewDidLoad()
    }
    
    
    func updateUI() {
        signInTableView.reloadData()
        signOutTableView.reloadData()
//        print("Update UI users \(users)")
        
//        print(users[0])
    }
    
    
    //newUser button has been touched
    @IBAction func newUserButtonTouched(_ sender: CustomButton) {
        if let createAccountVC = storyboard?.instantiateViewController(withIdentifier: "CreateAccountVC") as? CreateAccountVC {
            self.present(createAccountVC, animated: true, completion: nil)      //segue to createAccount screen
        }
    }
    
    //sign in button touched
    @IBAction func singInButtonTouched(_ sender: CustomButton) {
        
    }
    
    //sign out button touched
    @IBAction func signOutButtonTouched(_ sender: CustomButton) {
        
    }
} //end class


extension HomeVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == signInTableView {
            return UserManager.instance.nonActiveUsers(users: users).count      //number of inactive users, users who can sign in
        }
        else {
            return UserManager.instance.activeUsers(users: users).count         //number of active users, users who can sign out
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Sign in table view
        if tableView == signInTableView {
            guard let cell = signInTableView.dequeueReusableCell(withIdentifier: "signinCell") else {
                preconditionFailure("Check reuse ID")
            }
            if UserManager.instance.nonActiveUsers(users: users).count > 0 {
                let user = UserManager.instance.nonActiveUsers(users: UserManager.instance.users)[indexPath.row]
                cell.textLabel?.text = user.name
                cell.detailTextLabel?.text = user.email
                return cell
            }
            else {
                cell.textLabel?.text = "Currently, every user is active"
                return cell
            }
        }
        //Sign out tableview
        else {
            guard let cell = signOutTableView.dequeueReusableCell(withIdentifier: "signoutCell") else {
                preconditionFailure("Check reuse ID")
            }
            if UserManager.instance.activeUsers(users: users).count > 0 {
                let user = UserManager.instance.activeUsers(users: users)[indexPath.row]
                cell.textLabel?.text = user.name
                cell.detailTextLabel?.text = user.email
                return cell
            }
            else {
                cell.textLabel?.text = "Currently, there are no active users"
                return cell
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(indexPath.row)
        if tableView == signInTableView {
            print(UserManager.instance.nonActiveUsers(users: users)[indexPath.row])
        }
        else {
            print(UserManager.instance.activeUsers(users: users)[indexPath.row])
        }
    }
} //end extension

extension HomeVC: UserManagerDelegate {
    
    func usersUpdated() {
//        users = UserManager.instance.loadUsers()
       // print("Delegate Users\(users)")
        print("Delegate Reached")
        updateUI()
        print(users)
    }
}
