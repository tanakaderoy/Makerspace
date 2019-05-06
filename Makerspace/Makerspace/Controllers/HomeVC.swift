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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    //newUser button has been touched
    @IBAction func newUserButtonTouched(_ sender: CustomButton) {
        if let createAccountVC = storyboard?.instantiateViewController(withIdentifier: "CreateAccountVC") as? CreateAccountVC {
            self.present(createAccountVC, animated: true, completion: nil) //segue to createAccount screen
        }
    }
    
} //end class 
