//
//  GameBrain.swift
//  UpDownLeftRight
//
//  Created by Shayne Torres on 3/14/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import Foundation

class GameBrain {
    var correctSwipes: Int = 0
    var incorrectSwipes: Int = 0
    
    func incrementCorrectSwipes()->Int{
        correctSwipes++
        return correctSwipes
    }
    
    func incrementIncorrectSwipes()->Int{
        incorrectSwipes++
        return incorrectSwipes
    }
    
    func getCorrectCount()->Int{
        return correctSwipes
    }
    
    func getIncorrectSwipes()->Int{
        return incorrectSwipes
    }
    
    func resetCounts(){
        correctSwipes = 0
        incorrectSwipes = 0
    }
}
