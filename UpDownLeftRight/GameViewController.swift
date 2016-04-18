//
//  GameViewController.swift
//  UpDownLeftRight
//
//  Created by Shayne Torres on 3/8/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//



//////////
/*
Implement Longest streak
Add an "X" for no swipe
implement double finger swipes
*/
//////////

import UIKit

class GameViewController: UIViewController {
    // Outlets
    @IBOutlet weak var gameClock: UILabel!
    @IBOutlet weak var directionDisplay: UILabel!
    @IBOutlet weak var pointsDisplay: UILabel!
    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var directionImageDisplay: UIImageView!
    @IBOutlet weak var multiplierDisplay: UILabel!
    
    // Variables
    var swipeDirection: String = ""
    var miniTimerCount: Int = 0
    var gameTimerCount: Int = 30
    var startUpTimerCount: Int = 3
    var correctSwipes: Int = 0
    var incorrectSwipes: Int = 0
    var totalPoints: Int = 0
    var correctStreak: Int = 0
    var multiplier: Int = 1
    var gameHasStarted: Bool = false
    var currentMultiplier: Int = 1
    var longestStreak: Int = 0
    var tempLongestStreak: Int = 0
    
    // Timers
    var startUpTimer = NSTimer()
    var miniTimer = NSTimer()
    var gameTimer = NSTimer()
    
    // Direction Objects
    var currentDirection = Direction()
    var upObject = Direction(direction: "UP", imageName: "upArrow")
    var downObject = Direction(direction: "DOWN", imageName: "downArrow")
    var leftObject = Direction(direction: "LEFT", imageName: "leftArrow")
    var rightObject = Direction(direction: "RIGHT", imageName: "rightArrow")
    
    // Defaults
    var defaults = NSUserDefaults.standardUserDefaults()
    
    // Swipe Recognizers
    override func viewDidLoad(){
        super.viewDidLoad()
        multiplierDisplay.text = "Multiplier: x1"
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
        if gameHasStarted {
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
                tempLongestStreak++
                correctSwipes++
                correctStreak++
                if correctStreak >= 10 {
                    setNewMultiplier(5)
                }
                
                if correctStreak >= 25 {
                    setNewMultiplier(10)
                }
                
                if correctStreak >= 50 {
                    setNewMultiplier(100)
                }
                totalPoints += 100 * currentMultiplier
            } else {
                setLongestStreak()
                tempLongestStreak = 0
                setNewMultiplier(1)
                incorrectSwipes++
                correctStreak = 0
                totalPoints -= 100
            }
            fadeOutDirection()
            generateNextDirection()
            pointsDisplay.text = "\(totalPoints)"
            multiplierDisplay.text = "Multiplier: x\(currentMultiplier)"
        }
        
    }
    
    // Game Functions
    func gameOver(){
        goToNextView()
    }
    
    func fadeOutDirection(){
        UIView.animateWithDuration(0.1, delay: 0.1, options: UIViewAnimationOptions.CurveEaseIn, animations: {self.directionImageDisplay.alpha = 0.0}, completion: nil)
    }
    
    func fadeInDirection(){
        UIView.animateWithDuration(0.1, delay: 0.1, options: UIViewAnimationOptions.CurveEaseIn, animations: {self.directionImageDisplay.alpha = 1.0}, completion: nil)
    }
    
    func setNewMultiplier(num: Int){
        currentMultiplier = num
    }
    
    func didNotSwipe(){
        setLongestStreak()
        tempLongestStreak = 0
        correctStreak = 0
        totalPoints -= 100
        setNewMultiplier(1)
        fadeOutDirection()
        pointsDisplay.text = "\(totalPoints)"
        generateNextDirection()
    }
    
    func setLongestStreak(){
        if tempLongestStreak > longestStreak {
            longestStreak = tempLongestStreak
        } 
    }
    
    // Signals the next View
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Game Over" {
            _ = segue.destinationViewController as? GameOverViewController
            defaults.setInteger(longestStreak, forKey: "longestStreak")
            defaults.setInteger(correctSwipes, forKey: "correctSwipes")
            defaults.setInteger(incorrectSwipes, forKey: "incorrectSwipes")
            defaults.setInteger(totalPoints, forKey: "totalPoints")
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
        gameHasStarted = true
        generateNextDirection()
        correctSwipes = 0
        incorrectSwipes = 0
        gameTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "updateGameTimer", userInfo: nil, repeats: true)
    }
    
    // Displays the next Swipe direction
    func generateNextDirection(){
        fadeInDirection()
        miniTimer.invalidate()
        let randInt = String(arc4random_uniform(5))
        if randInt == "1" {
            currentDirection = upObject
        } else if randInt == "2" {
            currentDirection = downObject
        } else if randInt == "3" {
            currentDirection = leftObject
        } else {
            currentDirection = rightObject
        }
        directionDisplay.text = currentDirection.value
        directionImageDisplay.image = currentDirection.image
        miniTimer = NSTimer.scheduledTimerWithTimeInterval(0.75, target: self, selector: "updateMiniTimer", userInfo: nil, repeats: true)
    }
    
    // Timer for game startup countdown
    func updateStartUpTimer(){
        startUpTimerCount--
        directionDisplay.text = "\(startUpTimerCount)"
        if startUpTimerCount == 0 {
            startUpTimer.invalidate()
            startGame()
        }
    }
    
    // Timer for direction change
    func updateMiniTimer(){
        miniTimerCount++
        if miniTimerCount > 1 {
            miniTimer.invalidate()
            didNotSwipe()
        }
    }
    
    // Timer for game
    func updateGameTimer(){
        gameTimerCount--
        gameClock.text = "Time: \(gameTimerCount)"
        if gameTimerCount == 0 {
            gameTimer.invalidate()
            miniTimer.invalidate()
            gameTimerCount = 30
            gameOver()
        }
    }
}
