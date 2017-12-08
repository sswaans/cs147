//
//  GoalData.swift
//  halfstep
//
//  Created by Stefan Swaans on 11/26/17.
//  Copyright © 2017 CS 147. All rights reserved.
//

import Foundation

class GoalData {
    
    private static let sharedInstance = GoalData()
    private var goals: [Goal]
    private init() {
        goals = [] // David please create a bunch of goal objects and put them in
        var goalDictionaryArray = [["description": "Anything but boring, mastering the seven noted wonders at the heart of western music will open up your musical world, from Brahams to the Beatles.",
                                    "iconPath": "",
                                    "id": 0,
                                    "lessons": [0, 1, 2, 3, 4],
                                    "level": 10,
                                    "name": "Play all major scales",
                                    "progress": 0,
                                    "progressRequired": 100],
                                   ["description": "Plot twist: what happens when you  start a major scale on its sixth note? Dark and moving, the minor scales will take what you learned from the major scales to the next level",
                                    "iconPath": "",
                                    "id": 1,
                                    "lessons": [5, 6, 7, 8, 9],
                                    "level": 10,
                                    "name": "Play all minor scales",
                                    "progress": 0,
                                    "progressRequired": 100],
                                   ["description": "This goal unlocks a sure fire way to spice up any ii-V-I (in othe words, every jazz song ever). Get your mind blown by the substitution at the heart of the quintessential jazzs sound, zamboosling fourths into halfsteps with the flick of a tri-tone. ",
                                    "iconPath": "",
                                    "id": 2,
                                    "lessons": [10, 11, 12, 13, 14, 15],
                                    "level": 10,
                                    "name": "Use tri-tone substitution in jazz",
                                    "progress": 0,
                                    "progressRequired": 100]]
        
        for goalDict in goalDictionaryArray {
            var lessons = [Lesson]() // to be populated
            createLessonsForGoal(lessonIDs: goalDict["lessons"] as! [Int], lessons: &lessons);
            var goalObj = Goal(goalName: goalDict["name"] as! String, goalLessons: lessons, goalDescription: goalDict["description"] as! String, goalIconPath: goalDict["iconPath"] as! String)
            goals.append(goalObj)
        }
    }
    
    private func createLessonsForGoal(lessonIDs: [Int], lessons: inout [Lesson]) {
        var lessonDictionaryArray = [["parent_goal": "Play all major scales",
                                      "completed": false,
                                      "id": 0,
                                      "name": "Play the first 5 notes",
                                      "xpPoints": 10],
                                     ["parent_goal": "Play all major scales",
                                      "completed": false,
                                      "id": 1,
                                      "name": "Play the last 3 notes",
                                      "xpPoints": 10],
                                     ["parent_goal": "Play all major scales",
                                      "completed": false,
                                      "id": 2,
                                      "name": "Put it all together",
                                      "xpPoints": 10],
                                     ["parent_goal": "Play all major scales",
                                      "completed": false,
                                      "id": 3,
                                      "name": "Connect multiple octaves",
                                      "xpPoints": 10],
                                     ["parent_goal": "Play all major scales",
                                      "completed": false,
                                      "id": 4,
                                      "name": "Uncover the whole and half step formula underneath",
                                      "xpPoints": 10],
                                     ["parent_goal": "Play all minor scales",
                                      "completed": false,
                                      "id": 5,
                                      "name": "Play the first 5 notes",
                                      "xpPoints": 10],
                                     ["parent_goal": "Play all minor scales",
                                      "completed": false,
                                      "id": 6,
                                      "name": "Play the last 3 notes",
                                      "xpPoints": 10],
                                     ["parent_goal": "Play all minor scales",
                                      "completed": false,
                                      "id": 7,
                                      "name": "Put it all together",
                                      "xpPoints": 10],
                                     ["parent_goal": "Play all minor scales",
                                      "completed": false,
                                      "id": 8,
                                      "name": "Connect multiple octaves",
                                      "xpPoints": 10],
                                     ["parent_goal": "Play all minor scales",
                                      "completed": false,
                                      "id": 9,
                                      "name": "Uncover the whole and half step formula underneath",
                                      "xpPoints": 10],
                                     ["parent_goal": "Use tri-tone substitution in jazz",
                                      "completed": false,
                                      "id": 0,
                                      "name": "Play ii-V-I",
                                      "xpPoints": 10],
                                     ["parent_goal": "Use tri-tone substitution in jazz",
                                      "completed": false,
                                      "id": 1,
                                      "name": "What is a tritone?",
                                      "xpPoints": 10],
                                     ["parent_goal": "Use tri-tone substitution in jazz",
                                      "completed": false,
                                      "id": 2,
                                      "name": "Stripping down to thirds and sevenths",
                                      "xpPoints": 10],
                                     ["parent_goal": "Use tri-tone substitution in jazz",
                                      "completed": false,
                                      "id": 3,
                                      "name": "Find the matching dominant chord",
                                      "xpPoints": 10],
                                     ["parent_goal": "Use tri-tone substitution in jazz",
                                      "completed": false,
                                      "id": 4,
                                      "name": "Tritone substitute",
                                      "xpPoints": 10],
                                     ["parent_goal": "Use tri-tone substitution in jazz",
                                      "completed": false,
                                      "id": 5,
                                      "name": "Tritone substitute in a ii-V-I",
                                      "xpPoints": 10]]
        for lessonID in lessonIDs {
            var lessonDict = lessonDictionaryArray[lessonID] // they're sorted by ID 0 through n
            var lessonObj = Lesson(completed: lessonDict["completed"] as! Bool, name: lessonDict["name"] as! String, xpPoints: lessonDict["xpPoints"] as! Int)
            lessons.append(lessonObj)
        }
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
    
}
