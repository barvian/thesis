//
//  ChunkyButton.swift
//  Thesis
//
//  Created by Maxwell Barvian on 2/17/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit

class ChunkyButton: UIButton {
	
	var round = true
	var backgroundColors = [
		UIControlState.Normal.rawValue: UIColor.whiteColor(),
		UIControlState.Highlighted.rawValue: UIColor(r: 255, g: 255, b: 255, a: 0.9)
	]
	
	var zIndex: Int = 2 {
		didSet {
			drawBackground()
		}
	}
	
	var cornerRadius: CGFloat = 5 {
		didSet {
			layer.cornerRadius = cornerRadius
			drawBackground()
		}
	}
	
	override var highlighted: Bool {
		didSet {
			self.drawBackground()
		}
	}
	
	override var selected: Bool {
		didSet {
			self.drawBackground()
		}
	}
	
	// MARK: Initializers
	
	convenience override init() {
		self.init(frame: CGRectZero)
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		setTitleColor(UIColor.applicationBaseColor(), forState: .Normal)
		layer.shadowColor = UIColor.blackColor().CGColor
		layer.shadowOpacity = 0.1
		
		drawBackground()
	}
	
	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	func drawBackground() {
		backgroundColor = backgroundColors[state.rawValue]
		transform = highlighted && round ? CGAffineTransformMakeScale(0.975, 0.975) : CGAffineTransformMakeScale(1, 1)
		layer.shadowOffset = CGSize(width: 0, height: highlighted ? CGFloat(zIndex) * 0.5 : CGFloat(zIndex) * 1.5)
		layer.shadowRadius = highlighted ? CGFloat(zIndex) * 0.5 : CGFloat(zIndex) * 2
	}
	
	// MARK: Constraints
	
	override class func requiresConstraintBasedLayout() -> Bool {
		return true
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		if round {
			cornerRadius = bounds.height / 2
		}
	}
	
}
