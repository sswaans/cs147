//
//  LessonViewController.swift
//  halfstep
//
//  Created by David Mora on 12/8/17.
//  Copyright © 2017 CS 147. All rights reserved.
//

import UIKit

class LessonViewController: UIViewController {


//    @IBOutlet weak var recordingStatusLabel: UILabel!
//    var isRecording = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
//        micIconImageView.addGestureRecognizer(tapRecognizer)
        
    }
    
//    func imageTapped(recognizer: UITapGestureRecognizer) {
//        print("Image was tapped")
//        if !isRecording {
//            recordingStatusLabel.text = "recording"
//            self.micIconImageView.alpha = 1.0
//            UIView.animate(withDuration: 0.5, delay: 0.0, options: [[], .repeat, .autoreverse, .allowUserInteraction], animations: {() -> Void in
//                self.micIconImageView.alpha = 0.0
//            }, completion: {(finished: Bool) -> Void in
//            })
//
//            isRecording = true
//        }
//        else {
//            isRecording = false
//            recordingStatusLabel.text = "record"
//            UIView.animate(withDuration: 0.1, delay: 0.0, options: [[], .beginFromCurrentState], animations: {() -> Void in
//                self.micIconImageView.alpha = 1.0
//            }, completion: {(finished: Bool) -> Void in
//            })
//        }
//    }

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
