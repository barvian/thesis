//
//  FloatingTabBar.swift
//  Thesis
//
//  Created by Maxwell Barvian on 2/9/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit

class FloatingTabBar: UITabBar {
    
    var color: UIColor = UIColor.clearColor() {
        willSet {
            backgroundImage = UIImage(named: "TabBarBlur")?.add_tintedImageWithColor(newValue, style: ADDImageTintStyleKeepingAlpha)
        }
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        translucent = true
        shadowImage = UIImage()
        backgroundColor = UIColor.clearColor()
    }
    
    override func setItems(items: [AnyObject]?, animated: Bool) {
        super.setItems(items, animated: animated)
        
        if let tabs = items as? [UITabBarItem] {
            for tab in tabs {
                tab.setTitlePositionAdjustment(UIOffsetMake(0, -5.0))
            }
        }
    }
    
    override func sizeThatFits(size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = 64
        
        return sizeThatFits
    }
    
}
