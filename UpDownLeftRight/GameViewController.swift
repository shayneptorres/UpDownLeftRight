//
//  GameViewController.swift
//  UpDownLeftRight
//
//  Created by Shayne Torres on 3/8/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    // Variables
    @IBOutlet weak var directionDisplay: UILabel!
    @IBOutlet weak var correctSwipeCountDisplay: UILabel!
    @IBOutlet weak var incorrectSwipeCountDisplay: UILabel!
    @IBOutlet weak var startGameButton: UIButton!
    var swipeDirection: String = ""
    var miniTimerCount: Int = 0
    var gameTimerCount: Int = 0
    var startUpTimerCount: Int = 3
    var startUpTimer = NSTimer()
    var miniTimer = NSTimer()
    var gameTimer = NSTimer()
    var correctSwipes: Int = 0
    var incorrectSwipes: Int = 0
    var ratio: Int = 0
    
    var defaults = NSUserDefaults.standardUserDefaults()
    
    // Swipe Recognizers
    override func viewDidLoad(){
        super.viewDidLoad()
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        leftSwipe.direction = .Left
        self.view!.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        rightSwipe.direction = .Right
        self.view!.addGestureRecognizer(rightSwipe)
        
        let upSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        upSwipe.direction = .Up
        self.view!.addGestureRecognizer(upSwipe)
        
        let downSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        downSwipe.direction = .Down
        self.view!.addGestureRecognizer(downSwipe)
    }
    
    // Swipe Handlers
    func handleSwipes(sender: UISwipeGestureRecognizer){
        if sender.direction == .Up {
            swipeDirection = "UP"
        } else if sender.direction == .Down {
            swipeDirection = "DOWN"
        } else if sender.direction == .Left {
            swipeDirection = "LEFT"
        } else if sender.direction == .Right {
            swipeDirection = "RIGHT"
        }
        
        if swipeDirection == directionDisplay.text {
            correctSwipes++
            correctSwipeCountDisplay.text = "Correct: \(correctSwipes)"
            generateNextDirection()
        } else {
            incorrectSwipes++
            incorrectSwipeCountDisplay.text = "Incorrect: \(incorrectSwipes)"
            generateNextDirection()
        }
    }
    
    // Game Functions
    func gameOver(){
        goToNextView()
    }
    
    // Signals the next View
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Game Over" {
            _ = segue.destinationViewController as? GameOverViewController
            defaults.setInteger(correctSwipes, forKey: "correctSwipes")
            defaults.setInteger(incorrectSwipes, forKey: "incorrectSwipes")
            defaults.setInteger(ratio, forKey: "ratio")
        }
    }
    
    func goToNextView(){
        performSegueWithIdentifier("Game Over", sender: self)
    }
    
    
    @IBAction func startUpCounter(sender: UIButton) {
        startGameButton.hidden = true
        directionDisplay.text = "\(startUpTimerCount)"
        startUpTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "updateStartUpTimer", userInfo: nil, repeats: true)
    }
    
    func startGame() {
        correctSwipes = 0
        incorrectSwipes = 0
        generateNextDirection()
        gameTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "updateGameTimer", userInfo: nil, repeats: true)
    }
    
    // Displays the next Swipe direction
    func generateNextDirection(){
        miniTimer.invalidate()
            let randInt = String(arc4random_uniform(5))
                if randInt == "1" {
                    directionDisplay.text = "UP"
                } else if randInt == "2" {
                    directionDisplay.text = "DOWN"
                } else if randInt == "3" {
                    directionDisplay.text = "LEFT"
                } else if randInt == "4" {
                    directionDisplay.text = "RIGHT"
                }
                miniTimer = NSTimer.scheduledTimerWithTimeInterval(0.75, target: self, selector: "updateMiniTimer", userInfo: nil, repeats: true)
    }
    
    // Timer for game startup
    func updateStartUpTimer(){
        startUpTimerCount--
        directionDisplay.text = "\(startUpTimerCount)"
        if startUpTimerCount == 0 {
            startUpTimer.invalidate()
            startGame()
        }
    }
    
    // Timer for direction
    func updateMiniTimer(){
        miniTimerCount++
        if miniTimerCount > 1 {
            miniTimer.invalidate()
            generateNextDirection()
        }
    }
    
    // Timer for game
    func updateGameTimer(){
        gameTimerCount++
        if gameTimerCount > 60 {
            gameTimer.invalidate()
            miniTimer.invalidate()
            gameTimerCount = 0
            gameOver()
        }
    }
}
