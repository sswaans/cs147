//
//  LessonViewController.swift
//  halfstep
//
//  Created by David Mora on 12/8/17.
//  Copyright © 2017 CS 147. All rights reserved.
//

import UIKit

class LessonViewController: UIViewController {


    @IBOutlet weak var recordingStatusLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    var isRecording = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
    }
    @IBAction func recordButtonPressed(_ sender: UIButton) {
        if (isRecording) {
            recordingStatusLabel.text = "record"
            recordButton.alpha = 1
            isRecording = false
            
        } else {
            recordingStatusLabel.text = "recording..."
            recordButton.alpha = 0.3
            isRecording = true
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
