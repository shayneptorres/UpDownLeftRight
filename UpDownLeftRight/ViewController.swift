//
//  ViewController.swift
//  UpDownLeftRight
//
//  Created by Shayne Torres on 3/6/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
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
    
    var swipeDirection: String = ""
    var timerCount: Int = 0
    var timer = NSTimer()
    
    
    @IBOutlet weak var testLabel: UILabel!
    
    func handleSwipes(sender: UISwipeGestureRecognizer){
        if sender.direction == .Up {
            swipeDirection = "Up"
        } else if sender.direction == .Down {
            swipeDirection = "Down"
        } else if sender.direction == .Left {
            swipeDirection = "Left"
        } else if sender.direction == .Right {
            swipeDirection = "Right"
        }
    }
    
    func generateNextDirection(){
    let randInt = String(arc4random_uniform(5))
        if randInt == "1" {
            testLabel.text = "UP"
        } else if randInt == "2" {
            testLabel.text = "DOWN"
        } else if randInt == "3" {
            testLabel.text = "LEFT"
        } else if randInt == "4" {
            testLabel.text = "RIGHT"
        }
        timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "update", userInfo: nil, repeats: true)
    }
    
    func update(){
        timerCount++
        if timerCount > 5 {
            timer.invalidate()
            generateNextDirection()
        }
    }
    
    @IBAction func playGame(sender: UIButton) {
        generateNextDirection()
    }
}