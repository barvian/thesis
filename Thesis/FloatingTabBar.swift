//
//  FloatingTabBar.swift
//  Thesis
//
//  Created by Maxwell Barvian on 2/9/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit

class FloatingTabBar: UITabBar {

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        translucent = true
        shadowImage = UIImage()
        backgroundColor = UIColor.clearColor()
        backgroundImage = UIImage()
    }
    
    override func sizeThatFits(size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = 64
        
        return sizeThatFits
    }
    
}
