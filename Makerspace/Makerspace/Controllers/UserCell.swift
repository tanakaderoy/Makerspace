//
//  UserCell.swift
//  Makerspace
//
//  Created by Rob McMahon on 5/8/19.
//  Copyright © 2019 Rob McMahon. All rights reserved.
//

import UIKit

protocol UserCellDelegate {
    func didTapSignIn(user: User)
}

class UserCell: UITableViewCell {

    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var labelRoom: UILabel!
    @IBOutlet weak var buttonSignInSignOut: UIButton!
    
    var delegate: UserCellDelegate?
    
    override func awakeFromNib() {
        buttonSignInSignOut.layer.cornerRadius = 7
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
} //end class
