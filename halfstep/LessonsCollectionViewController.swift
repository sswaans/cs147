//
//  LessonsCollectionViewController.swift
//  halfstep
//
//  Created by Stefan Swaans on 11/26/17.
//  Copyright © 2017 CS 147. All rights reserved.
//

import UIKit
import CoreData

private let reuseIdentifier = "lessonCell"

class LessonsCollectionViewController: UICollectionViewController {
    
    @IBOutlet var lessonsCollectionView: UICollectionView!
    
    private var user: User?
    
    let context = AppDelegate.viewContext
    
    let goalData = GoalData.getSharedInstance()
    
    var currentGoal: Goal? {
        get {
            if user?.getCurrentGoal() != nil {
                return user?.getCurrentGoal()
            }
            else {
                do {
                    let request: NSFetchRequest<Goal> = Goal.fetchRequest()
                    request.predicate = NSPredicate(format: "id = 0")
                    let goals = try context.fetch(request)
                    return goals[0]
                } catch {
                    return nil
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        user = User.getCurrentUser()
        
        lessonsCollectionView.delegate = self
        lessonsCollectionView.dataSource = self
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

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return currentGoal!.getNumLessons()
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        // Make cells circular and give them shadows
        cell.layer.cornerRadius = cell.frame.size.width / 2.0
        cell.clipsToBounds = true
        
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.masksToBounds = false
        cell.layer.shadowOpacity = 0.75
        cell.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.layer.cornerRadius).cgPath
        
        if let lessonCell = cell as? LessonsCollectionViewCell {
            do {
                let request: NSFetchRequest<Lesson> = Lesson.fetchRequest()
                request.predicate = NSPredicate(format: "id = %d", getTotalIndex(ofPath: indexPath))
                let lessons = try context.fetch(request)
                lessonCell.lesson = lessons[0]
                print(lessonCell.lesson?.name)
            } catch {
                // do nothing ;)
                // sometimes i like to cover myself in mayonnaise and pretend i'm a slug <==O=
            }
            if (lessonCell.lesson?.completed)! {
                cell.backgroundColor = UIColor(red: 1.0, green: 226.0/255.0, blue: 81.0/255.0, alpha: 1.0)
            }
            else if lessonCell.lesson != user?.currentLesson {
                cell.backgroundColor = UIColor.gray
            }
        }
    
        return cell
    }
    
    private func getTotalIndex(ofPath indexPath: IndexPath) -> Int {
        var result = 0
        result += indexPath.item
        if indexPath.section > 0 {
            for section in 0...indexPath.section - 1 {
                result += lessonsCollectionView.numberOfItems(inSection: section)
            }
        }
        return result
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath) as! LessonCollectionViewCell
    }
    
}
