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
    
    
    //create account button has been touched
    @IBAction func createAccountButtonTouched(_ sender: UIButton) {
        if let name = nameTextField.text, let email = emailTextField.text {
            if name != "" || email != "" {
                UserManager.instance.createUser(name: name, email: email)
                
                //alert if user creation is successful
                let alertController = UIAlertController(title: "User Created", message:
                    "Name \(name)", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: {_ in
                    CATransaction.setCompletionBlock({
                        self.tableView.reloadData()
                    })
                }))
                self.present(alertController, animated: true, completion: nil)
                tableView.reloadData()
                
                //reset fields to empty strings
                nameTextField.text = ""
                emailTextField.text = ""
            }
            else {
                let alertController = UIAlertController(title: "Error", message:
                    "Missing Name and/or Email", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
            }
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    //logout admin user, return to home page
    @IBAction func logoutButtonTouched(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            //navigate()
        }
        catch {
            print("Error logging out.")
        }
    }
    
    
    //return to home page
    func navigate() {
        let main = UIStoryboard(name: "Main", bundle: nil)
        let home = main.instantiateViewController(withIdentifier: "HomeViewController")
        self.navigationController?.popToViewController(home, animated: true)
        
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
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            
            UserManager.instance.deleteUser(user: users[indexPath.row])
            users.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
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
