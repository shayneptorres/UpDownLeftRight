//
//  GameOverView.swift
//  UpDownLeftRight
//
//  Created by Shayne Torres on 3/7/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import UIKit

class GameOverViewController: UIViewController {

    
    @IBAction func resetGame(sender: UIButton) {
        performSegueWithIdentifier("Reset Game", sender: self)
    }
    
}
