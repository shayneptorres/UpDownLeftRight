//
//  Direction.swift
//  UpDownLeftRight
//
//  Created by Shayne Torres on 4/8/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import Foundation
import UIKit

class Direction {
    var image: UIImage
    var value:String
    
    init(){
        self.value = ""
        self.image = UIImage(named: "sq3")!
    }
    
    init(direction: String, imageName: String){
        self.value = direction
        self.image = UIImage(named: "\(imageName)")!
    }
}
