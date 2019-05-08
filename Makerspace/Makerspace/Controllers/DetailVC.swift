//
//  DetailVC.swift
//  Makerspace
//
//  Created by Rob McMahon on 5/7/19.
//  Edited by Tanaka Mazivanhanga May 2019
//  Copyright © 2019 Rob McMahon, Tanaka Mazivanhanga. All rights reserved.
//

import Foundation
import UIKit

class DetailVC: UIViewController {
    
    @IBOutlet weak var roomSelected: UILabel!
    
    @IBOutlet weak var roomTextfield: UITextField!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var buttonSignIn: UIButton!
    
    
    
    var picker = UIPickerView()
    
    
    var testvar  = ""
    var user: User?
    var rooms = RoomManager.instance.populateRooms()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonSignIn.layer.cornerRadius = 8
        picker.delegate = self
        picker.dataSource = self
        roomTextfield.inputView = picker
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        if let user = user {
            labelName.text = user.name
        }
    }
        
    
    //sign in button has been touched
    @IBAction func buttonSignIntouched(_ sender: UIButton) {
        if let user = user {
            if roomTextfield.text == nil {
                print("Please select the room you are going to use")
            }
            else {
                user.currentRoom = roomTextfield.text
                UserManager.instance.updateUserStatus(user: user)
                print(user.name, user.status, user.currentRoom!, user.email)
            }
        }
        else {
            print("No user found")
        }
    }
    
} //end class

//extension for picker, located in text field
extension DetailVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return rooms.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(rooms[row].roomName)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        roomTextfield.text = rooms[row].roomName
        roomSelected.text = rooms[row].roomName
        self.view.endEditing(false)
    }
} //end extension
