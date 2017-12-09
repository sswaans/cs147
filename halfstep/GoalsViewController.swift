//
//  GoalsViewController.swift
//  halfstep
//
//  Created by Stefan Swaans on 11/26/17.
//  Copyright © 2017 CS 147. All rights reserved.
//

import UIKit
import CoreData

private let reuseIdentifier = "goalCell"

class GoalsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIPopoverPresentationControllerDelegate, SelectGoalDelegate {
    
    
    @IBOutlet weak var goalsCollectionView: UICollectionView!

    var user: User?
    
    private var selectedGoal: Goal?
    
    let context = AppDelegate.persistentContainer.viewContext
    
    fileprivate var itemsPerRow = 3
    fileprivate var insets = UIEdgeInsets(top: 0, left: 20.0, bottom: 50.0, right: 20.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        goalsCollectionView.dataSource = self
        goalsCollectionView.delegate = self
        user = User.getCurrentUser()
        GoalData.getSharedInstance()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        for view in goalsCollectionView.subviews {
            view.removeFromSuperview()
        }
        
        goalsCollectionView.reloadData()
    }



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let numLockedGoals = 3
        switch section {
        case 0:
            return (user!.goals?.count)!
        case 1:
            return GoalData.getArrayOfAllGoalObjects(GoalData.getSharedInstance())().count - (user!.goals?.count)! - numLockedGoals
        case 2:
            return numLockedGoals
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        // Make cells circular and give them shadows
        cell.layer.cornerRadius = cell.frame.size.width / 2.0
        cell.clipsToBounds = true
        
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.masksToBounds = false
        cell.layer.shadowOpacity = 0.75
        cell.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.layer.cornerRadius).cgPath
        cell.backgroundView = UIImageView(image: #imageLiteral(resourceName: "noteIcon"))
        
        switch indexPath.section {
        case 0:
            cell.backgroundColor = UIColor(red: 1.0, green: 226.0/255.0, blue: 81.0/255.0, alpha: 1.0)
        case 1:
            cell.backgroundColor = UIColor(red: 13.0/255.0, green: 152.0/255.0, blue: 1.0, alpha: 1.0)
        case 2:
            cell.backgroundColor = UIColor.gray
        default:
            break
        }
        
        if let goalCell = cell as? GoalCollectionViewCell {
            let goalLabel = UILabel()
            goalLabel.text = "goal name"
            goalLabel.font = UIFont(name: "AvenirNextCondensed-Regular", size: 19.0)
            collectionView.addSubview(goalLabel)
            goalLabel.frame = CGRect(x: goalCell.frame.minX, y: goalCell.frame.maxY + 10, width: goalCell.frame.width, height: 20)
            goalLabel.textAlignment = NSTextAlignment.center
            goalLabel.adjustsFontSizeToFitWidth = true
            goalCell.goalLabel = goalLabel
            
            do {
                let request: NSFetchRequest<Goal> = Goal.fetchRequest()
                request.predicate = NSPredicate(format: "id = %d", getTotalIndex(ofPath: indexPath))
                let goals = try context.fetch(request)
                goalCell.goal = goals[0]
                goalLabel.text = goalCell.goal?.getName()
                if indexPath.section == 0{
                    goalCell.levelLabel.text = goalCell.goal?.level.description
                }
                else {
                    goalCell.levelLabel.text = ""
                }
            } catch {
                // do nothing ;)
                // sometimes i like to bury myself in the backyard and pretend im a carrot -<)=
            }

        }
    
        return cell
    }
    
    private func getTotalIndex(ofPath indexPath: IndexPath) -> Int {
        var result = 0
        result += indexPath.item
        if indexPath.section > 0 {
            for section in 0...indexPath.section - 1 {
                result += goalsCollectionView.numberOfItems(inSection: section)
            }
        }
        return result
    }

    // MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = goalsCollectionView.cellForItem(at: indexPath) as! GoalCollectionViewCell
        switch indexPath.section {
        case 0:
            user?.setCurrentGoal(goalToSet: cell.goal!)
            ((tabBarController?.viewControllers?[0] as! UINavigationController).viewControllers[0] as! LessonsCollectionViewController).navBar.title = cell.goal?.name!
            tabBarController?.selectedIndex = 0
        case 1:
            selectedGoal = cell.goal
            performSegue(withIdentifier: "showSelectGoalSegue", sender: nil)
        case 2:
            break
        default:
            break
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "showSelectGoalSegue":
            let selectGoalViewController = segue.destination as! SelectGoalViewController
            selectGoalViewController.preferredContentSize = CGSize(width: 300, height: 400)
            selectGoalViewController.delegate = self
            selectGoalViewController.goal = selectedGoal
            if let popoverController = selectGoalViewController.popoverPresentationController {
                popoverController.delegate = self
                popoverController.sourceView = self.view
                popoverController.sourceRect = CGRect(x: self.view.frame.midX - 150, y: goalsCollectionView.frame.midY - 200, width: 300, height: 400)
                popoverController.permittedArrowDirections = UIPopoverArrowDirection.init(rawValue: 0)
            }
        default:
            break
        }
    }
    
    // MARK: SelectGoalDelegate
    func shouldSwitchToLessons(forGoal goal: Goal?) {
        selectedGoal = nil
        user?.addGoal(goalToAdd: goal!)
        user?.setCurrentGoal(goalToSet: goal!)
        ((tabBarController?.viewControllers?[0] as! UINavigationController).viewControllers[0] as! LessonsCollectionViewController).navBar.title = goal?.name!
        tabBarController?.selectedIndex = 0
    }
    
    
    
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        selectedGoal = nil
    }
    

}

extension GoalsViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = (insets.left * CGFloat(itemsPerRow)) + insets.right
        let itemRadius = (view.frame.width - paddingSpace) / CGFloat(itemsPerRow)
        return CGSize(width: itemRadius, height: itemRadius)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return insets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return insets.left
    }
    
}

protocol SelectGoalDelegate: class {
    func shouldSwitchToLessons(forGoal goal: Goal?)
}
