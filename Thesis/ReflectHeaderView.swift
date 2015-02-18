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
	optional func reflectHeaderView(reflectHeaderView: ReflectHeaderView, didTapAddButton addButton: UIButton!)
}

public let reflectionsPerDay = 3

class ReflectHeaderView: UIView {
	
	weak var delegate: ReflectHeaderViewDelegate?
	
	private(set) lazy var headlineLabel: UILabel = {
		let label = SSDynamicLabel(font: "HelveticaNeue", baseSize: 23.0)
		label.text = "What went well today?"
		label.setTranslatesAutoresizingMaskIntoConstraints(false)
		label.textColor = UIColor(r: 184, g: 248, b: 232)
		label.lineBreakMode = .ByTruncatingTail
		label.numberOfLines = 0
		label.textAlignment = .Center
		
		label.layer.shadowOffset = CGSize(width: 0, height: 2)
		label.layer.shadowRadius = 3
		label.layer.shadowColor = UIColor.blackColor().CGColor
		label.layer.shadowOpacity = 0.075
		label.layer.shouldRasterize = true
		label.layer.rasterizationScale = UIScreen.mainScreen().scale
		
		return label
	}()
	
	private(set) lazy var subheaderLabel: UILabel = {
		let label = SSDynamicLabel(font: "HelveticaNeue", baseSize: 17.0)
		label.text = "(And yes, tacos for dinner totally counts.)"
		label.setTranslatesAutoresizingMaskIntoConstraints(false)
		label.textColor = UIColor(r: 184, g: 248, b: 232, a: 0.8)
		label.lineBreakMode = .ByTruncatingTail
		label.numberOfLines = 0
		label.textAlignment = .Center
		
		label.layer.shadowOffset = CGSize(width: 0, height: 2)
		label.layer.shadowRadius = 3
		label.layer.shadowColor = UIColor.blackColor().CGColor
		label.layer.shadowOpacity = 0.075
		label.layer.shouldRasterize = true
		label.layer.rasterizationScale = UIScreen.mainScreen().scale
		
		return label
	}()
	
	private(set) lazy var addButton: UIButton = {
		let button = UIButton.buttonWithType(.System) as! UIButton
		button.setTranslatesAutoresizingMaskIntoConstraints(false)
		button.setImage(UIImage(named: "Compose")?.imageWithRenderingMode(.AlwaysTemplate), forState: .Normal)
		button.imageEdgeInsets = UIEdgeInsets(top: -3, left: 0, bottom: 0, right: -4)
		button.backgroundColor = UIColor.whiteColor()
		button.layer.cornerRadius = 35
		button.layer.shadowOffset = CGSize(width: 0, height: 3)
		button.layer.shadowRadius = 4
		button.layer.shadowColor = UIColor.blackColor().CGColor
		button.layer.shadowOpacity = 0.1
		
		button.addTarget(self, action: "didTapAddButton:", forControlEvents: .TouchUpInside)
		
		return button
	}()
	
	private(set) lazy var lineView: UIView = {
		let line = UIView()
		line.setTranslatesAutoresizingMaskIntoConstraints(false)
		line.backgroundColor = UIColor(r: 132, g: 224, b: 201)
		
		return line
	}()
	
	private(set) lazy var pillView: LBorderView = {
		let pill = LBorderView()
		pill.setTranslatesAutoresizingMaskIntoConstraints(false)
		pill.borderType = BorderTypeDashed
		pill.dashPattern = 5
		pill.spacePattern = 3
		pill.borderWidth = 1.5
		pill.borderColor = UIColor(r: 132, g: 224, b: 201)
		
		return pill
	}()
	
	private(set) lazy var reminderLabel: UILabel = {
		let label = SSDynamicLabel(font: "HelveticaNeue", baseSize: 15.0)
		label.setTranslatesAutoresizingMaskIntoConstraints(false)
		label.textColor = UIColor(r: 165, g: 242, b: 223)
		label.lineBreakMode = .ByTruncatingTail
		label.numberOfLines = 0
		label.textAlignment = .Center
		
		label.layer.shadowOffset = CGSize(width: 0, height: 1)
		label.layer.shadowRadius = 3
		label.layer.shadowColor = UIColor.blackColor().CGColor
		label.layer.shadowOpacity = 0.1
		label.layer.shouldRasterize = true
		label.layer.rasterizationScale = UIScreen.mainScreen().scale
		
		return label
	}()
	
	// MARK: Initializers
	
	convenience override init() {
		self.init(frame: CGRectZero)
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		addSubview(headlineLabel)
		addSubview(subheaderLabel)
		pillView.addSubview(reminderLabel)
		addSubview(lineView)
		addSubview(pillView)
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
				"headlineLabel": headlineLabel,
				"subheaderLabel": subheaderLabel,
				"addButton": addButton,
				"lineView": lineView,
				"pillView": pillView,
				"reminderLabel": reminderLabel
			]
			let metrics = [
				"hMargin": 26,
				"vMargin": 52
			]
			
			addConstraint(NSLayoutConstraint(item: addButton, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: 0))
			addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-(vMargin)-[headlineLabel]-[subheaderLabel]-(vMargin)-[addButton(70)][lineView(vMargin)][pillView]|", options: nil, metrics: metrics, views: views))
			addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(hMargin)-[headlineLabel]-(hMargin)-|", options: nil, metrics: metrics, views: views))
			addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(hMargin)-[subheaderLabel]-(hMargin)-|", options: nil, metrics: metrics, views: views))
			addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[addButton(70)]", options: nil, metrics: metrics, views: views))
			addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-(9)-[reminderLabel]-(10)-|", options: nil, metrics: nil, views: views))
			addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(17)-[reminderLabel]-(17)-|", options: nil, metrics: nil, views: views))
			addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[lineView(2)]", options: nil, metrics: nil, views: views))
			for (_, subview) in views {
				addConstraint(NSLayoutConstraint(item: subview, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: 0))
			}
			
			didSetupConstraints = true
		}
		
		super.updateConstraints()
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		pillView.cornerRadius = pillView.bounds.height / 2
	}
	
	// MARK: Handlers
	
	func didTapAddButton(button: UIButton!) {
		delegate?.reflectHeaderView?(self, didTapAddButton: button)
	}
	
}

extension ReflectHeaderView {
	
	func configureForTodaySection(section: [Reflection]?) {
		let count = (section == nil ? 0 : section!.count), remaining = reflectionsPerDay - count
		switch remaining {
		case reflectionsPerDay:
			reminderLabel.text = "What \(remaining) things were you grateful for today?"
		case 1:
			reminderLabel.text = "What else are you grateful for today?"
		default:
			reminderLabel.text = "What other \(remaining) things went well today?"
		}
		
		pillView.hidden = remaining == 0
		lineView.hidden = remaining == 0
	}
	
}