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
            // If user doesn't exist, we must create one
            let userID = UserDefaults.standard.integer(forKey: "userID")
            if userID == 0 {
                let request: NSFetchRequest<User> = User.fetchRequest()
                let users = try context.fetch(request)
                UserDefaults.standard.setValue(users.count + 1, forKey: "userID")
            }
        } catch {
            return nil
        }
        
        do {
            let request: NSFetchRequest<User> = User.fetchRequest()
            request.predicate = NSPredicate(format: "id = %d", UserDefaults.standard.integer(forKey: "userID"))
            let currentUsers = try context.fetch(request)
            if currentUsers.count > 0 {
                return currentUsers[0]
            }
            else if currentUsers.count == 0 {
                let currentUser = User(context: context)
                currentUser.setValue("Stefan Swaans", forKey: "name")
                currentUser.setValue(nil, forKey: "currentGoal")
                currentUser.setValue(nil, forKey: "currentLesson")
                currentUser.setValue(nil, forKey: "goals")
                currentUser.setValue(nil, forKey: "friends")
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
