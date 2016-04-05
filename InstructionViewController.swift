//
//  InstructionViewController.swift
//  UpDownLeftRight
//
//  Created by Shayne Torres on 4/5/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import UIKit

class InstructionViewController: UIViewController {
    
    @IBOutlet weak var playButton: UIButton!
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destination = segue.destinationViewController as UIViewController
        
        if let _ = destination as? GameViewController{
            if let identifier = segue.identifier {
                switch identifier {
                case "Begin Game": break
                default: break
                }
            }
        }
    }

}
