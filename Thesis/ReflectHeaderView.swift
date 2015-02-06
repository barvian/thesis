//
//  AddReflectionView.swift
//  Thesis
//
//  Created by Maxwell Barvian on 2/5/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit

@objc protocol ReflectHeaderViewDelegate {
    optional func didTapAddButton()
}

class ReflectHeaderView: UIView {
    
    weak var delegate: ReflectHeaderViewDelegate?
    
    private(set) lazy var addButton: UIButton = {
        let button = UIButton.buttonWithType(.System) as UIButton
        button.setTranslatesAutoresizingMaskIntoConstraints(false)
        button.setTitle("Add", forState: .Normal)
        button.layer.borderColor = UIColor.greenColor().CGColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 25
        button.addTarget(self, action: "didTapAddButton:", forControlEvents: .TouchUpInside)
        
        return button
    }()
    
    // MARK: Initializers
    
    convenience override init() {
        self.init(frame: CGRectZero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(addButton)
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
                "addButton": addButton
            ]
            let metrics = [
                "addButtonSize": addButton.layer.cornerRadius * 2
            ]
            
            addConstraint(NSLayoutConstraint(item: addButton, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: 0))
            addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[addButton(addButtonSize)]-|", options: nil, metrics: metrics, views: views))
            addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("[addButton(addButtonSize)]", options: nil, metrics: metrics, views: views))

            didSetupConstraints = true
        }
        
        super.updateConstraints()
    }
    
    // MARK: Handlers
    
    func didTapAddButton(button: UIButton!) {
        delegate?.didTapAddButton?()
    }
    
}