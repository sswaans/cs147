//
//  UserData.swift
//  halfstep
//
//  Created by David Mora on planet earth.
//  Copyright © 2017 CS 147. All rights reserved.
//

import Foundation

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
        users = []
        var userDictionaryArray = [["allUserEvents": ["practiced for 30 minutes today", "practiced for 23 minutes yesterday", "achieved Level 3 in Play All Major Scales", "set a new goal: Play All Minor Scales", "became friends with beyonce", "became friends with jayz"],
                                    "currentGoal": 0,
                                    "currentLesson": 0,
                                    "friends": ["khoi", "andrew", "beyonce", "jayz"],
                                    "goals": [1, 2],
                                    "id": 2,
                                    "name": "david"],
                                   ["allUserEvents": ["practiced for 30 minutes today", "practiced for 23 minutes yesterday", "achieved Level 3 in Play All Major Scales", "set a new goal: Play All Minor Scales", "became friends with beyonce", "became friends with jayz"],
                                    "currentGoal": 1,
                                    "currentLesson": 5,
                                    "friends": ["david", "andrew", "beyonce", "jayz"],
                                    "goals": [1, 2],
                                    "id": 3,
                                    "name": "khoi"],
                                   ["allUserEvents": ["practiced for 30 minutes today", "practiced for 23 minutes yesterday", "achieved Level 3 in Play All Major Scales", "set a new goal: Play All Minor Scales", "became friends with beyonce", "became friends with jayz"],
                                    "currentGoal": 2,
                                    "currentLesson": 10,
                                    "friends": ["james", "paulmccartney", "beyonce", "jayz"],
                                    "goals": [0, 1],
                                    "id": 4,
                                    "name": "andrew"],
                                   ["allUserEvents": ["practiced for 30 minutes today", "practiced for 23 minutes yesterday", "achieved Level 3 in Play All Major Scales", "set a new goal: Play All Minor Scales", "became friends with beyonce", "became friends with jayz"],
                                    "currentGoal": 2,
                                    "currentLesson": 11,
                                    "friends": ["andrew", "paulmccartney", "beyonce", "jayz"],
                                    "goals": [0, 1],
                                    "id": 5,
                                    "name": "james"],
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
                                    "name": "johnlennon"],
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
                                    "name": "paulmccartney"],
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
                                    "name": "ringostarr"],
                                   ["allUserEvents": ["practiced for 30 minutes today", "practiced for 23 minutes yesterday", "achieved Level 3 in Play All Major Scales", "set a new goal: Play All Minor Scales", "became friends with beyonce", "became friends with jayz"],
                                    "currentGoal": 1,
                                    "currentLesson": 7,
                                    "friends": ["paulmccartney", "ringostarr", "johnlennon", "beyonce", "jayz"],
                                    "goals": [1],
                                    "id": 9,
                                    "name": "georgeharrison"],
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
                                    "name": "beyonce"],
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
                                    "name": "jayz"]]
        
        for userDict in userDictionaryArray {
            var userObj = User(name: userDict["name"] as! String, currentGoal: userDict["currentGoal"] as! Int, currentLesson: userDict["currentLesson"] as! Int,
                               goals: userDict["goals"] as! [Int], friends: userDict["friends"] as! [String],  userDict["allUserEvents"]: nil,
                                id: userDict["id"] as! Int)
            users.append(userObj)
        }
    }
    
    public static func getSharedInstance() -> UserData {
        return UserData.sharedInstance
    }
    
    public func getUserObjByUserID(userID: Int) -> User {
        return users[userID - 2]                     // HACK: they'r sorted by ID starting at id = 2
    }
    
    public func getUserObjByUserName(userName: String) -> User {
        return users[userNameToIdMap[userName]! - 2] // HACK: they'r sorted by ID starting at id = 2
    }
    
    public func getArrayOfAllUserObjects() -> [User] {
        return users
    }
    
}

