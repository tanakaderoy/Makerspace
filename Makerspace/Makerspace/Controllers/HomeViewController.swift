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
    @IBOutlet weak var userTableView: UITableView!
    
    
    override func viewDidLoad() {
        /* USE THIS TO INITIALLY POPULATE USERS */
//        UserManager.instance.populateRealUsers()
        
        UserManager.instance.delegate = self
        users = UserManager.instance.loadUsers()
        updateOnLoad()
        userTableView.reloadData()
        super.viewDidLoad()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        userTableView.reloadData()
    }
    
    
    //navigate to DetailVC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? DetailVC {
            if let row = userTableView.indexPathForSelectedRow?.row {
                if let user = UserManager.instance.getUserAtIndex(row){
                    vc.user = user
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
} //end class



//table view datasource / delegate
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as? UserCell else {
            preconditionFailure("Can't find reuse id")
        }
        cell.labelName.text = users[indexPath.row].name
        cell.labelEmail?.text = users[indexPath.row].email
        cell.delegate = self
        if users[indexPath.row].status == true {
            cell.buttonSignInSignOut.backgroundColor = UIColor.green
            cell.buttonSignInSignOut.setTitle("Signed In", for: .normal)
            cell.labelRoom.text = users[indexPath.row].currentRoom
        }
        else {
            cell.buttonSignInSignOut.backgroundColor = UIColor.red
            cell.buttonSignInSignOut.setTitle("Signed Out", for: .normal)
            cell.labelRoom.text = ""
        }
        
        return cell
    }
} //end extension



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
