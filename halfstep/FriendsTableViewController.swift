//
//  FriendsTableViewController.swift
//  halfstep
//
//  Created by Khoi Khoi Viet Le on 12/8/17.
//  Copyright © 2017 CS 147. All rights reserved.
//

import UIKit

class FriendsTableViewController: UITableViewController {
    var friends = [User]()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFriends()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print ("tralala \(friends.count)")
        return friends.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "friendCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? FriendTableViewCell else {
            fatalError("Not a FriendTableViewCell")
        }
        let user = friends[indexPath.row]
        cell.nameLabel.text = user.name
        cell.profileImageView.image = UIImage(named: user.imagePath!)
        // Configure the cell...

        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation

    // This method lets you configure a view controller before it's presented.
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print ("made it to SUGUEUE PREPARE in FriendsTabvleViewController")
        super.prepare(for: segue, sender: sender)
        
        let friendUserObj = UserData.getSharedInstance().getUserObjByUserName(userName: (sender as! FriendTableViewCell).nameLabel.text!)
        print(friendUserObj.name!)
        GoalData.getSharedInstance().setClickedFriend(friend: friendUserObj)
    }

 
    // MARK: Private Methods
    private func loadFriends() {
        friends += UserData.getSharedInstance().getUserObjByUserID(userID: 2).friends?.allObjects as! [User]
    }

}
