//
//  SlidingTabBar.swift
//  Thesis
//
//  Created by Maxwell Barvian on 1/26/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit

@objc protocol SlidingTabBarDelegate {
    optional func didSelectItem()
}

class SlidingTabBar: UIView {
    
    weak var delegate: SlidingTabBarDelegate?
    
    var items: [UITabBarItem]!
    
    var selectedItem: UITabBarItem?
    
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
    
    override func intrinsicContentSize() -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    private var didSetupConstraints = false
    
    override func updateConstraints() {
        if !didSetupConstraints {
            removeConstraints(constraints())
            
            
            
            didSetupConstraints = true
        }
        
        super.updateConstraints()
    }
    
    // MARK: Handlers
    
    func didSelectItem(button: UIButton!) {
        delegate?.didSelectItem?()
    }    
}


