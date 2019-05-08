//
//  DetailVC.swift
//  Makerspace
//
//  Created by Rob McMahon on 5/7/19.
//  Copyright © 2019 Rob McMahon. All rights reserved.
//

import Foundation
import UIKit

class DetailVC: UIViewController {
    
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var roomPicker: UIPickerView!
    @IBOutlet weak var buttonSignIn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //sign in button has been touched
    @IBAction func buttonSignIntouched(_ sender: UIButton) {
        
    }
    
} //end class
