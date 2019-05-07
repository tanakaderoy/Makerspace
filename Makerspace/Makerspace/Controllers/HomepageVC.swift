//
//  HomepageVC.swift
//  Makerspace
//
//  Created by Rob McMahon on 5/7/19.
//  Copyright © 2019 Rob McMahon. All rights reserved.
//

import Foundation
import UIKit

class HomepageVC: UIViewController {
    var users = [User]()
    
    @IBOutlet var tableView: UITableView!
    
    
    override func viewDidLoad() {
        UserManager.instance.delegate = self
        users = UserManager.instance.loadUsers()
        tableView.reloadData()
        super.viewDidLoad()
    }
    

} //end class

extension HomepageVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
            preconditionFailure("Can't find 'cell'")
        }
        cell.textLabel?.text = users[indexPath.row].name
        print("user names\(users[indexPath.row].name)")
        
        return cell
    }
    
    

} //end extension
extension HomepageVC: UserManagerDelegate {
    
    func usersUpdated() {
        //        users = UserManager.instance.loadUsers()
        // print("Delegate Users\(users)")
        print("Delegate Reached")
        //updateUI()
        print(users)
    }
}
