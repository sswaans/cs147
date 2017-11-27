//
//  FriendsViewController.swift
//  halfstep
//
//  Created by Stefan Swaans on 11/25/17.
//  Copyright © 2017 CS 147. All rights reserved.
//

import UIKit

class FriendsViewController: UIViewController, UITabBarDelegate {

    
    @IBOutlet weak var tabBar: UITabBar!
    
    @IBOutlet weak var newsContainer: UIView!
    @IBOutlet weak var friendsContainer: UIView!
    @IBOutlet weak var addFriendContainer: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.delegate = self
        tabBar.selectedItem = tabBar.items?[0]
        view.bringSubview(toFront: newsContainer)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.title! {
        case "News":
            view.bringSubview(toFront: newsContainer)
        case "Friends":
            view.bringSubview(toFront: friendsContainer)
        case "Add Friend":
            view.bringSubview(toFront: addFriendContainer)
        default:
            view.bringSubview(toFront: newsContainer)
        }
    }

}
