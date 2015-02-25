//
//  StatementTableViewCell.swift
//  Thesis
//
//  Created by Maxwell Barvian on 2/23/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit
import SSDynamicText

class StatementTableViewCell: UITableViewCell {
	
	private(set) lazy var statementLabel: UILabel = {
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
	
	private(set) lazy var lineView: UIView = {
		let line = UIView()
		line.setTranslatesAutoresizingMaskIntoConstraints(false)
		line.backgroundColor = UIColor(r: 255, g: 255, b: 255, a: 0.4)
		
		return line
	}()
	
	// MARK: Initializers
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		selectionStyle = .None
		
		backgroundColor = UIColor.applicationBaseColor()
		
		contentView.addSubview(statementLabel)
		contentView.addSubview(lineView)
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
			let views = [
				"statementLabel": statementLabel,
				"lineView": lineView
			]
			let metrics = [
				"margin": 26
			]
			
			contentView.bounds = CGRect(x: 0.0, y: 0.0, width: 99999.0, height: 99999.0)
			
			statementLabel.setContentCompressionResistancePriority(1000, forAxis: .Vertical)
			contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[lineView]-(margin)-[statementLabel]-(margin)-|", options: nil, metrics: metrics, views: views))
			contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(margin)-[statementLabel]-(margin)-|", options: nil, metrics: metrics, views: views))
			contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[lineView(2)]", options: nil, metrics: metrics, views: views))
			contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[lineView(8)]", options: nil, metrics: metrics, views: views))
			contentView.addConstraint(NSLayoutConstraint(item: lineView, attribute: .CenterX, relatedBy: .Equal, toItem: contentView, attribute: .CenterX, multiplier: 1, constant: 0))
			
			_didSetupConstraints = true
		}
		
		super.updateConstraints()
	}
	
}