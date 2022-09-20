//
//  Phase2ViewController.swift
//  MoronQuiz2
//
//  Created by Joshua Meenan on 9/17/22.
//

import UIKit
import Foundation


public var c = 0
public var correctAnswers = 0
public var livesLeft = 3
public var timeLeft = 10
public var lvl = 1
public var timer = Timer()

class Phase2ViewController: ViewController, UITextViewDelegate {

    @IBOutlet var count: UITextView!
    @IBOutlet var lives: UITextView!
    @IBOutlet var time: UITextView!
    @IBOutlet var textView1: UITextView!
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    @IBOutlet var button4: UIButton!
    
    
    override func viewDidLoad() {
        if(livesLeft < 0){
            endgame()
        }
        count.text = "Score: " + String(correctAnswers)
        lives.text = "Lives: " + String(livesLeft)
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        if(livesLeft <= 0){
            //gameover
        }
        time.delegate = self
        var rangeSH = 2
        var rangeSL = 1
        if(lvl > 2){
            rangeSH = 3
            rangeSL = 3
        }
        let sign = randomInt(min: rangeSL, max: rangeSH)
        var answer = 0
        //1 is + 2 is - 3 is * 4 is /
        if(sign == 1){
            answer = addition()
            randomButton(Anw: answer, sign: sign)
            print(answer)
            
        }
        if(sign == 2){
            answer = subtraction()
            randomButton(Anw: answer, sign: sign)
            print(answer)
        }
        if(sign == 3){
            answer = multiplication()
            randomButton(Anw: answer, sign: sign)
            print(answer)
        }
        if(sign == 4){
            
        }
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func endgame(){
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let balanceViewController = storyBoard.instantiateViewController(withIdentifier: "Phase3ViewController") as! Phase3ViewController
        timer.invalidate()
        c = 0
        livesLeft = 3
        timeLeft = 10
        lvl = 1
        self.dismiss(animated: false, completion: nil)
        self.present(balanceViewController, animated: true, completion: nil)
    }
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func addition()-> Int{
        let rangeH = (10)
        var rangeL = 1
        if(lvl > 2){
            rangeL = 10
        }
        let num1 = randomInt(min: rangeL, max: power(num: rangeH, power: lvl))
        let num2 = randomInt(min: rangeL, max: power(num: rangeH, power: lvl))
        textView1.text = String(num1) + "+" + String(num2)
        return num1 + num2;
    }
    
    func subtraction()-> Int{
        let rangeH = (10)
        var rangeL = 1
        if(lvl > 2){
            rangeL = 10
        }
        var num1 = randomInt(min: rangeL, max: power(num: rangeH, power: lvl))
        var num2 = randomInt(min: rangeL, max: power(num: rangeH, power: lvl))
        while(num1 - num2 <= 0){
            num1 = randomInt(min: rangeL, max: power(num: rangeH, power: lvl))
            num2 = randomInt(min: rangeL, max: power(num: rangeH, power: lvl))
        }
        textView1.text = String(num1) + "-" + String(num2)
        return num1 - num2;
        
        
    }
    
    func multiplication()-> Int{
        let rangeH = ((lvl-2)*30)
        let rangeL = 1
        let num1 = randomInt(min: rangeL, max: 10)
        let num2 = randomInt(min: rangeL, max: 10)
        textView1.text = String(num1) + "*" + String(num2)
        return num1 * num2;
    }
    
    func power(num: Int, power: Int) -> Int{
        return Int(pow(Double(num), Double(power)))
    }
    
    func textViewDidChange(_ textView: UITextView) { //Handle the text changes here
            print(textView.text); //the textView parameter is the textView where text was changed
        }
    
    @objc func timerAction(){
        timeLeft-=1
        time.text = "Time Left: " + String(timeLeft)
        if(timeLeft <= 0){
            endgame()
        }
        
        }
    

    func randomInt(min: Int, max: Int) -> Int {
        return min + Int(arc4random_uniform(UInt32(max - min + 1)))
    }
    
    func randomButton(Anw: Int, sign: Int){
        let a = [button1, button2, button3, button4]
        var num = randomInt(min: 0, max: 3)
        var b = [0]
        b.append(Anw)
        for button in a{
            var num2 = randomInt(min: Int(0.9*Double(Anw)), max: Int(1.1*Double(Anw)))
            var cc = 0
            while(b.contains(Int(num2))){
                cc += 1
                num2 = randomInt(min: Int(0.7*Double(Anw)), max: Int(1.3*Double(Anw)))
                if(cc >= 100){
                    while(num2 == Anw){
                        num2 = randomInt(min: 0, max: 2*Anw)
                    }
                    break
                }
            }
            b.append(num2)
            button?.setTitle(String(num2), for: .normal)
        }
        b = [0]
        a[num]?.setTitle(String(Anw), for: .normal)
        c = num
        
    }
    
    @IBAction func button1Clicked(_ sender: Any) {
        if(c == 0){
            timeLeft += 2
            correctAnswers+=1
            if(correctAnswers % 5 == 0){
                lvl += 1
            }
        }else{
            livesLeft -= 1
        }
        timer.invalidate()
        viewDidLoad()
    }
    
    @IBAction func button2Clicked(_ sender: Any) {
        if(c == 1){
            timeLeft += 2
            correctAnswers+=1
            if(correctAnswers % 5 == 0){
                lvl += 1
            }
        }else{
            livesLeft -= 1
        }
        timer.invalidate()
        viewDidLoad()
    }
    @IBAction func button3Clicked(_ sender: Any) {
        if(c == 2){
            timeLeft += 2
            correctAnswers+=1
            if(correctAnswers % 5 == 0){
                lvl += 1
            }
        }else{
            livesLeft -= 1
        }
        timer.invalidate()
        viewDidLoad()
        
    }
    @IBAction func button4Clicked(_ sender: Any) {
        if(c == 3){
            timeLeft += 2
            correctAnswers+=1
            if(correctAnswers % 5 == 0){
                lvl += 1
            }
        }else{
            livesLeft -= 1
        }
        timer.invalidate()
        viewDidLoad()
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
