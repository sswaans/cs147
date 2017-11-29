//
//  User.swift
//  halfstep
//
//  Created by Khoi Khoi Viet Le on 11/28/17.
//  Copyright © 2017 CS 147. All rights reserved.
//

import Foundation

class User {
    private var name: String
    private var currentGoal: Goal?
    private var goals: [Goal]
    private var currentLesson: Lesson?
    private var profilePicPath: String
    private var friends: [User]
    private var allNotes: [Note]
    private var receivedNotes: [Note]
    private var sentNotes: [Note]
    private var applausesReceived: [Applause]
    private var allUserEvents: [UserEvent]
    
    init (username: String, picPath: String) {
        name = username
        currentGoal = nil
        goals = []
        currentLesson = nil
        profilePicPath = picPath
        friends = []
        allNotes = []
        receivedNotes = []
        sentNotes = []
        applausesReceived = []
        allUserEvents = []
    }
    
    // TODO: decide whether default behavior is to make the goal you add
    // your new current goal
    public func addGoal(goalToAdd: Goal, makeCurrentGoal: Bool = true){
        goals.append(goalToAdd)
        // make current goal as well?
        if makeCurrentGoal {
            setCurrentGoal(goalToSet: goalToAdd)
        }
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
        var completeLessonEvent = LessonCompleteEvent(timestamp: Date(), lessonCompleted: lessonToComplete) // gross but pass in current time in seconds since 1970 for timestamp
        addUserEvent(eventToAdd: completeLessonEvent)
    }
    
    public func addUserEvent(eventToAdd: UserEvent) {
        allUserEvents.append(eventToAdd)
    }
}
