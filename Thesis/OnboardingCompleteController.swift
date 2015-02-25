//
//  OnboardingCompleteController.swift
//  Thesis
//
//  Created by WSOL Intern on 1/12/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit
import SSDynamicText

class OnboardingCompleteController: UIViewController {
	
	private(set) lazy var headlineLabel: UILabel = {
		let label = SSDynamicLabel(font: "HelveticaNeue", baseSize: 23.0)
		label.text = "Perfect!"
		label.setTranslatesAutoresizingMaskIntoConstraints(false)
		label.textColor = UIColor.blackColor()
		label.lineBreakMode = .ByTruncatingTail
		label.numberOfLines = 0
		label.textAlignment = .Center
		
		return label
	}()
	
	private(set) lazy var subheaderLabel: UILabel = {
		let label = SSDynamicLabel(font: "HelveticaNeue", baseSize: 17.0)
		label.setTranslatesAutoresizingMaskIntoConstraints(false)
		label.textColor = UIColor.applicationBaseColor()
		label.lineBreakMode = .ByTruncatingTail
		label.numberOfLines = 0
		
		var paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.lineSpacing = 5
		paragraphStyle.alignment = .Center
		let text = NSAttributedString(string: "You're now well on your way to begin incorporating daily relaxation and positive reflection into your everyday life. Remember: recovering from anxiety is a process, but the benefits of these techniques can be enjoyed at every step along the way.", attributes: [NSParagraphStyleAttributeName: paragraphStyle])
		label.attributedText = text
		
		return label
	}()
	
	private(set) lazy var doneButton: UIButton = {
		let button = UIButton.buttonWithType(.System) as! UIButton
		button.setTranslatesAutoresizingMaskIntoConstraints(false)
		button.setTitle("Get Started", forState: .Normal)
		button.addTarget(self, action: "didTapDoneButton:", forControlEvents: .TouchUpInside)
		
		return button
	}()
	
	private(set) lazy var spacerViews: [UIView] = {
		let spacers = [UIView(), UIView()]
		for spacer in spacers {
			spacer.setTranslatesAutoresizingMaskIntoConstraints(false)
			spacer.hidden = true
		}
		
		return spacers
	}()
	
	convenience override init() {
		self.init(nibName: nil, bundle: nil)
		
		title = "Complete"
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.addSubview(spacerViews[0])
		view.addSubview(headlineLabel)
		view.addSubview(subheaderLabel)
		view.addSubview(doneButton)
		view.addSubview(spacerViews[1])
		
		view.setNeedsUpdateConstraints() // bootstrap AutoLayout
	}
	
	// MARK: Constraints
	
	private var _didSetupConstraints = false
	
	override func updateViewConstraints() {
		if !_didSetupConstraints {
			let views = [
				"spacer1": spacerViews[0],
				"headlineLabel": headlineLabel,
				"subheaderLabel": subheaderLabel,
				"doneButton": doneButton,
				"spacer2": spacerViews[1]
			]
			let metrics = [
				"hMargin": 26
			]
			
			view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[spacer1(>=0)]-[headlineLabel]-[subheaderLabel]-(hMargin)-[doneButton]-[spacer2(==spacer1)]|", options: nil, metrics: metrics, views: views))
			view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[spacer1(200,==spacer2)]", options: nil, metrics: metrics, views: views))
			view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(hMargin)-[headlineLabel]-(hMargin)-|", options: nil, metrics: metrics, views: views))
			view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(hMargin)-[subheaderLabel]-(hMargin)-|", options: nil, metrics: metrics, views: views))
			for (_, subview) in views {
				view.addConstraint(NSLayoutConstraint(item: subview, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0))
			}
			
			_didSetupConstraints = true
		}
		
		super.updateViewConstraints()
	}
	
	// MARK: Handlers
	
	func didTapDoneButton(button: UIButton!) {
		UIApplication.rootViewController.dismissViewControllerAnimated(true, completion: nil)
	}
	
}
