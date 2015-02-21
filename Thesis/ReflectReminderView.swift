//
//  ReflectSectionHeaderView.swift
//  Thesis
//
//  Created by Maxwell Barvian on 2/10/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit
import SSDynamicText

class ReflectReminderView: UIView {
	
	private(set) lazy var lineView: UIView = {
		let line = UIView()
		line.setTranslatesAutoresizingMaskIntoConstraints(false)
		line.backgroundColor = UIColor(r: 132, g: 224, b: 201)
		
		return line
		}()
	
	private(set) lazy var pillView: LBorderView = {
		let pill = LBorderView()
		pill.setTranslatesAutoresizingMaskIntoConstraints(false)
		pill.backgroundColor = UIColor.applicationGreenColor()
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
		
		pillView.addSubview(reminderLabel)
		addSubview(lineView)
		addSubview(pillView)
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
				"pillView": pillView,
				"reminderLabel": reminderLabel,
				"lineView": lineView,
			]
			let metrics = [
				"margin": 26
			]
			
			addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[lineView][pillView]|", options: nil, metrics: nil, views: views))
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
	
}
