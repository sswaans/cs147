//
//  FriendProfileViewController.swift
//  halfstep
//
//  Created by David Mora on 12/8/17.
//  Copyright © 2017 CS 147. All rights reserved.
//

import UIKit

class FriendProfileViewController: UIViewController {

    
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userCurrentGoalLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let friendUserObj = GoalData.getSharedInstance().getClickedFriend()
        print(friendUserObj.imagePath!)
        userProfileImage.image = UIImage(named: friendUserObj.imagePath!)
        userNameLabel.text = friendUserObj.name
        userCurrentGoalLabel.text = friendUserObj.currentGoal?.name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
