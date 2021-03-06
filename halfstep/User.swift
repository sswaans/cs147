//
//  User.swift
//  halfstep
//
//  Created by Khoi Khoi Viet Le on 11/28/17.
//  Copyright © 2017 CS 147. All rights reserved.
//

import Foundation
import CoreData

class User: NSManagedObject {
//    private var profilePicPath: String
//    private var allNotes: [Note]
//    private var receivedNotes: [Note]
//    private var sentNotes: [Note]
//    private var applausesReceived: [Applause]
    
    let context = AppDelegate.persistentContainer.viewContext
    
    // TODO: decide whether default behavior is to make the goal you add
    // your new current goal
    public func addGoal(goalToAdd: Goal, makeCurrentGoal: Bool = true){
        addToGoals(goalToAdd)
        // make current goal as well?
        if makeCurrentGoal {
            setCurrentGoal(goalToSet: goalToAdd)
        }
    }
    
    public func getCurrentGoal() -> Goal? {
        return currentGoal
    }
    
    public func setCurrentGoal(goalToSet: Goal){
        currentGoal = goalToSet
    }
    
    public func startLesson(lessonToStart: Lesson){
        currentLesson = lessonToStart
        // show lesson in view
    }
    
    // Function completeLesson is usually called
    // after completing a lesson, but can be used
    // to "finish" lessons in other situations
    // (i.e passing a diagnostics test)
    public func completeLesson(lessonToComplete: Lesson){
        currentGoal?.completeLesson(lessonCompleted: lessonToComplete)
        lessonToComplete.completeLesson()
        
        let completeLessonEvent = LessonCompleteEvent(context: context)
        completeLessonEvent.timeCompleted = Date() as NSDate // current time in seconds since 1970
        completeLessonEvent.lessonCompleted = lessonToComplete
        completeLessonEvent.content = "Lesson completed!"
        
        addUserEvent(eventToAdd: completeLessonEvent)
    }
    
    public func addUserEvent(eventToAdd: UserEvent) {
        addToAllUserEvents(eventToAdd)
    }
    
    public static func getCurrentUser() -> User? {
        let context = AppDelegate.persistentContainer.viewContext
        
        do {
            let request: NSFetchRequest<User> = User.fetchRequest()
            request.predicate = NSPredicate(format: "id = %d", 0)
            let currentUsers = try context.fetch(request)
            if currentUsers.count > 0 {
                if currentUsers[0].goals?.count == 0 {
                    var userGoals = [Goal]()
                    userGoals.append(GoalData.getSharedInstance().getGoalObjByGoalID(goalID: 0))
                    let userGoalsSet = NSSet(array: userGoals)
                    currentUsers[0].setValue(userGoalsSet, forKey: "goals")
                }
                return currentUsers[0]
            }
            else if currentUsers.count == 0 {
                let currentUser = User(context: context)
                let goalData = GoalData.getSharedInstance()
                let userData = UserData.getSharedInstance()
                
                currentUser.setValue("Stefan Swaans", forKey: "name")
                currentUser.setValue(goalData.getGoalObjByGoalID(goalID: 0), forKey: "currentGoal")
                currentUser.currentGoal?.level = 2
                currentUser.setValue(goalData.getLessonObjById(lessonID: 1), forKey: "currentLesson")
                var userGoals = [Goal]()
                userGoals.append(goalData.getGoalObjByGoalID(goalID: 0))
                let userGoalsSet = NSSet(array: userGoals)
                currentUser.setValue(userGoalsSet, forKey: "goals")
                let friendsArray = userData.getUserObjByUserID(userID: 2).friends?.allObjects as! [User]
                currentUser.setValue(NSSet(array: friendsArray), forKey: "friends")
                currentUser.setValue(nil, forKey: "allUserEvents")
                currentUser.setValue(1, forKey: "id")
                try context.save()
                return currentUser
            }
        } catch {
            return nil
        }
        return nil
    }
}
