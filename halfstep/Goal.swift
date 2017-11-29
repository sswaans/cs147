//
//  Goal.swift
//  halfstep
//
//  Created by Stefan Swaans on 11/27/17.
//  Copyright © 2017 CS 147. All rights reserved.
//

import Foundation

class Goal {
    public var Progress: Double {
        get{
            return 1
        }
        set (value){
            progress = value
        }
    }
    
    private var name: String // "Major Scales"
    private var level = 0 // Always 0
    private var lessons: [Lesson] // [Lesson(C), Lesson(C,D,E)...]
    private var description: String // "Learn your way through all 12 major scales"
    private var progress = 0.0 // Always 0.0
    private var iconPath: String // "SupportingFiles/img/majorscales.png"
    private var progressRequired = 1.0
    
    init(goalName: String, goalLessons: [Lesson], goalDescription: String, goalIconPath: String) {
        name = goalName
        lessons = goalLessons
        description = goalDescription
        iconPath = goalIconPath
    }
    
    // Function completeLesson is called when the user completes a lesson
    public func completeLesson(lessonCompleted: Lesson) {
        increaseProgress(pointGain: lessonCompleted.ExperiencePoints)
    }
    
    // Function increaseProgress is usually called by completeLesson,
    // but can be called to simply increase XP point progress
    // (i.e if there is a "free practice" mode that gives you points
    // or if you get a daily streak bonus or something like that)
    public func increaseProgress(pointGain: Double) {
        progress += pointGain
        checkLevelUp()
    }
    
    // Function checkLevelUp is usually called by increaseProgress
    public func checkLevelUp() {
        if(progress >= progressRequired){ // progress required to level up
            levelUp();
        }
    }
    
    // Function levelUp is usually called by checklevelUp
    public func levelUp() {
        level += 1;
        progress = 0.0 // reset progress for new level
        progressRequired = Double ((level + 1) * 1) // can change the xp requirement function to be non-linear
    }
}
