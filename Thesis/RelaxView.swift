//
//  RelaxView.swift
//  Thesis
//
//  Created by WSOL Intern on 1/12/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit

@objc protocol RelaxViewDelegate {
    optional func didTapGrowingButton()
}

class RelaxView: UIView {
    
    weak var delegate: RelaxViewDelegate?
    
    lazy var growingButton: UIButton = {
        let button = UIButton.buttonWithType(.System) as UIButton
        button.setTranslatesAutoresizingMaskIntoConstraints(false)
        button.setTitle("Open!", forState: .Normal)
        button.layer.borderColor = UIColor.greenColor().CGColor
        button.layer.borderWidth = 3
        button.addTarget(self, action: "didTapGrowingButton:", forControlEvents: .TouchUpInside)
        
        return button
    }()
    
    lazy var resizingLabel: UILabel = {
        let label = UILabel()
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        label.text = "This label will resize."
        label.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        
        return label
    }()
    
    // MARK: Initializers
    
    convenience override init() {
        self.init(frame: CGRectZero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.borderColor = UIColor.purpleColor().CGColor
        layer.borderWidth = 3
        
        addSubview(growingButton)
        addSubview(resizingLabel)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: Constraints
    
    override class func requiresConstraintBasedLayout() -> Bool {
        return true
    }
    
    private var didSetupConstraints = false
    
    private var buttonSize = CGSizeMake(100, 100)
    private var growingButtonWidthConstraint: NSLayoutConstraint!, growingButtonHeightConstraint: NSLayoutConstraint!
    
    override func updateConstraints() {
        if !didSetupConstraints {
            growingButtonWidthConstraint = NSLayoutConstraint(item: growingButton, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 0)
            growingButton.setContentHuggingPriority(251, forAxis: .Horizontal)
            growingButtonHeightConstraint = NSLayoutConstraint(item: growingButton, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 0)
            growingButton.setContentHuggingPriority(251, forAxis: .Vertical)
            addConstraint(growingButtonWidthConstraint)
            addConstraint(growingButtonHeightConstraint)
            addConstraint(NSLayoutConstraint(item: growingButton, attribute: .Width, relatedBy: .LessThanOrEqual, toItem: self, attribute: .Width, multiplier: 1, constant: 0))
            addConstraint(NSLayoutConstraint(item: growingButton, attribute: .Height, relatedBy: .LessThanOrEqual, toItem: self, attribute: .Height, multiplier: 1, constant: 0))
            addConstraint(NSLayoutConstraint(item: growingButton, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: 0))
            addConstraint(NSLayoutConstraint(item: growingButton, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: 0))
            
            addConstraint(NSLayoutConstraint(item: resizingLabel, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: 0))
            addConstraint(NSLayoutConstraint(item: resizingLabel, attribute: .Bottom, relatedBy: .Equal, toItem: growingButton, attribute: .Top, multiplier: 1, constant: 0))
            
            didSetupConstraints = true
        }
        
        growingButtonWidthConstraint.constant = buttonSize.width
        growingButtonHeightConstraint.constant = buttonSize.height
        
        super.updateConstraints()
    }
    
    // MARK: Handlers
    
    func didTapGrowingButton(button: UIButton!) {
        delegate?.didTapGrowingButton?()
    }
    
    // MARK: API
    
    func growButton() {
        buttonSize = CGSizeMake(buttonSize.width * 1.3, buttonSize.height * 1.3)
        
        // tell constraints they need updating
        setNeedsUpdateConstraints()
        
        // update constraints now so we can animate the change
        updateConstraintsIfNeeded()
        
        UIView.animateWithDuration(0.3) {
            self.layoutIfNeeded()
        }
    }
    
}


