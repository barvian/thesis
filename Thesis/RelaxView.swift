//
//  RelaxView.swift
//  Thesis
//
//  Created by WSOL Intern on 1/12/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit

@objc protocol RelaxViewDelegate {
    optional func didTapGrowingButton(button: UIButton!)
}

class RelaxView: UIView {
    
    weak var delegate: RelaxViewDelegate?
    
    lazy var growingButton: UIButton = {
        let button = UIButton.buttonWithType(.System) as UIButton
        button.setTranslatesAutoresizingMaskIntoConstraints(false)
        button.setTitle("Open!", forState: .Normal)
        button.layer.borderColor = UIColor.greenColor().CGColor
        button.layer.borderWidth = 3
        
        return button
    }()
    
    var buttonSize = CGSizeMake(100, 100)
    
    // MARK: Initializers
    
    convenience override init() {
        self.init(frame: CGRectZero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(growingButton)
        growingButton.addTarget(self.delegate, action: "didTapGrowingButton:", forControlEvents: .TouchUpInside)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: Constraints
    
    override class func requiresConstraintBasedLayout() -> Bool {
        return true
    }
    
    override func updateConstraints() {
        growingButton.mas_updateConstraints { make in
            make.center.equalTo()(self)
            make.width.equalTo()(self.buttonSize.width).priorityLow()
            make.height.equalTo()(self.buttonSize.height).priorityLow()
            make.width.lessThanOrEqualTo()(self)
            make.height.lessThanOrEqualTo()(self)
        }
        
        super.updateConstraints()
    }
    
    // MARK: Handlers
    
    func growButton() {
        buttonSize = CGSizeMake(buttonSize.width * 1.3, buttonSize.height * 1.3)
        
        // tell constraints they need updating
        setNeedsUpdateConstraints()
        
        // update constraints now so we can animate the change
        updateConstraintsIfNeeded()
        
        UIView.animateWithDuration(0.3, delay: 0.0, options: .AllowUserInteraction, animations: {
            self.layoutIfNeeded()
        }, completion: {
                (value: Bool) in
        })
    }
    
}


