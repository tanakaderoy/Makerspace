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
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func updateUI() {
        tableView.reloadData()
    }
} //end class

extension HomepageVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserManager.instance.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
            preconditionFailure("Error finding reuse ID")
        }
        cell.textLabel?.text = UserManager.instance.loadUsers()[indexPath.row].name
        cell.detailTextLabel?.text = UserManager.instance.loadUsers()[indexPath.row].email
        
        return cell
    }
} //end extension
