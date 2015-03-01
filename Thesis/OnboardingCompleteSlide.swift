//
//  OnboardingCompleteSlide.swift
//  Thesis
//
//  Created by Maxwell Barvian on 3/1/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit

@objc protocol OnboardingCompleteSlideDelegate {
	optional func onboardingCompleteSlide(onboardingCompleteslide: OnboardingCompleteSlide, didTapDoneButton doneButton: UIButton!)
}

class OnboardingCompleteSlide: OnboardingSlide {
	
	weak var delegate: OnboardingCompleteSlideDelegate?
	
	private(set) lazy var doneButton: UIButton = {
		let button = UIButton.buttonWithType(.System) as! UIButton
		button.setTranslatesAutoresizingMaskIntoConstraints(false)
		button.setTitle("Get Started!", forState: .Normal)
		
		button.addTarget(self, action: "didTapDoneButton:", forControlEvents: .TouchUpInside)
		
		return button
	}()
	
	override init(header: String, subheader: String) {
		super.init(header: header, subheader: subheader)
		
		addSubview(doneButton)
	}
	
	convenience init() {
		self.init(header: "Perfect!", subheader: "You're now well on your way to begin incorporating daily relaxation and positive reflection into your everyday life. Remember: recovering from anxiety is a process, but the benefits of these techniques can be enjoyed at every step along the way.")
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: Constraints
	
	private var _didSetupConstraints = false
	
	override func updateConstraints() {
		super.updateConstraints()
		
		if !_didSetupConstraints {
			let views: [NSObject: AnyObject] = [
				"doneButton": doneButton
			]
			
			let margin: CGFloat = 26
			let metrics = [
				"margin": margin
			]
			
			removeConstraint(subheaderBottomConstraint)
			subheaderBottomConstraint = NSLayoutConstraint(item: subheaderLabel, attribute: .Bottom, relatedBy: .Equal, toItem: doneButton, attribute: .Top, multiplier: 1, constant: -margin)
			addConstraint(subheaderBottomConstraint)
			addConstraint(NSLayoutConstraint(item: doneButton, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: 0))
			addConstraint(NSLayoutConstraint(item: doneButton, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1, constant: 0))
			
			_didSetupConstraints = true
		}
	}
	
	// MARK: Handlers
	
	func didTapDoneButton(button: UIButton!) {
		delegate?.onboardingCompleteSlide?(self, didTapDoneButton: button)
	}
	
}
