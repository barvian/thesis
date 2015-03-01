//
//  StatementsHeaderView.swift
//  Thesis
//
//  Created by Maxwell Barvian on 2/23/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit
import SSDynamicText

class StatementsHeaderView: UIView {
	
	private(set) lazy var titleLabel: UILabel = {
		let label = SSDynamicLabel(font: "HelveticaNeue", baseSize: 23.0)
		label.text = "Coping Statements"
		label.setTranslatesAutoresizingMaskIntoConstraints(false)
		label.textColor = UIColor(r: 255, g: 255, b: 255, a: 0.85)
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
	
	private(set) lazy var instructionsLabel: UILabel = {
		let label = SSDynamicLabel(font: "HelveticaNeue", baseSize: 17.0)
		label.text = "Allow time to pass while you remind yourself of the following statements. Breathe deeply and repeat one internally; feel free to try another if one gets tiresome."
		label.setTranslatesAutoresizingMaskIntoConstraints(false)
		label.textColor = UIColor(r: 255, g: 255, b: 255, a: 0.55)
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
	
	// MARK: Initializers
	
	convenience override init() {
		self.init(frame: CGRectZero)
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		addSubview(titleLabel)
		addSubview(instructionsLabel)
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
				"titleLabel": titleLabel,
				"instructionsLabel": instructionsLabel
			]
			let metrics = [
				"hMargin": 26,
				"vMargin": 34
			]
			
			addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-(vMargin)-[titleLabel]-[instructionsLabel]-(vMargin)-|", options: nil, metrics: metrics, views: views))
			addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(hMargin)-[titleLabel]-(hMargin)-|", options: nil, metrics: metrics, views: views))
			addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(hMargin)-[instructionsLabel]-(hMargin)-|", options: nil, metrics: metrics, views: views))
			
			_didSetupConstraints = true
		}
		
		super.updateConstraints()
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		titleLabel.preferredMaxLayoutWidth = titleLabel.frame.width
		instructionsLabel.preferredMaxLayoutWidth = instructionsLabel.frame.width
	}
	
}
