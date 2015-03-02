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
		let label = UILabel.applicationHeaderLabel(shadow: false, thin: true)
		label.setTranslatesAutoresizingMaskIntoConstraints(false)
		label.textColor = UIColor.grayColor()
		
		return label
	}()
	
	private(set) lazy var textView: UITextView = {
		let textView = SSDynamicTextView(font: "HelveticaNeue-Light", baseSize: 21.0)
		textView.setTranslatesAutoresizingMaskIntoConstraints(false)
		textView.textAlignment = .Center
		
		return textView
	}()
	
	// MARK: Initializers
	
	convenience override init() {
		self.init(frame: CGRectZero)
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		addSubview(headlineLabel)
		addSubview(textView)
	}
	
	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	// MARK: Constraints
	
	override class func requiresConstraintBasedLayout() -> Bool {
		return true
	}
	
	private var _didSetupConstraints = false
	
	override func updateConstraints() {
		if !_didSetupConstraints {
			let views: [NSObject: AnyObject] = [
				"headlineLabel": headlineLabel,
				"textView": textView
			]
			let metrics = [
				"margin": 26
			]
			
			addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-(margin)-[headlineLabel]-(margin)-[textView]-(margin)-|", options: nil, metrics: metrics, views: views))
			addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(margin)-[headlineLabel]-(margin)-|", options: nil, metrics: metrics, views: views))
			addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(margin)-[textView]-(margin)-|", options: nil, metrics: metrics, views: views))
			
			_didSetupConstraints = true
		}
		
		super.updateConstraints()
	}
	
}