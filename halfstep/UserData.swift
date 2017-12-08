//
//  UserData.swift
//  halfstep
//
//  Created by David Mora on planet earth.
//  Copyright © 2017 CS 147. All rights reserved.
//

import Foundation
import CoreData

class UserData {
    
    private static let sharedInstance = UserData()
    private var users: [User]
    private var userNameToIdMap = ["david": 2,
                                   "khoi": 3,
                                   "andrew": 4,
                                   "james": 5,
                                   "johnlennon": 6,
                                   "paulmccartney": 7,
                                   "ringostarr": 8,
                                   "georgeharrison": 9,
                                   "beyonce": 10,
                                   "jayz": 11]
    private init() {
        let goalData = GoalData.getSharedInstance()
        users = []
        let userDictionaryArray = [["allUserEvents": ["practiced for 30 minutes today", "practiced for 23 minutes yesterday", "achieved Level 3 in Play All Major Scales", "set a new goal: Play All Minor Scales", "became friends with beyonce", "became friends with jayz"],
                                    "currentGoal": 0,
                                    "currentLesson": 0,
                                    "friends": ["khoi", "andrew", "beyonce", "jayz"],
                                    "goals": [1, 2],
                                    "id": 2,
                                    "name": "david",
                                    "imagePath": "david_mora"],
                                   ["allUserEvents": ["practiced for 30 minutes today", "practiced for 23 minutes yesterday", "achieved Level 3 in Play All Major Scales", "set a new goal: Play All Minor Scales", "became friends with beyonce", "became friends with jayz"],
                                    "currentGoal": 1,
                                    "currentLesson": 5,
                                    "friends": ["david", "andrew", "beyonce", "jayz"],
                                    "goals": [1, 2],
                                    "id": 3,
                                    "name": "khoi",
                                    "imagePath": "khoi_le"],
                                   ["allUserEvents": ["practiced for 30 minutes today", "practiced for 23 minutes yesterday", "achieved Level 3 in Play All Major Scales", "set a new goal: Play All Minor Scales", "became friends with beyonce", "became friends with jayz"],
                                    "currentGoal": 2,
                                    "currentLesson": 10,
                                    "friends": ["james", "paulmccartney", "beyonce", "jayz"],
                                    "goals": [0, 1],
                                    "id": 4,
                                    "name": "andrew",
                                    "imagePath": "andrew_mccabe"],
                                   ["allUserEvents": ["practiced for 30 minutes today", "practiced for 23 minutes yesterday", "achieved Level 3 in Play All Major Scales", "set a new goal: Play All Minor Scales", "became friends with beyonce", "became friends with jayz"],
                                    "currentGoal": 2,
                                    "currentLesson": 11,
                                    "friends": ["andrew", "paulmccartney", "beyonce", "jayz"],
                                    "goals": [0, 1],
                                    "id": 5,
                                    "name": "james",
                                    "imagePath": "james_landay"],
                                   ["allUserEvents": ["practiced for 30 minutes today", "practiced for 23 minutes yesterday", "achieved Level 3 in Play All Major Scales", "set a new goal: Play All Minor Scales", "became friends with beyonce", "became friends with jayz"],
                                    "currentGoal": 0,
                                    "currentLesson": 2,
                                    "friends": ["paulmccartney",
                                                "ringostarr",
                                                "georgeharrison",
                                                "beyonce",
                                                "jayz"],
                                    "goals": [1, 2],
                                    "id": 6,
                                    "name": "johnlennon",
                                    "imagePath": "john_lennon"],
                                   ["allUserEvents": ["practiced for 30 minutes today", "practiced for 23 minutes yesterday", "achieved Level 3 in Play All Major Scales", "set a new goal: Play All Minor Scales", "became friends with beyonce", "became friends with jayz"],
                                    "currentGoal": 0,
                                    "currentLesson": 3,
                                    "friends": ["ringostarr",
                                                "georgeharrison",
                                                "johnlennon",
                                                "beyonce",
                                                "jayz"],
                                    "goals": [1, 2],
                                    "id": 7,
                                    "name": "paulmccartney",
                                    "imagePath": "paul_mccartney"],
                                   ["allUserEvents": ["practiced for 30 minutes today", "practiced for 23 minutes yesterday", "achieved Level 3 in Play All Major Scales", "set a new goal: Play All Minor Scales", "became friends with beyonce", "became friends with jayz"],
                                    "currentGoal": 1,
                                    "currentLesson": 6,
                                    "friends": ["paulmccartney",
                                                "georgeharrison",
                                                "johnlennon",
                                                "beyonce",
                                                "jayz"],
                                    "goals": [1],
                                    "id": 8,
                                    "name": "ringostarr",
                                    "imagePath": "ringo_starr"],
                                   ["allUserEvents": ["practiced for 30 minutes today", "practiced for 23 minutes yesterday", "achieved Level 3 in Play All Major Scales", "set a new goal: Play All Minor Scales", "became friends with beyonce", "became friends with jayz"],
                                    "currentGoal": 1,
                                    "currentLesson": 7,
                                    "friends": ["paulmccartney", "ringostarr", "johnlennon", "beyonce", "jayz"],
                                    "goals": [1],
                                    "id": 9,
                                    "name": "georgeharrison",
                                    "imagePath": "george_harrison"],
                                   ["allUserEvents": ["practiced for 30 minutes today", "practiced for 23 minutes yesterday", "achieved Level 3 in Play All Major Scales", "set a new goal: Play All Minor Scales", "became friends with beyonce", "became friends with jayz"],
                                    "currentGoal": 2,
                                    "currentLesson": 12,
                                    "friends": ["jayz",
                                                "david",
                                                "khoi",
                                                "johnlennon",
                                                "paulmccartney",
                                                "ringostarr",
                                                "georgeharrison",
                                                "james",
                                                "andrew"],
                                    "goals": [0, 1],
                                    "id": 10,
                                    "name": "beyonce",
                                    "imagePath": "beyonce"],
                                   ["allUserEvents": ["practiced for 30 minutes today", "practiced for 23 minutes yesterday", "achieved Level 3 in Play All Major Scales", "set a new goal: Play All Minor Scales", "became friends with beyonce", "became friends with jayz"],
                                    "currentGoal": 2,
                                    "currentLesson": 13,
                                    "friends": ["beyonce",
                                                "david",
                                                "khoi",
                                                "johnlennon",
                                                "paulmccartney",
                                                "ringostarr",
                                                "georgeharrison",
                                                "james",
                                                "andrew"],
                                    "goals": [0, 1],
                                    "id": 11,
                                    "name": "jayz",
                                    "imagePath": "jay-z"]]
        
        for userDict in userDictionaryArray {
            let userEntity = NSEntityDescription.entity(forEntityName: "User", in: AppDelegate.viewContext)
            let userObj = User(entity: userEntity!, insertInto: AppDelegate.viewContext)
            userObj.name = userDict["name"] as? String
            userObj.currentGoal   = goalData.getGoalObjByGoalID(goalID: (userDict["currentGoal"] as? Int)!)
            userObj.currentLesson = goalData.getLessonObjById(lessonID: (userDict["currentLesson"] as? Int)!)
            userObj.allUserEvents = NSSet(array: createUserEvents(eventStrings: (userDict["allUserEvents"] as! [String])))
            userObj.imagePath     = userDict["imagePath"] as? String
            users.append(userObj)
        }
        
        // Now that users are created, link em up via friends lists
        for index in 0..<users.count {
            var friendsObjects = [User]()
            for friendName in (userDictionaryArray[index]["friends"] as! [String]) {
                friendsObjects.append(getUserObjByUserName(userName: friendName))
            }
            users[index].friends = NSSet(array: friendsObjects)
        }
        
        do {
            try AppDelegate.viewContext.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
    }
    
    private func createUserEvents(eventStrings: [String]) -> [UserEvent] {
        var events = [UserEvent]()
        for eventString in eventStrings {
            let userEventEntity = NSEntityDescription.entity(forEntityName: "UserEvent", in: AppDelegate.viewContext)
            let userEventObj = UserEvent(entity: userEventEntity!, insertInto: AppDelegate.viewContext)
            userEventObj.content = eventString
            events.append(userEventObj)
        }
        return events
    }
    
    public static func getSharedInstance() -> UserData {
        return UserData.sharedInstance
    }
    
    public func getUserObjByUserID(userID: Int) -> User {
        return users[userID - 2]                     // HACK: they'r sorted by ID starting at id = 2
    }
    
    public func getUserObjByUserName(userName: String) -> User {
        print(userNameToIdMap[userName], users)
        return users[userNameToIdMap[userName]! - 2] // HACK: they'r sorted by ID starting at id = 2
    }
    
    public func getArrayOfAllUserObjects() -> [User] {
        return users
    }
    
    public func getNotFriends() -> [User] {
        var notFriends = [User]()
        for i in 5..<8 {
            notFriends.append(users[i])
        }
        return notFriends
    }
    
}

