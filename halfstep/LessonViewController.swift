//
//  LessonViewController.swift
//  halfstep
//
//  Created by David Mora on 12/8/17.
//  Copyright © 2017 CS 147. All rights reserved.
//

import UIKit

class LessonViewController: UIViewController {


    @IBOutlet weak var instructionsLabel: UILabel!
    @IBOutlet weak var recordingStatusLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    var clickCount = 0
    var lesson: Lesson? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = lesson?.name
    }
    
    @IBAction func recordButtonPressed(_ sender: UIButton) {
        switch(clickCount) {
            case 0:
                recordingStatusLabel.text = "recording..."
                recordButton.alpha = 0.3
                clickCount += 1
            case 1:
                recordingStatusLabel.text = "almost. try again!"
                recordButton.alpha = 1
                instructionsLabel.text = "Whoops, try again."
                clickCount += 1
            case 2:
                recordingStatusLabel.text = "you're live!"
                recordButton.alpha = 0.3
                clickCount += 1
            case 3:
                recordButton.alpha = 0
                recordingStatusLabel.text = "processing..."
                sleep(1)
                recordingStatusLabel.text = "Success!"
                // go to success screen
            default:
                clickCount = 0
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
