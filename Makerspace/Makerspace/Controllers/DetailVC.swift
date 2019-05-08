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
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var roomPicker: UIPickerView!
    @IBOutlet weak var buttonSignIn: UIButton!
    var testvar  = ""
    var user: User?
    var rooms = RoomManager.instance.populateRooms()
    
    override func viewDidLoad() {
        //labelName.text = "This is a real test part 2"
        super.viewDidLoad()
        roomPicker.delegate = self
        roomPicker.dataSource = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        if let user = user{
            labelName.text = user.name
                    }
        
    }
        
    
    //sign in button has been touched
    @IBAction func buttonSignIntouched(_ sender: UIButton) {
        
    }
    
} //end class
extension DetailVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return rooms.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "Room \(rooms[row].roomName)"
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       roomSelected.text = rooms[row].roomName
       
    }
    
    
    
}
