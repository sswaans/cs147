//
//  LessonCompleteEvent.swift
//  halfstep
//
//  Created by Khoi Khoi Viet Le on 11/28/17.
//  Copyright © 2017 CS 147. All rights reserved.
//

import Foundation

class LessonCompleteEvent: UserEvent {
    @NSManaged var lessonCompleted: Lesson?
    
//    init(timestamp: Date, lessonCompleted: Lesson) {
//        var eventMessage: String
////        eventMessage = "completed lesson: " + lessonCompleted.Name
////        super.init(timestamp: timestamp, eventString: eventMessage)
//    }
}
