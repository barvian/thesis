//
//  LearnHeaderView.swift
//  Thesis
//
//  Created by WSOL Intern on 2/9/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit
import SSDynamicText

@objc protocol LearnHeaderViewDelegate {
    optional func learnHeaderView(learnHeaderView: LearnHeaderView, didTapHowToUseButton howToUseButton: UIButton!)
}

class LearnHeaderView: UIView {
    
    weak var delegate: LearnHeaderViewDelegate?
    
    private(set) lazy var ℹ️Button: UIButton = {
        let button = UIButton.buttonWithType(.System) as UIButton
        button.setTranslatesAutoresizingMaskIntoConstraints(false)
        button.setTitle("How to use this app", forState: .Normal)
        button.contentEdgeInsets = UIEdgeInsetsMake(14, 14, 14, 14)
        button.contentHorizontalAlignment = .Left
        button.backgroundColor = UIColor.whiteColor()
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor(r: 0, g: 0, b: 0, a: 0.1).CGColor
        button.layer.borderWidth = 0.5
        button.layer.shadowOffset = CGSize(width: 0, height: 1)
        button.layer.shadowRadius = 1.5
        button.layer.shadowColor = UIColor.blackColor().CGColor
        button.layer.shadowOpacity = 0.075

        button.addTarget(self, action: "didTapHowToUseButton:", forControlEvents: .TouchUpInside)
        
        return button
    }()
    
    // MARK: Initializers
    
    convenience override init() {
        self.init(frame: CGRectZero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(ℹ️Button)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: Constraints
    
    override class func requiresConstraintBasedLayout() -> Bool {
        return true
    }
    
    private var didSetupConstraints = false
    
    override func updateConstraints() {
        if !didSetupConstraints {
            let views = [
                "howToUseButton": ℹ️Button
            ]
            let metrics = [
                "margin": 14
            ]
            
            addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-(margin)-[howToUseButton]-(margin)-|", options: nil, metrics: metrics, views: views))
            addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(margin)-[howToUseButton]-(margin)-|", options: nil, metrics: metrics, views: views))
            
            didSetupConstraints = true
        }
        
        super.updateConstraints()
    }
    
    // MARK: Handlers
    
    func didTapHowToUseButton(button: UIButton!) {
        delegate?.learnHeaderView?(self, didTapHowToUseButton: button)
    }
    
}