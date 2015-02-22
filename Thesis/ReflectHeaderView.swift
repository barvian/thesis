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
		let button = ChunkyButton()
		button.setTranslatesAutoresizingMaskIntoConstraints(false)
		button.setImage(UIImage(named: "Compose")?.imageWithRenderingMode(.AlwaysTemplate), forState: .Normal)
		button.imageEdgeInsets = UIEdgeInsets(top: -3, left: 0, bottom: 0, right: -4)
		
		button.addTarget(self, action: "didTapAddButton:", forControlEvents: .TouchUpInside)
		
		return button
	}()
	
	// MARK: Initializers
	
	convenience override init() {
		self.init(frame: CGRectZero)
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
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
	
	private var didSetupConstraints = false
	
	override func updateConstraints() {
		if !didSetupConstraints {
			let views = [
				"headlineLabel": headlineLabel,
				"subheaderLabel": subheaderLabel,
				"addButton": addButton
			]
			let metrics = [
				"hMargin": 26,
				"vMargin": 52
			]
			
			addConstraint(NSLayoutConstraint(item: addButton, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: 0))
			addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-(vMargin)-[headlineLabel]-[subheaderLabel]-(vMargin)-[addButton(70)]|", options: nil, metrics: metrics, views: views))
			addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(hMargin)-[headlineLabel]-(hMargin)-|", options: nil, metrics: metrics, views: views))
			addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(hMargin)-[subheaderLabel]-(hMargin)-|", options: nil, metrics: metrics, views: views))
			addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[addButton(70)]", options: nil, metrics: metrics, views: views))
			
			didSetupConstraints = true
		}
		
		super.updateConstraints()
	}
	
	// MARK: Handlers
	
	func didTapAddButton(button: UIButton!) {
		delegate?.reflectHeaderView?(self, didTapAddButton: button)
	}
	
}