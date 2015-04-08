//
//  AddReflectionView.swift
//  Thesis
//
//  Created by Maxwell Barvian on 2/5/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit
import SSDynamicText

@objc protocol ReflectHeaderViewDelegate {
	optional func reflectHeaderView(reflectHeaderView: ReflectHeaderView, didTapReminderButton reminderButton: UIButton!)
	optional func reflectHeaderView(reflectHeaderView: ReflectHeaderView, didTapAddButton addButton: UIButton!)
}

public let reflectionsPerDay = 3

class ReflectHeaderView: UIView {
	
	weak var delegate: ReflectHeaderViewDelegate?
	
	private(set) lazy var reminderButton: UIButton = {
		let button = UIButton.applicationBellButton()
		button.setTranslatesAutoresizingMaskIntoConstraints(false)
		button.tintColor = UIColor.whiteColor()
		
		button.addTarget(self, action: "didTapReminderButton:", forControlEvents: .TouchUpInside)
		
		return button
	}()
	
	private(set) lazy var headlineLabel: UILabel = {
		let label = UILabel.applicationHeaderLabel()
		label.text = "What went well today?"
		label.setTranslatesAutoresizingMaskIntoConstraints(false)
		label.textColor = UIColor(r: 184, g: 248, b: 232)
		
		return label
	}()
	
	private(set) lazy var subheaderLabel: UILabel = {
		let label = UILabel.applicationSubheaderLabel()
		label.text = "(And yes, tacos for dinner totally counts.)"
		label.setTranslatesAutoresizingMaskIntoConstraints(false)
		label.textColor = UIColor(r: 184, g: 248, b: 232, a: 0.8)
				
		return label
	}()
	
	private(set) lazy var addButton: UIButton = {
		let button = ChunkyButton()
		button.setTranslatesAutoresizingMaskIntoConstraints(false)
		button.setImage(UIImage(named: "Compose")?.imageWithRenderingMode(.AlwaysTemplate), forState: .Normal)
		button.imageEdgeInsets = UIEdgeInsets(top: -3, left: 0, bottom: 0, right: -4)
		
		button.addTarget(self, action: "didTapAddButton:", forControlEvents: .TouchUpInside)
		
		return button
	}()
	
	// MARK: Initializers
	
	convenience init() {
		self.init(frame: CGRectZero)
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		addSubview(reminderButton)
		addSubview(headlineLabel)
		addSubview(subheaderLabel)
		addSubview(addButton)
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
				"reminderButton": reminderButton,
				"headlineLabel": headlineLabel,
				"subheaderLabel": subheaderLabel,
				"addButton": addButton
			]
			let metrics = [
				"margin": 14,
				"hMargin": 26,
				"vMargin": 52
			]
			
			addConstraint(NSLayoutConstraint(item: reminderButton, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: 0))
			addConstraint(NSLayoutConstraint(item: addButton, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: 0))
			addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-(margin)-[reminderButton]-(hMargin)-[headlineLabel]-[subheaderLabel]-(vMargin)-[addButton(70)]|", options: nil, metrics: metrics, views: views))
			addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(hMargin)-[headlineLabel]-(hMargin)-|", options: nil, metrics: metrics, views: views))
			addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(hMargin)-[subheaderLabel]-(hMargin)-|", options: nil, metrics: metrics, views: views))
			addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[addButton(70)]", options: nil, metrics: metrics, views: views))
			
			_didSetupConstraints = true
		}
		
		super.updateConstraints()
	}
	
	// MARK: Handlers
	
	func didTapReminderButton(button: UIButton!) {
		delegate?.reflectHeaderView?(self, didTapReminderButton: button)
	}
	
	func didTapAddButton(button: UIButton!) {
		delegate?.reflectHeaderView?(self, didTapAddButton: button)
	}
	
}