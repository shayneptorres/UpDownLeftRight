//
//  ViewController.swift
//  UpDownLeftRight
//
//  Created by Shayne Torres on 3/6/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import UIKit

class StartUpViewController: UIViewController {

    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var gameTitle: UIImageView!
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destination = segue.destinationViewController as UIViewController
        
        if let _ = destination as? GameViewController {
            if let identifier = segue.identifier {
                switch identifier {
                case "Begin Game": break
                default: break
                }
            }
        }
    }
}