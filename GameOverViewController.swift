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
    var finalCorrectCount: Float = 0
    var finalIncorrectCount: Float = 0
    var highScore = 0
    override func viewDidLoad() {
        showResults()
    }
 
    func showResults() {

        finalPointsDisplay.hidden = false
        highScoreDisplay.hidden = false
        finalCorrectCount = defaults.floatForKey("correctSwipes")
        finalIncorrectCount = defaults.floatForKey("incorrectSwipes")
        finalPointsTotal = defaults.integerForKey("totalPoints")
        finalPointsDisplay.text = "\(finalPointsTotal)"
        highScoreDisplay.text = "\(defaults.integerForKey("highScore"))"
    }
    
    @IBAction func resetGame(sender: UIButton) {
        performSegueWithIdentifier("Reset Game", sender: self)
    }
}
