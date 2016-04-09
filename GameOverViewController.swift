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
    
    var finalPointsTotal: Int = 0
    var highscore = 0
    var HighScoreDefaults = NSUserDefaults.standardUserDefaults()
    
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
        finalPointsDisplay.hidden = false
        highScoreDisplay.hidden = false
        finalPointsTotal = defaults.integerForKey("totalPoints")
        finalPointsDisplay.text = "\(finalPointsTotal)"
        checkHighScore()
        highScoreDisplay.text = "\(highscore)"
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
