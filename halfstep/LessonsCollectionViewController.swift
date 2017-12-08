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
    
    private var selectedLesson: Lesson?
    
    fileprivate var insets = UIEdgeInsets(top: 0, left: 20.0, bottom: 60.0, right: 20.0)
    
    let context = AppDelegate.viewContext
    
    let goalData = GoalData.getSharedInstance()
    
    @IBOutlet weak var navBar: UINavigationItem!
    
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
        self.collectionView!.register(LessonsCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        user = User.getCurrentUser()
        
        navBar.title = currentGoal?.name
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showLessonSegue"){
            let lessonController = segue.destination as! LessonViewController
            // TODO: If we set up specific lesson stuff, it should happen here.
            lessonController.lesson = selectedLesson!
        }
    }

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
        cell.backgroundView = UIImageView(image: #imageLiteral(resourceName: "noteIcon"))
        
        if let lessonCell = cell as? LessonsCollectionViewCell {
            let lessonLabel = UILabel()
            lessonLabel.text = "lesson name"
            lessonLabel.font = UIFont(name: "AvenirNextCondensed-Regular", size: 30.0)
            collectionView.addSubview(lessonLabel)
            lessonLabel.frame = CGRect(x: lessonCell.frame.minX, y: lessonCell.frame.maxY + 10, width: lessonCell.frame.width, height: 20)
            lessonLabel.textAlignment = NSTextAlignment.center
            lessonLabel.adjustsFontSizeToFitWidth = true
            lessonLabel.numberOfLines = 2
            lessonCell.lessonLabel = lessonLabel
            
            do {
                let request: NSFetchRequest<Lesson> = Lesson.fetchRequest()
                request.predicate = NSPredicate(format: "id = %d", getTotalIndex(ofPath: indexPath))
                let lessons = try context.fetch(request)
                lessonCell.lesson = lessons[0]
                lessonCell.lessonLabel?.text = lessonCell.lesson?.name
            } catch {
                // do nothing ;)
                // sometimes i like to cover myself in mayonnaise and pretend i'm a slug =<===>
            }
            if (lessonCell.lesson?.completed)! {
                cell.backgroundColor = UIColor(red: 1.0, green: 226.0/255.0, blue: 81.0/255.0, alpha: 1.0)
            }
            else if lessonCell.lesson != user?.currentLesson {
                cell.backgroundColor = UIColor.gray
            }
            else {
                cell.backgroundColor = UIColor(red: 13.0/255.0, green: 152.0/255.0, blue: 1.0, alpha: 1.0)
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
        let cell = collectionView.cellForItem(at: indexPath)
        if let lessonCell = cell as? LessonsCollectionViewCell {
            if (lessonCell.lesson?.completed)! || lessonCell.lesson == user?.currentLesson {
                selectedLesson = lessonCell.lesson
                performSegue(withIdentifier: "showLessonSegue", sender: self)
            }
        }
    }
    
}

extension LessonsCollectionViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemRadius = 125.0
        return CGSize(width: itemRadius, height: itemRadius)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(30, (view.frame.width / 2.0) - 62.5, 30.0, 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return insets.left
    }
    
}
