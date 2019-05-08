//
//  HomeViewController.swift
//  Makerspace
//
//  Created by Rob McMahon on 5/7/19.
//  Copyright © 2019 Rob McMahon. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    var users = UserManager.instance.users
    @IBOutlet weak var userTableView: UITableView!
    
    override func viewDidLoad() {
        UserManager.instance.delegate = self
        users = UserManager.instance.loadUsers()
        userTableView.reloadData()
        super.viewDidLoad()
    }
} //end class



//table view datasource / delegate
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell") else {
            preconditionFailure("Can't find reuse id")
        }
        cell.textLabel?.text = users[indexPath.row].name
        cell.detailTextLabel?.text = users[indexPath.row].email
        
        return cell
    }
} //end extension



//user manager delegate
extension HomeViewController: UserManagerDelegate {
    func usersUpdated() {
        users = UserManager.instance.loadUsers()
        print("Delegate Reached")
        self.userTableView.reloadData()
        print(users)
    }
} //end extension
