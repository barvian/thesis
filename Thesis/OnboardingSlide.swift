//
//  OnboardingSlide.swift
//  Thesis
//
//  Created by Maxwell Barvian on 3/1/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit
import SSDynamicText

class OnboardingSlide: UIView {
	
	let header: String, subheader: String
	
	private(set) lazy var headerLabel: UILabel = {
		let label = UILabel.applicationHeaderLabel(shadow: false)
		label.text = self.header
		label.setTranslatesAutoresizingMaskIntoConstraints(false)
		label.textColor = UIColor.blackColor()
		
		return label
	}()
	
	private(set) lazy var subheaderLabel: UILabel = {
		let label = UILabel.applicationSubheaderLabel(shadow: false)
		label.setTranslatesAutoresizingMaskIntoConstraints(false)
		label.textColor = UIColor.applicationBaseColor()
		
		var paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.lineSpacing = 3.5
		paragraphStyle.alignment = .Center
		let text = NSAttributedString(string: self.subheader, attributes: [NSParagraphStyleAttributeName: paragraphStyle])
		label.attributedText = text
		
		return label
	}()
	
	init(header: String, subheader: String) {
		self.header = header
		self.subheader = subheader
		
		super.init(frame: CGRectZero)
		
		addSubview(headerLabel)
		addSubview(subheaderLabel)
	}

	required init(coder aDecoder: NSCoder) {
	    fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: Constraints
	
	override class func requiresConstraintBasedLayout() -> Bool {
		return true
	}
	
	private var _didSetupConstraints = false
	
	var subheaderBottomConstraint: NSLayoutConstraint!
	
	override func updateConstraints() {
		if !_didSetupConstraints {
			let views: [NSObject: AnyObject] = [
				"headerLabel": headerLabel,
				"subheaderLabel": subheaderLabel
			]
			
			let margin: CGFloat = 26
			let metrics = [
				"margin": 26
			]
			
			addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[headerLabel]-[subheaderLabel]", options: nil, metrics: metrics, views: views))
			addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(margin)-[headerLabel]-(margin)-|", options: nil, metrics: metrics, views: views))
			addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(margin)-[subheaderLabel]-(margin)-|", options: nil, metrics: metrics, views: views))
			if subheaderBottomConstraint == nil {
				subheaderBottomConstraint = NSLayoutConstraint(item: subheaderLabel, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1, constant: 0)
			}
			addConstraint(subheaderBottomConstraint)
			
			_didSetupConstraints = true
		}
		
		super.updateConstraints()
	}
	
}