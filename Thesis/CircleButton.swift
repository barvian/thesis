//
//  CircleButton.swift
//  Thesis
//
//  Created by Maxwell Barvian on 2/9/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import Foundation

class CircleButton: UIButton {
    
    // MARK: Initializers
    
    convenience override init() {
        self.init(frame: CGRectZero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.whiteColor()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: Drawing
    
    override func drawRect(rect: CGRect) {
        setTitleColor(tintColor, forState: .Normal)
        
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowRadius = 4
        layer.shadowColor = UIColor.blackColor().CGColor
        layer.shadowOpacity = 0.1
        layer.masksToBounds = true
    }
    
    override func tintColorDidChange() {
        super.tintColorDidChange()
        setNeedsDisplay()
    }
    
    override func intrinsicContentSize() -> CGSize {
        return CGSize(width: 70, height: 70)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = frame.height / 2
    }

    
}