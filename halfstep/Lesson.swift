//
//  Lesson.swift
//  halfstep
//
//  Created by Khoi Khoi Viet Le on 11/28/17.
//  Copyright © 2017 CS 147. All rights reserved.
//

import Foundation

class Lesson {
    public var Name: String {
        get {
            return name
        }
    }
    private var name: String
    private var xpPoints: Double
    private var completed = false
    
    public var ExperiencePoints: Double {
        get {
            return xpPoints
        }
    }
    
    init(lessonName: String, lessonXP: Double) {
        name = lessonName
        xpPoints = lessonXP
    }

    public func completeLesson() {
        completed = true
    }
}
