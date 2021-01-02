//
//  ViewController.swift
//  KennyGame
//
//  Created by Abdullah Oğuz on 15.11.2020.
//

import UIKit

class ViewController: UIViewController {

    //Variables
    let imageContainer = UIImageView()
    var timer = Timer()
    var hideTimer = Timer()
    var counter = 10
    var hinghscore = 0
    var score = 0
    var kennyArray = [UIImageView]()  //tum olusturacagimiz kennyleri kennyArray dizisinde topluyoruz

    //Storyboard kenny Imageview
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    @IBOutlet weak var kenny1: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny9: UIImageView!

    override func viewDidLoad() {
        // uygulama yuklendiginde calisacak kod blogu
        highscoreLabel.text = "Highscore : \(score)"

        super.viewDidLoad()
        //Images
        kenny1.isUserInteractionEnabled = true
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true
        kenny7.isUserInteractionEnabled = true
        kenny8.isUserInteractionEnabled = true
        kenny9.isUserInteractionEnabled = true

        //Recognizer
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(scoreIncrease))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(scoreIncrease))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(scoreIncrease))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(scoreIncrease))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(scoreIncrease))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(scoreIncrease))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(scoreIncrease))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(scoreIncrease))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(scoreIncrease))

        // Gesture
        kenny1.addGestureRecognizer(recognizer1)
        kenny2.addGestureRecognizer(recognizer2)
        kenny3.addGestureRecognizer(recognizer3)
        kenny4.addGestureRecognizer(recognizer4)
        kenny5.addGestureRecognizer(recognizer5)
        kenny6.addGestureRecognizer(recognizer6)
        kenny7.addGestureRecognizer(recognizer7)
        kenny8.addGestureRecognizer(recognizer8)
        kenny9.addGestureRecognizer(recognizer9)

        //user default veriables
        let storedHighscore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighscore == nil {
            hinghscore = 0
            highscoreLabel.text = "Highscore : \(hinghscore)"
        }
        
        if let newScore = storedHighscore as? Int {
            hinghscore = newScore
            highscoreLabel.text = "Highscore : \(hinghscore)"
        }
        
        // tum fotografli kenny ifadelerini dizilerde topluyoruz
        kennyArray = [kenny1, kenny2, kenny3, kenny4, kenny5, kenny6, kenny7, kenny8, kenny9]

        // zaman ile ilgili timer
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timeFunc), userInfo: nil, repeats: true)
        
        // kennyleri gizlemek izin timer
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
    }

    @objc func hideKenny() {
        for kenny in kennyArray {
            kenny.isHidden = true // tum kennyleri gorunmez yapiliyor
        }
        let random = Int(arc4random_uniform(UInt32(kennyArray.count - 1)))
        kennyArray[random].isHidden = false
        
        // rastgele olarak kennyleri ekranda gorunur yapiliyor
    }

    @objc func scoreIncrease() {
        score += 1
        scoreLabel.text = "Score : \(score)"
    }
    @objc func timeFunc() {
        timeLabel.text = "Time : \(counter)"
        counter -= 1

        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            timeLabel.text = "Time is over !"

            for kenny in kennyArray {
                kenny.isHidden = true
            }

            if self.score > self.hinghscore {
                highscoreLabel.text = "Highscore \(self.score)"
                UserDefaults.standard.set(highscoreLabel.text, forKey: "highscore")
            }

            //Alert
            let alert = UIAlertController(title: "Time over !", message: "Do you want play again", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "No", style: UIAlertAction.Style.cancel, handler: nil)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { (UIAlertAction) in
                self.score = 0
                self.counter = 10
                self.scoreLabel.text = "Score: \(self.score)"
                self.timeLabel.text = "Time : \(self.counter)"

                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timeFunc), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideKenny), userInfo: nil, repeats: true)
            }
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
        }

    }
}


