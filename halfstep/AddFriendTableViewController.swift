//
//  AddFriendTableViewController.swift
//  halfstep
//
//  Created by Khoi Khoi Viet Le on 12/8/17.
//  Copyright © 2017 CS 147. All rights reserved.
//

import UIKit
import CoreData

class AddFriendTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AddFriendTableViewCellDelegate {
    
    var notFriendsYet = [User]()
    
    @IBOutlet weak var addFriendsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addFriendsTable.delegate = self
        addFriendsTable.dataSource = self
        loadNotFriends()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notFriendsYet.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "addFriendCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? AddFriendTableViewCell else {
            fatalError("NOT FRIENDS")
        }
        
        let addFriend = notFriendsYet[indexPath.row]
        cell.nameLabel.text = addFriend.name
        cell.profileImageView.image = UIImage(named: addFriend.imagePath!)
        cell.cellDelegate = self
        cell.tag = indexPath.row
        
        cell.profileImageView.layer.cornerRadius = cell.profileImageView.frame.size.width / 2
        cell.profileImageView.clipsToBounds = true
       

        return cell
    }
    
    func addFriendAction(_ tag: Int) {
        addFriendsTable.reloadData()
        let friendToAdd = notFriendsYet[tag]
        do {
            let request: NSFetchRequest<User> = User.fetchRequest()
            request.predicate = NSPredicate(format: "id = %d", 2)
            let users = try AppDelegate.viewContext.fetch(request)
            let newFriends = users[0].friends?.adding(friendToAdd)
            users[0].setValue(newFriends, forKey: "friends")
            try AppDelegate.viewContext.save()
            (self.parent?.childViewControllers[1] as! FriendsTableViewController).reloadTable()
        } catch {
            // do nothing ;)
            // sometimes i like to cover myself in mayonnaise and pretend i'm a slug =<===>
        }
        UserData.getSharedInstance().addFriendToUser(friend: friendToAdd, userID: 2)
        let indexPath = IndexPath(row: tag, section: 0)
        notFriendsYet.remove(at: tag)
        addFriendsTable.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print ("made it to SUGUEUE PREPARE in FriendsTabvleViewController")
        super.prepare(for: segue, sender: sender)
        print((sender as! AddFriendTableViewCell).nameLabel.text!)
        let friendUserObj = UserData.getSharedInstance().getUserObjByUserName(userName: (sender as! AddFriendTableViewCell).nameLabel.text!)
        print(friendUserObj.name!)
        GoalData.getSharedInstance().setClickedFriend(friend: friendUserObj)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Private Methods
    private func loadNotFriends(){
        notFriendsYet += UserData.getSharedInstance().getNotFriends()
    }
}
