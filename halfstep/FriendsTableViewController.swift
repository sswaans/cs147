//
//  FriendsTableViewController.swift
//  halfstep
//
//  Created by Khoi Khoi Viet Le on 12/8/17.
//  Copyright © 2017 CS 147. All rights reserved.
//

import UIKit

class FriendsTableViewController: UITableViewController, FriendTableViewCellDelegate {
    
    var friends: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFriends()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        friends = []
        loadFriends()
        tableView.reloadData()
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
        cell.cellDelegate = self
        cell.tag = indexPath.row

        return cell
    }
    
    func deleteFriendAction(_ tag: Int) {
        tableView.reloadData()
        let indexPath = IndexPath(row: tag, section: 0)
        friends.remove(at: tag)
        UserData.getSharedInstance().getUserObjByUserID(userID: 2).friends = NSSet(array: friends)
        tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
    }


    // MARK: - Navigation

    // This method lets you configure a view controller before it's presented.
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print ("made it to SUGUEUE PREPARE in FriendsTabvleViewController")
        super.prepare(for: segue, sender: sender)
        print((sender as! FriendTableViewCell).nameLabel.text!)
        let friendUserObj = UserData.getSharedInstance().getUserObjByUserName(userName: (sender as! FriendTableViewCell).nameLabel.text!)
        print(friendUserObj.name!)
        GoalData.getSharedInstance().setClickedFriend(friend: friendUserObj)
    }

 
    // MARK: Private Methods
    private func loadFriends() {
        friends += UserData.getSharedInstance().getUserObjByUserID(userID: 2).friends?.allObjects as! [User]
    }

}
