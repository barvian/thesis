//
//  OnboardingGADController.swift
//  Thesis
//
//  Created by Maxwell Barvian on 2/22/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit
import SSDynamicText

class OnboardingGADController: UIViewController {
	
	private(set) lazy var headlineLabel: UILabel = {
		let label = SSDynamicLabel(font: "HelveticaNeue", baseSize: 23.0)
		label.text = "Anxiety Disorder"
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
		let text = NSAttributedString(string: "All of us worry about things like health, money, or family problems. But people with generalized anxiety disorder (GAD) are extremely worried about these and many other things, even when there is little or no reason to worry about them. They are very anxious about just getting through the day. They think things will always go badly. At times, worrying keeps people with GAD from doing everyday tasks.", attributes: [NSParagraphStyleAttributeName: paragraphStyle])
		label.attributedText = text
		
		return label
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
		
		title = "Welcome"
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.addSubview(spacerViews[0])
		view.addSubview(headlineLabel)
		view.addSubview(subheaderLabel)
		view.addSubview(spacerViews[1])
		
		view.setNeedsUpdateConstraints() // bootstrap AutoLayout
	}
	
	// MARK: Constraints
	
	private var _didSetupConstraints = false
	
	override func updateViewConstraints() {
		if !_didSetupConstraints {
			let views: [NSObject: AnyObject] = [
				"spacer1": spacerViews[0],
				"headlineLabel": headlineLabel,
				"subheaderLabel": subheaderLabel,
				"spacer2": spacerViews[1]
			]
			let metrics = [
				"hMargin": 26
			]
			
			view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[spacer1(>=0)][headlineLabel]-[subheaderLabel][spacer2(==spacer1)]|", options: nil, metrics: metrics, views: views))
			view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[spacer1(0,==spacer2)]", options: nil, metrics: metrics, views: views))
			view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(hMargin)-[headlineLabel]-(hMargin)-|", options: nil, metrics: metrics, views: views))
			view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(hMargin)-[subheaderLabel]-(hMargin)-|", options: nil, metrics: metrics, views: views))
			for (_, subview) in views {
				view.addConstraint(NSLayoutConstraint(item: subview, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0))
			}
			
			_didSetupConstraints = true
		}
		
		super.updateViewConstraints()
	}
	
}
