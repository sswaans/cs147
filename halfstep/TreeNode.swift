//
//  TreeNode.swift
//  halfstep
//
//  Created by Khoi Khoi Viet Le on 11/29/17.
//  Copyright © 2017 CS 147. All rights reserved.
//

import Foundation

class TreeNode<T> {
    var value: T
    var children: [TreeNode] = []
    
    weak var parent: TreeNode? // not necessary
    
    init(value: T) {
        self.value = value
    }
    
    func add(child: TreeNode) {
        children.append(child)
        child.parent = self
    }
}

extension TreeNode where T: Equatable {
    func search(value: T) -> TreeNode? {
        if value == self.value {
            return self
        }
        for child in children {
            if let found = child.search(value: value) {
                return found
            }
        }
        
        return nil
    }
}
