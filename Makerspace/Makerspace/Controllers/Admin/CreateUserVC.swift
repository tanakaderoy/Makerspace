//
//  CreateUserVC.swift
//  Makerspace
//
//  Created by Rob McMahon on 5/9/19.
//  Copyright © 2019 Rob McMahon. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

class CreateUserVC: UIViewController {
    
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var users = UserManager.instance.realUsers
    
    @IBAction func createAccountButtonTouched(_ sender: UIButton) {
        
    }
    
    //logout admin user, return to home page
    @IBAction func logoutButtonTouched(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            navigate()
        }
        catch {
            print("Error logging out.")
        }
    }
    
    
    //return to home page
    func navigate() {
        let main = UIStoryboard(name: "Main", bundle: nil)
        let home = main.instantiateViewController(withIdentifier: "HomeViewController")
        self.present(home, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createAccountButton.layer.cornerRadius = 8
        UserManager.instance.delegate = self
        users = UserManager.instance.loadUsers()
        print(users[0].name)
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
} //end class

extension CreateUserVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as? UserCell else {
            preconditionFailure("Can't find reuse ID!")
        }
        
        cell.labelName.text = users[indexPath.row].name
        cell.labelEmail.text = users[indexPath.row].email
        cell.delegate = self as? UserCellDelegate
        
        return cell
    }
} //end extension

extension CreateUserVC: UserManagerDelegate {
    func usersUpdated() {
        self.tableView.reloadData()
    }
    func usersRetrieved() {
        users = UserManager.instance.realUsers
        self.tableView.reloadData()
    }
} //end extension
