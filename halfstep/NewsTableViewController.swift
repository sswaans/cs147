//
//  NewsTableViewController.swift
//  halfstep
//
//  Created by Khoi Khoi Viet Le on 12/8/17.
//  Copyright © 2017 CS 147. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController {
    var newsItems = [String]()
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadNews()
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
        return users.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "NewsTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? NewsTableViewCell else {
            fatalError("Dequeued cell is not NewsTableViewCell")
        }
        let user = users[indexPath.row]
        let userEvent = user.allUserEvents?.anyObject() as! UserEvent
        cell.messageLabel.text = user.name! + " " + userEvent.content!
        cell.profileImageView.image = UIImage(named: user.imagePath!)
        
        if userEvent.content!.range(of: "practice") != nil {
            cell.iconImageView.image = UIImage(named: "noteIcon")
        }
        else if userEvent.content!.range(of: "level") != nil {
            cell.iconImageView.image = UIImage(named: "level-up") // Dave Gandy
        }
        else if userEvent.content!.range(of: "became friends") != nil {
            cell.iconImageView.image = UIImage(named: "friendsIcon")
        }
        
        
        cell.profileImageView.layer.cornerRadius = cell.profileImageView.frame.width / 2
        cell.profileImageView.clipsToBounds = true

        return cell
    }
 
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print ("made it to SUGUEUE PREPARE in FriendsTabvleViewController")
        super.prepare(for: segue, sender: sender)
        print((sender as! NewsTableViewCell).messageLabel.text!.split(separator: " ")[0] as! String)
        let friendUserObj = UserData.getSharedInstance().getUserObjByUserName(userName: (sender as! NewsTableViewCell).messageLabel.text!.split(separator: " ")[0] as! String)
        print(friendUserObj.name!)
        GoalData.getSharedInstance().setClickedFriend(friend: friendUserObj)
    } */

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
    
    // MARK: Private functions
    private func loadNews(){
        users += UserData.getSharedInstance().getUserObjByUserID(userID: 2).friends?.allObjects as! [User]
    }

}
