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
    var finalPointsTotal: Int = 0
    var finalCorrectCount: Float = 0
    var finalIncorrectCount: Float = 0
    var finalRatio: Float = 0
    private let cScore = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        showResults()
    }
    
    var correctScore: Int {
        get{
            return cScore.integerForKey(String(correctSwipes))
        }
        set{
            cScore.setInteger(Int(finalCorrectCount), forKey: "correctSwipes")
        }
    }
 
/*

handle zero user input error
slow down the instructions (e.g. "left", "right", etc)
signal text change so that back to back matching commands are obvious
brief instructions

*/
    func showResults() {
        finalPointsDisplay.hidden = false
        let totalSwipes = defaults.floatForKey("correctSwipes") + defaults.floatForKey("incorrectSwipes")
        finalCorrectCount = defaults.floatForKey("correctSwipes")
        finalIncorrectCount = defaults.floatForKey("incorrectSwipes")
        finalPointsTotal = defaults.integerForKey("totalPoints")
        finalPointsDisplay.text = "\(finalPointsTotal)"
    }
    
    @IBAction func resetGame(sender: UIButton) {
        performSegueWithIdentifier("Reset Game", sender: self)
    }
    
}
