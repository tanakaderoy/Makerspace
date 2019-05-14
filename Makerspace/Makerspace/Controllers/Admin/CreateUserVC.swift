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
    
    var filteredUsers = [User]()
    
    //Search bar
    let searchController = UISearchController(searchResultsController: nil)
    
    
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
        
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
        
        createAccountButton.layer.cornerRadius = 8
        UserManager.instance.delegate = self
        users = UserManager.instance.loadUsers()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    //SEARCH BAR FUNCTIONS
    
    //returns true if the text is empty or nil
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    
    func filterContentsForSearchText(_ searchText: String, scope: String = "All") {
        filteredUsers = users.filter({ (users) -> Bool in
            return users.name.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
    
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
} //end class


//table view
extension CreateUserVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredUsers.count
        }
        else {
            return users.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as? UserCell else {
            preconditionFailure("Can't find reuse ID!")
        }
        let user: User
        
        if isFiltering() {
            user = filteredUsers[indexPath.row]
        }
        else {
            user = users[indexPath.row]
        }
        cell.labelName.text = user.name
        cell.labelEmail.text = user.email
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


//user manager delegate
extension CreateUserVC: UserManagerDelegate {
    func usersUpdated() {
        self.tableView.reloadData()
    }
    func usersRetrieved() {
        users = UserManager.instance.realUsers
        self.tableView.reloadData()
    }
} //end extension


//search bar
extension CreateUserVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            filteredUsers = users.filter { user in
                return user.name.lowercased().contains(searchText.lowercased())
            }
            
        } else {
            filteredUsers = users
        }
        tableView.reloadData()
    }
} //end extension
