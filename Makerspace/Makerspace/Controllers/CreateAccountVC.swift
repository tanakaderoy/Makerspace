//
//  CreateAccountVC.swift
//  Makerspace
//
//  Created by Rob McMahon on 5/6/19.
//  Copyright © 2019 Rob McMahon. All rights reserved.
//

import Foundation
import UIKit

class CreateAccountVC: UIViewController {
    
    @IBOutlet weak var nameTextField: CustomTextField!
    @IBOutlet weak var emailTextField: CustomTextField!
    @IBOutlet weak var badgeSegment: UISegmentedControl!
    @IBOutlet weak var gradientView: UIView!
    
    
    
    override func viewDidLoad() {
        gradientView.setGradient(colorOne: #colorLiteral(red: 0.9955865741, green: 0.004449881148, blue: 0.04543405771, alpha: 0.5997431507), colorTwo: #colorLiteral(red: 0.7566201091, green: 0.0825580731, blue: 0.1118213311, alpha: 0.950395976))
        super.viewDidLoad()
    }
    
    
    
    @IBAction func createAccountButtonTouched(_ sender: CustomButton) {
        let name = nameTextField.text
        let email = emailTextField.text
        
        if(name != nil) && (email != nil) {
            UserManager.instance.createUser(name: name!, email: email!, status: false)
        }
        else {
            let alert = UIAlertController(title: "Empty Fields", message: "Please enter a value for each field", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        //segue to home screen
        if let homeVC = storyboard?.instantiateViewController(withIdentifier: "HomeVC") as? HomeVC {
            self.present(homeVC, animated: true, completion: nil)
        }
    }
} //end class
