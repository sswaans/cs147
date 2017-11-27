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
    private var goalNames: [String]
    private init() {
        goalNames = ["major scales", "minor scales", "triads", "time signatures", "progressions", "key signatures", "interval training", "secondary functions", "musical forms"]
    }
    
    public static func getSharedInstance() -> GoalData {
        return GoalData.sharedInstance
    }
    
    public func getGoalName(forIndex index: Int) -> String {
        return goalNames[index]
    }
    
}
