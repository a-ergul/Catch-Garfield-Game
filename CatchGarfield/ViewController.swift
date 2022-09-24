//
//  ViewController.swift
//  CatchGarfield
//
//  Created by Alpay Ergül on 24.09.2022.
//

import UIKit

class ViewController: UIViewController {
    //Variables
    var score = 0
    var timer = Timer()
    var hideTimer = Timer()
    var counter = 0
    var garfieldArray = [UIImageView] ()
    var highScore = 0
    
    //Views
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    

    @IBOutlet weak var garfield1: UIImageView!
    @IBOutlet weak var garfield2: UIImageView!
    @IBOutlet weak var garfield3: UIImageView!
    @IBOutlet weak var garfield4: UIImageView!
    @IBOutlet weak var garfield5: UIImageView!
    @IBOutlet weak var garfield6: UIImageView!
    @IBOutlet weak var garfield7: UIImageView!
    @IBOutlet weak var garfield8: UIImageView!
    @IBOutlet weak var garfield9: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = "Score: \(score)"
        
        // High Score check
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighScore == nil {
            highScore = 0
            highScoreLabel.text = "High Score: \(highScore)"
        }
        
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highScoreLabel.text = "High Score: \(highScore)"
        }
        
        // User Click enable Images
        garfield1.isUserInteractionEnabled = true
        garfield2.isUserInteractionEnabled = true
        garfield3.isUserInteractionEnabled = true
        garfield4.isUserInteractionEnabled = true
        garfield5.isUserInteractionEnabled = true
        garfield6.isUserInteractionEnabled = true
        garfield7.isUserInteractionEnabled = true
        garfield8.isUserInteractionEnabled = true
        garfield9.isUserInteractionEnabled = true
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        
        garfield1.addGestureRecognizer(recognizer1)
        garfield2.addGestureRecognizer(recognizer2)
        garfield3.addGestureRecognizer(recognizer3)
        garfield4.addGestureRecognizer(recognizer4)
        garfield5.addGestureRecognizer(recognizer5)
        garfield6.addGestureRecognizer(recognizer6)
        garfield7.addGestureRecognizer(recognizer7)
        garfield8.addGestureRecognizer(recognizer8)
        garfield9.addGestureRecognizer(recognizer9)
        
        garfieldArray = [garfield1, garfield2, garfield3, garfield4, garfield5, garfield6, garfield7, garfield8, garfield9]
        
        //Timers
        counter = 20
        timeLabel.text = String(counter)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideGarfield), userInfo: nil, repeats: true)
        
        hideGarfield()
    }
    
    @objc func hideGarfield() {
        for garfield in garfieldArray {
            garfield.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(garfieldArray.count - 1 )))
        garfieldArray[random].isHidden = false
    }
    
    @objc func increaseScore() {
        score += 1
        scoreLabel.text = "Score: \(score)"
    }
    
    @objc func countDown() {
        counter -= 1
        timeLabel.text = String(counter)
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            for garfield in garfieldArray {
                garfield.isHidden = true
            }
            
            // High Score
            if self.score > self.highScore {
                self.highScore = self.score
                highScoreLabel.text = "High Score: \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highscore")
            }
            
            
            // Alert
            
            let alert = UIAlertController(title: "Time's Up", message: "Do yuo want to play again ? ", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { (UIAlertAction) in
                //replay func
                self.score = 0
                self.scoreLabel.text = "Scote: \(self.score)"
                self.counter = 20
                self.timeLabel.text=String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideGarfield), userInfo: nil, repeats: true)
            }
            
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
        }
    }
}

