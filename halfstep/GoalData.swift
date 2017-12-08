//
//  GoalData.swift
//  halfstep
//
//  Created by Stefan Swaans on 11/26/17.
//  Copyright © 2017 CS 147. All rights reserved.
//

import Foundation
import CoreData

class GoalData {
    
    private static let sharedInstance = GoalData()
    private var goals: [Goal]
    private var allLessons: [Lesson]
    private init() {
        allLessons = [Lesson]()
        goals = []
        getAllLessons()
        let goalDictionaryArray = [["description": "anything but boring, mastering the seven noted wonders at the heart of western music will open up your musical world, from brahams to the beatles.",
                                    "iconPath": "",
                                    "id": 0,
                                    "lessons": [0, 1, 2, 3, 4],
                                    "level": 10,
                                    "name": "major scales",
                                    "progress": 0,
                                    "progressRequired": 100],
                                   ["description": "plot twist: what happens when you start a major scale on its sixth note? dark and moving, the minor scales will take what you learned from the major scales to the next level.",
                                    "iconPath": "",
                                    "id": 1,
                                    "lessons": [5, 6, 7, 8, 9],
                                    "level": 10,
                                    "name": "minor scales",
                                    "progress": 0,
                                    "progressRequired": 100],
                                   ["description": "This goal unlocks a sure fire way to spice up any ii-V-I (in other words, every jazz song ever). Get your mind blown by the substitution at the heart of the quintessential jazzs sound, zamboosling fourths into halfsteps with the flick of a tri-tone. ",
                                    "iconPath": "",
                                    "id": 2,
                                    "lessons": [10, 11, 12, 13, 14, 15],
                                    "level": 10,
                                    "name": "tri-tone substitution",
                                    "progress": 0,
                                    "progressRequired": 100]]
        
        for goalDict in goalDictionaryArray {
            let lessons = createLessonsForGoal(lessonIDs: goalDict["lessons"] as! [Int]);
            let goalEntity = NSEntityDescription.entity(forEntityName: "Goal", in: AppDelegate.viewContext)
            let goalObj = Goal(entity: goalEntity!, insertInto: AppDelegate.viewContext)
            goalObj.name = goalDict["name"] as? String
            goalObj.lessons = NSSet(array: lessons)
            goalObj.goalDescription = goalDict["description"] as? String
            goalObj.id = Int32(goalDict["id"] as! Int)
            goals.append(goalObj)
        }
        
        do {
            try AppDelegate.viewContext.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
        
    }

    private func getAllLessons() {
        let lessonDictionaryArray = [["parent_goal": "Play all major scales",
                                      "completed": true,
                                      "id": 0,
                                      "name": "first 5 notes",
                                      "xpPoints": 10.0],
                                     ["parent_goal": "Play all major scales",
                                      "completed": false,
                                      "id": 1,
                                      "name": "last 3 notes",
                                      "xpPoints": 10.0],
                                     ["parent_goal": "Play all major scales",
                                      "completed": false,
                                      "id": 2,
                                      "name": "single octave",
                                      "xpPoints": 10.0],
                                     ["parent_goal": "Play all major scales",
                                      "completed": false,
                                      "id": 3,
                                      "name": "multiple octaves",
                                      "xpPoints": 10.0],
                                     ["parent_goal": "Play all major scales",
                                      "completed": false,
                                      "id": 4,
                                      "name": "diatonic scales",
                                      "xpPoints": 10.0],
                                     ["parent_goal": "Play all minor scales",
                                      "completed": false,
                                      "id": 5,
                                      "name": "first 5 notes",
                                      "xpPoints": 10.0],
                                     ["parent_goal": "Play all minor scales",
                                      "completed": false,
                                      "id": 6,
                                      "name": "last 3 notes",
                                      "xpPoints": 10.0],
                                     ["parent_goal": "Play all minor scales",
                                      "completed": false,
                                      "id": 7,
                                      "name": "single octave",
                                      "xpPoints": 10.0],
                                     ["parent_goal": "Play all minor scales",
                                      "completed": false,
                                      "id": 8,
                                      "name": "multiple octaves",
                                      "xpPoints": 10.0],
                                     ["parent_goal": "Play all minor scales",
                                      "completed": false,
                                      "id": 9,
                                      "name": "diatonic scales",
                                      "xpPoints": 10.0],
                                     ["parent_goal": "Use tri-tone substitution in jazz",
                                      "completed": false,
                                      "id": 10,
                                      "name": "Play ii-V-I",
                                      "xpPoints": 10.0],
                                     ["parent_goal": "Use tri-tone substitution in jazz",
                                      "completed": false,
                                      "id": 11,
                                      "name": "What is a tritone?",
                                      "xpPoints": 10.0],
                                     ["parent_goal": "Use tri-tone substitution in jazz",
                                      "completed": false,
                                      "id": 12,
                                      "name": "Stripping down to thirds and sevenths",
                                      "xpPoints": 10.0],
                                     ["parent_goal": "Use tri-tone substitution in jazz",
                                      "completed": false,
                                      "id": 13,
                                      "name": "Find the matching dominant chord",
                                      "xpPoints": 10.0],
                                     ["parent_goal": "Use tri-tone substitution in jazz",
                                      "completed": false,
                                      "id": 14,
                                      "name": "Tritone substitute",
                                      "xpPoints": 10.0],
                                     ["parent_goal": "Use tri-tone substitution in jazz",
                                      "completed": false,
                                      "id": 15,
                                      "name": "Tritone substitute in a ii-V-I",
                                      "xpPoints": 10.0]]
        for index in 0...lessonDictionaryArray.count - 1 {
            let lessonDict = lessonDictionaryArray[index]
            let lessonEntity = NSEntityDescription.entity(forEntityName: "Lesson", in: AppDelegate.viewContext)
            let lessonObj = Lesson(entity: lessonEntity!, insertInto: AppDelegate.viewContext)
            lessonObj.completed = lessonDict["completed"] as! Bool
            lessonObj.name = lessonDict["name"] as? String
            lessonObj.xpPoints = lessonDict["xpPoints"] as! Double
            lessonObj.id = Int32(lessonDict["id"] as! Int)
            allLessons.append(lessonObj)
        }
    }
    
    private func createLessonsForGoal(lessonIDs: [Int]) -> [Lesson] {
        var lessons = [Lesson]()
        for index in 0...lessonIDs.count - 1 {
            let lessonID = lessonIDs[index]
            lessons.append(allLessons[lessonID]) // HACK: they're ordered by id 0 to 15
        }
        return lessons
    }
    
    public static func getSharedInstance() -> GoalData {
        return GoalData.sharedInstance
    }
    
    public func getGoalObjByGoalID(goalID: Int) -> Goal {
        return goals[goalID] // they'r sorted by ID 0 through n
    }
    
    public func getArrayOfAllGoalObjects() -> [Goal] {
        return goals
    }
    
    public func getLessonObjById(lessonID: Int) -> Lesson {
        return allLessons[lessonID]
    }
    
}
