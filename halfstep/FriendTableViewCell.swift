//
//  FriendTableViewCell.swift
//  halfstep
//
//  Created by Khoi Khoi Viet Le on 12/8/17.
//  Copyright © 2017 CS 147. All rights reserved.
//

import UIKit

class FriendTableViewCell: UITableViewCell {
    
    weak var cellDelegate: FriendTableViewCellDelegate?

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBAction func deleteFriend(_ sender: UIButton) {
        cellDelegate?.deleteFriendAction(tag)
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

protocol FriendTableViewCellDelegate : class {
    func deleteFriendAction(_ tag: Int)
}
