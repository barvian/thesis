//
//  StatementsFooterView.swift
//  Thesis
//
//  Created by Maxwell Barvian on 2/23/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit

@objc protocol StatementsFooterViewDelegate {
	optional func statementsFooterView(statementsFooterView: StatementsFooterView, didTapProgressButton progressButton: UIButton!)
}

class StatementsFooterView: UIView {
	
	weak var delegate: StatementsFooterViewDelegate?
	
	private(set) lazy var progressButton: UIButton = {
		let button = UIButton.buttonWithType(.System) as! UIButton
		button.setTranslatesAutoresizingMaskIntoConstraints(false)
		button.setTitle("Done", forState: .Normal)
		
		button.addTarget(self, action: "didTapProgressButton:", forControlEvents: .TouchUpInside)
		
		return button
	}()
	
	// MARK: Initializers
	
	convenience override init() {
		self.init(frame: CGRectZero)
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		addSubview(progressButton)
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
				"progressButton": progressButton
			]
			let metrics = [
				"hMargin": 26,
				"vMargin": 34
			]
			
			addConstraint(NSLayoutConstraint(item: progressButton, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: 0))
			addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-(vMargin)-[progressButton]-(vMargin)-|", options: nil, metrics: metrics, views: views))
			
			_didSetupConstraints = true
		}
		
		super.updateConstraints()
	}
	
	// MARK: Handlers
	
	func didTapProgressButton(button: UIButton!) {
		delegate?.statementsFooterView?(self, didTapProgressButton: button)
	}
	
}
