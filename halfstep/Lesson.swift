//
//  Lesson.swift
//  halfstep
//
//  Created by Khoi Khoi Viet Le on 11/28/17.
//  Copyright © 2017 CS 147. All rights reserved.
//

import Foundation
import CoreData

class Lesson: NSManagedObject {
    public func completeLesson() {
        completed = true
    }
}
