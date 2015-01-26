//
//  SlidingTabBar.swift
//  Thesis
//
//  Created by Maxwell Barvian on 1/26/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit

@objc protocol SlidingTabBarDelegate {
    optional func didTapTab()
}

class SlidingTabBar: UIView {
    
    weak var delegate: SlidingTabBarDelegate?
    
    // MARK: Initializers
    
    convenience override init() {
        self.init(frame: CGRectZero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
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
            didSetupConstraints = true
        }
        
        super.updateConstraints()
    }
    
    // MARK: Handlers
    
    func didTapTab(button: UIButton!) {
        delegate?.didTapTab?()
    }    
}


