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
    var user: User?
    var rooms = RoomManager.instance.populateRooms()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let user = user {
            signInButtonStatus(user: user)
        }
        buttonSignIn.layer.cornerRadius = 8
        picker.delegate = self
        picker.dataSource = self
        roomTextfield.inputView = picker
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        if let user = user {
            if user.status == true{
                labelName.text = user.name
                roomSelected.text = user.currentRoom
                roomTextfield.isHidden = true
                signInButtonStatus(user: user)
            }
            else {
                labelName.text = user.name
                signInButtonStatus(user: user)
            }
        }
    }
    
    
    //updates startTime of selected user
    func timeStampIn() {
        if let user = user  {
            let currentDateTime = Date()
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            formatter.dateStyle = .none
            let alertController = UIAlertController(title: "Signed In", message:
                "Signed In \(formatter.string(from: currentDateTime))", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: {_ in
                CATransaction.setCompletionBlock({
                    self.navigationController?.popViewController(animated: true)
                })
            }))
            self.present(alertController, animated: true, completion: nil)
            print("Signed In \(formatter.string(from: currentDateTime))")
            user.startTime = currentDateTime
        }
    }
    
    
    //updates endTime of selected user
    func timeStampOut() {
        if let user = user {
            let currentDateTime = Date()
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            formatter.dateStyle = .none
            let alertController = UIAlertController(title: "Signed Out", message:
                "Signed Out \(formatter.string(from: currentDateTime))", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: {_ in
                CATransaction.setCompletionBlock({
                    self.navigationController?.popViewController(animated: true)
                })
            }))
            self.present(alertController, animated: true, completion: nil)
            print("Signed Out \(formatter.string(from: currentDateTime))")
            user.endTime = currentDateTime
        }
    }
    
    
    //clears keyboard if user touches outside
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    //sign in button has been touched
    @IBAction func buttonSignIntouched(_ sender: UIButton) {
        if let user = user {
            //user is not signed in
            if user.status == false {
                timeStampIn()
                user.currentRoom = roomTextfield.text
                UserManager.instance.updateUserStatus(user: user)                                   //updates user status
                print(user.name, user.status, user.currentRoom!, user.email)
                RoomManager.instance.incrementTotalUsers(room: user.currentRoom!)                   //updates total users
                RoomManager.instance.updateUniqueUsers(room: user.currentRoom!, email: user.email)  //updates unique users
            }
            //user is signed in
            else {
                timeStampOut()
                UserManager.instance.updateUserStatus(user: user)
                user.currentRoom = roomTextfield.text
                print(user.name, user.status, user.currentRoom!, user.email)
            }
            signInButtonStatus(user: user)         //update button title
        }
        else {
            print("No user found")
        }
    }
    
    
    //updates button title
    func signInButtonStatus(user: User) {
        if user.status == true {
            buttonSignIn.setTitle("Sign Out", for: .normal)
        }
        else {
            buttonSignIn.setTitle("Sign In", for: .normal)
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
