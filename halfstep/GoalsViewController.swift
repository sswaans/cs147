//
//  GoalsViewController.swift
//  halfstep
//
//  Created by Stefan Swaans on 11/26/17.
//  Copyright © 2017 CS 147. All rights reserved.
//

import UIKit

private let reuseIdentifier = "goalCell"

class GoalsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIPopoverPresentationControllerDelegate, SelectGoalDelegate {
    
    
    @IBOutlet weak var goalsCollectionView: UICollectionView!

    var user: User?
    
    private var selectedGoal: Goal?
    
    fileprivate var itemsPerRow = 3
    fileprivate var insets = UIEdgeInsets(top: 0, left: 20.0, bottom: 50.0, right: 20.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        goalsCollectionView.dataSource = self
        goalsCollectionView.delegate = self
        user = User.getCurrentUser()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        switch section {
        case 0:
            return 1
        case 1:
            return 5
        case 2:
            return 3
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
        
        switch indexPath.section {
        case 0:
            cell.backgroundColor = UIColor(red: 1.0, green: 226.0/255.0, blue: 81.0/255.0, alpha: 1.0)
        case 1:
            break
        case 2:
            cell.backgroundColor = UIColor.gray
        default:
            break
        }
        
        if let goalCell = cell as? GoalCollectionViewCell {
            // TODO: Wire up goals to goal cells
            let goalLabel = UILabel()
            goalLabel.text = "goal name"
            goalLabel.font = UIFont(name: "AvenirNextCondensed-Regular", size: 17.0)
            collectionView.addSubview(goalLabel)
            goalLabel.frame = CGRect(x: goalCell.frame.minX, y: goalCell.frame.maxY, width: goalCell.frame.width, height: 20)
            goalLabel.textAlignment = NSTextAlignment.center
            //goalLabel.sizeToFit()
            goalLabel.frame.origin = CGPoint(x: goalCell.frame.minX, y: goalCell.frame.maxY)
            goalCell.goalLabel = goalLabel
        }
    
        return cell
    }

    // MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected item at indexPath: \(indexPath)")
        let cell = goalsCollectionView.cellForItem(at: indexPath) as! GoalCollectionViewCell
        print("goal name: \(String(describing: cell.goal?.getName()))")
        switch indexPath.section {
        case 0:
            user?.setCurrentGoal(goalToSet: cell.goal!)
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
