//
//  ReflectTableViewCell.swift
//  Thesis
//
//  Created by Maxwell Barvian on 2/8/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit
import SSDynamicText

class ReflectTableViewCell: UITableViewCell {
	
	private(set) lazy var eventLabel: UILabel = {
		let label = SSDynamicLabel(font: "HelveticaNeue-Light", baseSize: 18.0)
		label.setTranslatesAutoresizingMaskIntoConstraints(false)
		label.textColor = UIColor.whiteColor()
		label.lineBreakMode = .ByTruncatingTail
		label.numberOfLines = 0
		label.textAlignment = .Center
		
		label.layer.shadowOffset = CGSize(width: 0, height: 2)
		label.layer.shadowRadius = 3
		label.layer.shadowColor = UIColor.blackColor().CGColor
		label.layer.shadowOpacity = 0.1
		label.layer.shouldRasterize = true
		label.layer.rasterizationScale = UIScreen.mainScreen().scale
		
		return label
	}()
	
	private(set) lazy var reasonLabel: UILabel = {
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
	
	private(set) lazy var lineView: UIView = {
		let line = UIView()
		line.setTranslatesAutoresizingMaskIntoConstraints(false)
		line.backgroundColor = UIColor(r: 132, g: 224, b: 201)
		
		return line
	}()
	
	// MARK: Initializers
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		selectionStyle = .None
		
		backgroundColor = UIColor.applicationGreenColor()
		
		contentView.addSubview(lineView)
		contentView.addSubview(reasonLabel)
		contentView.addSubview(eventLabel)
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
				"eventLabel": eventLabel,
				"reasonLabel": reasonLabel,
				"lineView": lineView
			]
			let metrics = [
				"margin": 26
			]
			
			contentView.bounds = CGRect(x: 0.0, y: 0.0, width: 99999.0, height: 99999.0)
			
			eventLabel.setContentCompressionResistancePriority(1000, forAxis: .Vertical)
			reasonLabel.setContentCompressionResistancePriority(1000, forAxis: .Vertical)
			contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[lineView(16)]-[eventLabel]-(4)-[reasonLabel]-|", options: nil, metrics: metrics, views: views))
			contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(margin)-[eventLabel]-(margin)-|", options: nil, metrics: metrics, views: views))
			contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(margin)-[reasonLabel]-(margin)-|", options: nil, metrics: metrics, views: views))
			contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[lineView(2)]", options: nil, metrics: metrics, views: views))
			contentView.addConstraint(NSLayoutConstraint(item: reasonLabel, attribute: .Top, relatedBy: .GreaterThanOrEqual, toItem: eventLabel, attribute: .Bottom, multiplier: 1, constant: 0))
			contentView.addConstraint(NSLayoutConstraint(item: lineView, attribute: .CenterX, relatedBy: .Equal, toItem: contentView, attribute: .CenterX, multiplier: 1, constant: 0))
			
			didSetupConstraints = true
		}
		
		super.updateConstraints()
	}
	
}

extension ReflectTableViewCell {
	
	func configureForReflection(reflection: Reflection) {
		eventLabel.text = reflection.event
		reasonLabel.text = reflection.reason
	}
	
}