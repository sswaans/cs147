//
//  FriendsTableViewController.swift
//  halfstep
//
//  Created by Khoi Khoi Viet Le on 12/8/17.
//  Copyright © 2017 CS 147. All rights reserved.
//

import UIKit
import CoreData

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
    
    public func reloadTable() {
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
        cell.profileImageView.layer.cornerRadius = cell.profileImageView.frame.size.width / 2
        cell.profileImageView.clipsToBounds = true
        cell.cellDelegate = self
        cell.tag = indexPath.row

        return cell
    }
    
    func deleteFriendAction(_ tag: Int) {
        tableView.reloadData()
        let indexPath = IndexPath(row: tag, section: 0)
        do {
            let request: NSFetchRequest<User> = User.fetchRequest()
            request.predicate = NSPredicate(format: "id = %d", 2)
            let users = try AppDelegate.viewContext.fetch(request)
            users[0].removeFromFriends(NSSet(object: friends[tag]))
            friends.remove(at: tag)
        } catch {
            // do nothing ;)
            // sometimes i like to cover myself in mayonnaise and pretend i'm a slug =<===>
        }
        tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
    }


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
        do {
            let request: NSFetchRequest<User> = User.fetchRequest()
            request.predicate = NSPredicate(format: "id = %d", 2)
            let users = try AppDelegate.viewContext.fetch(request)
            friends += users[0].friends?.allObjects as! [User]
        } catch {
            // do nothing ;)
            // sometimes i like to cover myself in mayonnaise and pretend i'm a slug =<===>
        }
    }

}
