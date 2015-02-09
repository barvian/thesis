//
//  AddReflectionPageView.swift
//  Thesis
//
//  Created by Maxwell Barvian on 2/8/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit
import SSDynamicText

class AddReflectionPageView: UIView {
    
    weak var delegate: ReflectHeaderViewDelegate?
    
    private(set) lazy var headlineLabel: UILabel = {
        let label = SSDynamicLabel(font: "HelveticaNeue-Light", baseSize: 23.0)
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        label.textColor = UIColor.grayColor()
        label.lineBreakMode = .ByTruncatingTail
        label.numberOfLines = 0
        label.textAlignment = .Left
        
        return label
    }()
    
    private(set) lazy var textView: UITextView = {
        let textView = SSDynamicTextView(font: "HelveticaNeue-Light", baseSize: 21.0)
        textView.setTranslatesAutoresizingMaskIntoConstraints(false)
        textView.textAlignment = .Left
        textView.returnKeyType = .Next
        
        return textView
    }()
    
    // MARK: Initializers
    
    convenience override init() {
        self.init(frame: CGRectZero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.redColor()
        
//        addSubview(headlineLabel)
//        addSubview(textView)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: Constraints
    
    override class func requiresConstraintBasedLayout() -> Bool {
        return true
    }
    
//    private var didSetupConstraints = false
//    
//    override func updateConstraints() {
//        if !didSetupConstraints {
//            let views = [
//                "headlineLabel": headlineLabel,
//                "textView": textView
//            ]
//            let metrics = [
//                "margin": 26
//            ]
//            
//            addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-(margin)-[headlineLabel]-(margin)-[textView]-(margin)-|", options: nil, metrics: metrics, views: views))
//            addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(margin)-[headlineLabel]-(margin)-|", options: nil, metrics: metrics, views: views))
//            addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(margin)-[textView]-(margin)-|", options: nil, metrics: metrics, views: views))
//            
//            didSetupConstraints = true
//        }
//        
//        super.updateConstraints()
//    }
    
}