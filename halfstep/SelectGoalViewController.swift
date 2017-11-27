//
//  SelectGoalViewController.swift
//  halfstep
//
//  Created by Stefan Swaans on 11/26/17.
//  Copyright © 2017 CS 147. All rights reserved.
//

import UIKit

class SelectGoalViewController: UIViewController {
    
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var goalButton: UIButton!
    @IBOutlet weak var goalDescription: UILabel!
    
    weak var delegate: SelectGoalDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Aesthetic button stuff
        goalButton.clipsToBounds = true
        goalButton.layer.cornerRadius = goalButton.frame.size.width / 2.0
        goalButton.layer.shadowColor = UIColor.black.cgColor
        goalButton.layer.masksToBounds = false
        goalButton.layer.shadowOpacity = 0.75
        goalButton.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        goalButton.layer.shadowPath = UIBezierPath(roundedRect: goalButton.bounds, cornerRadius: goalButton.layer.cornerRadius).cgPath
        
    }
    // On click, dismiss popover and switch to learn tab
    @IBAction func onClick(_ sender: UIButton) {
        DispatchQueue.main.async { [weak self] in
            self?.dismiss(animated: false, completion: { completed in
                self?.delegate?.shouldSwitchToLessons(forGoal: (self?.goalLabel.text!)!)
            })
        }
        
    }

}
