//
//  AddFriendTableViewCell.swift
//  halfstep
//
//  Created by Khoi Khoi Viet Le on 12/8/17.
//  Copyright © 2017 CS 147. All rights reserved.
//

import UIKit

class AddFriendTableViewCell: UITableViewCell {
    
    weak var cellDelegate: AddFriendTableViewCellDelegate?

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBAction func addFriend(_ sender: UIButton) {
        cellDelegate?.addFriendAction(tag)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

protocol AddFriendTableViewCellDelegate: class {
    func addFriendAction(_ tag: Int)
}
