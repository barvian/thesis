//
//  ReflectSectionHeaderView.swift
//  Thesis
//
//  Created by Maxwell Barvian on 2/10/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit

class ReflectSectionHeaderView: UIView {
	
	private(set) lazy var pillView: UIView = {
		let pill = UIView()
		pill.setTranslatesAutoresizingMaskIntoConstraints(false)
		pill.backgroundColor = UIColor(r: 132, g: 224, b: 201)
		
		return pill
	}()
	
	private(set) lazy var dateLabel: UILabel = {
		let label = UILabel()
		label.setTranslatesAutoresizingMaskIntoConstraints(false)
		label.font = UIFont(name: "HelveticaNeue", size: 13)
		label.textColor = UIColor(r: 60, g: 164, b: 147)
		label.numberOfLines = 0
		
		return label
	}()
	
	private(set) lazy var lineView: UIView = {
		let line = UIView()
		line.setTranslatesAutoresizingMaskIntoConstraints(false)
		line.backgroundColor = UIColor(r: 132, g: 224, b: 201)
		
		return line
	}()
	
	// MARK: Initializers
	
	convenience init() {
		self.init(frame: CGRectZero)
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		pillView.addSubview(dateLabel)
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
	
	private var _didSetupConstraints = false
	
	override func updateConstraints() {
		if !_didSetupConstraints {
			let views: [NSObject: AnyObject] = [
				"pillView": pillView,
				"dateLabel": dateLabel,
				"lineView": lineView,
			]
			let metrics = [
				"margin": 26
			]
			
			addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[lineView][pillView]|", options: nil, metrics: nil, views: views))
			addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-(6)-[dateLabel]-(7)-|", options: nil, metrics: nil, views: views))
			addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(12)-[dateLabel]-(12)-|", options: nil, metrics: nil, views: views))
			addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[lineView(2)]", options: nil, metrics: nil, views: views))
			for (_, subview) in views {
				addConstraint(NSLayoutConstraint(item: subview, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: 0))
			}
			
			_didSetupConstraints = true
		}
		
		super.updateConstraints()
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		pillView.layer.cornerRadius = pillView.bounds.height / 2
	}
	
}
