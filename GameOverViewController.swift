//
//  GameOverView.swift
//  UpDownLeftRight
//
//  Created by Shayne Torres on 3/7/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import UIKit

class GameOverViewController: GameViewController {

    @IBOutlet weak var finalRatioDisplay: UILabel!
    @IBOutlet weak var finalCorrectCountDisplay: UILabel!
    @IBOutlet weak var finalIncorrectCountDisplay: UILabel!
    @IBOutlet weak var resultsButton: UIButton!
    var finalCorrectCount: Int = 0
    var finalIncorrectCount: Int = 0
    var finalRatio: Int = 0
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
 

    @IBAction func showResults() {
        finalCorrectCountDisplay.hidden = false
        finalIncorrectCountDisplay.hidden = false
        finalRatioDisplay.hidden = false
        
        finalCorrectCountDisplay.text = "Correct: \(defaults.integerForKey("correctSwipes"))"
        finalIncorrectCountDisplay.text = "Incorrect: \(defaults.integerForKey("incorrectSwipes"))"
        finalRatioDisplay.text = "Ratio: \(defaults.integerForKey("correctSwipes")/defaults.integerForKey("incorrectSwipes") + defaults.integerForKey("correctSwipes"))"
    }
    
    @IBAction func resetGame(sender: UIButton) {
        performSegueWithIdentifier("Reset Game", sender: self)
    }
    
}
