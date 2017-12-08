//
//  LessonCompletedViewController.swift
//  halfstep
//
//  Created by Stefan Swaans on 12/8/17.
//  Copyright © 2017 CS 147. All rights reserved.
//

import UIKit

class LessonCompletedViewController: UIViewController {
    
    @IBAction func goBackToLessons(_ sender: UIButton) {
        performSegue(withIdentifier: "unwindToLessonsSegue", sender: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
