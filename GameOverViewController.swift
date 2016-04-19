//
//  GameOverView.swift
//  UpDownLeftRight
//
//  Created by Shayne Torres on 3/7/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import UIKit

class GameOverViewController: GameViewController {

    @IBOutlet weak var finalPointsLabel: UILabel!
    @IBOutlet weak var finalPointsDisplay: UILabel!
    @IBOutlet weak var highScoreDisplay: UILabel!
    @IBOutlet weak var longestStreakDisplay: UILabel!
    
    var finalPointsTotal: Int = 0
    var highscore = 0
    var HighScoreDefaults = NSUserDefaults.standardUserDefaults()
    var nf2 = NSNumberFormatter()
    
    override func viewDidLoad() {
        if HighScoreDefaults.valueForKey("highScore") != nil {
            highscore = HighScoreDefaults.integerForKey("highScore")
        } else {
            HighScoreDefaults.setInteger(finalPointsTotal, forKey: "highScore")
            highscore = HighScoreDefaults.integerForKey("highScore")
        }
        
        showResults()
    }
 
    func showResults() {
        nf2.numberStyle = NSNumberFormatterStyle.DecimalStyle
        finalPointsDisplay.hidden = false
        highScoreDisplay.hidden = false
        longestStreakDisplay.hidden = false
        let finalLongestStreak = defaults.integerForKey("longestStreak")
        finalPointsTotal = defaults.integerForKey("totalPoints")
        finalPointsDisplay.text = "\(nf2.stringFromNumber(defaults.integerForKey("totalPoints"))!)"
        longestStreakDisplay.text = "\(finalLongestStreak)"
        checkHighScore()
        highScoreDisplay.text = "\(nf2.stringFromNumber(highscore)!)"
    }
    
    @IBAction func resetGame(sender: UIButton) {
        performSegueWithIdentifier("Reset Game", sender: self)
    }
    
    func checkHighScore(){
        if finalPointsTotal > highscore {
            highscore = finalPointsTotal
            HighScoreDefaults.setInteger(highscore, forKey: "highScore")
        }
    }
}