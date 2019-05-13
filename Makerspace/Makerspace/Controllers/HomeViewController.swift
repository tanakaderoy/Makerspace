//
//  HomeViewController.swift
//  Makerspace
//
//  Created by Rob McMahon on 5/7/19.
// Edited by Tanaka Mazivanhanga May 2019
//  Copyright © 2019 Rob McMahon, Tanaka Mazivanhanga. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    
    var users = UserManager.instance.realUsers
    var filteredUsers = [User]()
    @IBOutlet weak var userTableView: UITableView!
    
    
    //Search bar
    let searchController = UISearchController(searchResultsController: nil)
    //    var resultsController = UITableViewController()
    
    
    override func viewDidLoad() {
        //search controller setup
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        userTableView.tableHeaderView = searchController.searchBar
        self.definesPresentationContext = true
        //        searchController.searchResultsUpdater = self
        //
        //        searchController.obscuresBackgroundDuringPresentation = false
        //        searchController.dimsBackgroundDuringPresentation = false
        //        searchController.searchBar.placeholder = "Search Users"
        //        navigationItem.searchController = searchController
        //        definesPresentationContext = true
        
        //        userTableView.tableHeaderView = searchController.searchBar
        //        searchController.searchResultsUpdater = self
        //
        //        resultsController.tableView.delegate = self
        //        resultsController.tableView.dataSource = self
        
        
        /* USE THIS TO INITIALLY POPULATE USERS */
        //        UserManager.instance.populateRealUsers()
        
        UserManager.instance.delegate = self
        users = UserManager.instance.loadUsers()
        updateOnLoad()
        userTableView.reloadData()
        super.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        self.searchController.searchBar.endEditing(true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        userTableView.reloadData()
    }
    
    
    //navigate to DetailVC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? DetailVC {
            
            if let row = userTableView.indexPathForSelectedRow?.row {
                if isFiltering() {
                    vc.user = filteredUsers[row]
                }
                else {
                    if let user = UserManager.instance.getUserAtIndex(row){
                        vc.user = user
                        
                    }
                }
            }
          
        }
    }
    
    
    func updateOnLoad() {
        for user in users {
            if user.status == true {
                UserNetworkAdaptor.instance.updateUser(user: user)
            }
        }
    }
    
    
    //SEARCH FUNCTIONS
    func searchBarIsEmpty() -> Bool {
        //returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    
    func filterContentsForSearchText(_ searchText: String, scope: String = "All") {
        filteredUsers = users.filter({ (users) -> Bool in
            return users.name.lowercased().contains(searchText.lowercased())
        })
        userTableView.reloadData()
    }
    
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
} //end class



//table view datasource / delegate
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
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
            preconditionFailure("Can't find reuse id")
        }
        let user: User
        if isFiltering() {
            user = filteredUsers[indexPath.row]
        }
        else {
            user = users[indexPath.row]
        }
        cell.labelName.text = user.name
        cell.labelEmail?.text = user.email
        cell.delegate = self
        if user.status == true {
            cell.buttonSignInSignOut.backgroundColor = UIColor.green
            cell.buttonSignInSignOut.setTitle("Signed In", for: .normal)
            cell.labelRoom.text = user.currentRoom
        }
        else {
            cell.buttonSignInSignOut.backgroundColor = UIColor.red
            cell.buttonSignInSignOut.setTitle("Signed Out", for: .normal)
            cell.labelRoom.text = ""
        }
        return cell
    }
} //end extension


extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        //        filterContentsForSearchText(searchController.searchBar.text!)
        //        userTableView.reloadData()
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            filteredUsers = users.filter { user in
                return user.name.lowercased().contains(searchText.lowercased())
            }
            
        } else {
            filteredUsers = users
        }
        userTableView.reloadData()
    }
    
    
}


//user manager delegate
extension HomeViewController: UserManagerDelegate {
    func usersUpdated() {
        self.userTableView.reloadData()
    }
    func usersRetrieved() {
        users = UserManager.instance.realUsers
        self.userTableView.reloadData()
    }
} //end extension



//user cell delegate
extension HomeViewController: UserCellDelegate {
    func didTapSignIn(user: User) {
        if user.status == false {
            performSegue(withIdentifier: "buttonClick", sender: self)
        }
        userTableView.reloadData()
    }
} //end extension
