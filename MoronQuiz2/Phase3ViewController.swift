//
//  Phase3ViewController.swift
//  MoronQuiz2
//
//  Created by Joshua Meenan on 9/17/22.
//

import UIKit

class Phase3ViewController: ViewController {

    @IBOutlet weak var score: UITextView!
    override func viewDidLoad() {
        score.text = "Your score was: " + String(correctAnswers)
        correctAnswers = 0
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
