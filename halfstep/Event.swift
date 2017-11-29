//
//  Event.swift
//  halfstep
//
//  Created by Khoi Khoi Viet Le on 11/28/17.
//  Copyright © 2017 CS 147. All rights reserved.
//

import Foundation

class UserEvent {
    var timeCompleted: Date // timestamp
    var content: String
    init(timestamp: Date, eventString: String) {
        timeCompleted = timestamp
        content = eventString
    }
}
