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
    
    
    //MARK: Outlet Declarations
    var users = UserManager.instance.realUsers
    var rooms =  RoomManager.instance.rooms
    var filteredUsers = [User]()
    @IBOutlet weak var userTableView: UITableView!
    let searchController = UISearchController(searchResultsController: nil)

    @IBOutlet weak var buttonSignIn: UIButton!
    
    
    //MARK: - VC Lifecycle Functions
    override func viewDidLoad() {
        //Search Bar
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        userTableView.tableHeaderView = searchController.searchBar
        self.definesPresentationContext = true
        
        
        //Other Setup
        UserManager.instance.delegate = self
        users = UserManager.instance.loadUsers()
        rooms = RoomManager.instance.loadRooms()
        updateOnLoad()
        userTableView.reloadData()
        super.viewDidLoad()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        userTableView.reloadData()
    }
    
    
    //MARK: - Navigation
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
    
    
    //updates user status from last use of the app
    func updateOnLoad() {
        for user in users {
            if user.status == true {
                UserNetworkAdaptor.instance.updateUser(user: user)
            }
        }
    }
    
    
    //MARK: - Search Bar Helper Functions
    func searchBarIsEmpty() -> Bool {
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
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        self.searchController.searchBar.endEditing(true)
    }
} //end class



//MARK: - TableView Datasource / Delegate
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
        cell.labelSignIn.layer.masksToBounds = true
        cell.labelSignIn.layer.cornerRadius = 8
        
        if user.status == true {
            cell.buttonSignInSignOut.isHidden = true
            cell.labelSignIn.backgroundColor = UIColor.green
            cell.labelSignIn.text = "Signed In"
            
            cell.labelRoom.text = user.currentRoom
        }
        else {
            cell.buttonSignInSignOut.isHidden = true
            cell.labelSignIn.backgroundColor = UIColor.red
            cell.labelSignIn.text = "Signed Out"
            cell.labelRoom.text = ""
        }
        return cell
    }
} //end extension


//MARK: - Search Results Updating
extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            filteredUsers = users.filter { user in
                return user.name.lowercased().contains(searchText.lowercased())
            }
        }
        else {
            filteredUsers = users
        }
        userTableView.reloadData()
    }
} //end extension



//MARK: - Delegates
extension HomeViewController: UserManagerDelegate {
    func usersUpdated() {
        self.userTableView.reloadData()
    }
    func usersRetrieved() {
        users = UserManager.instance.realUsers
        self.userTableView.reloadData()
    }
} //end extension



extension HomeViewController: UserCellDelegate {
    func didTapSignIn(user: User) {
        if user.status == false {
            performSegue(withIdentifier: "buttonClick", sender: self)
        }
        userTableView.reloadData()
    }
} //end extension



extension HomeViewController: RoomManagerDelegate {
    func roomsRetrieved() {
        rooms = RoomManager.instance.rooms
    }
} //end extension
