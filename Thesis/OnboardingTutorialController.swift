//
//  OnboardingTutorialController.swift
//  Thesis
//
//  Created by Maxwell Barvian on 2/22/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit
import SSDynamicText

class OnboardingTutorialController: UIViewController {
	
	private(set) lazy var headlineLabel: UILabel = {
		let label = SSDynamicLabel(font: "HelveticaNeue", baseSize: 23.0)
		label.text = "How to Use This App"
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
		let text = NSAttributedString(string: "Downloading this application was a great step in the right direction.  This app will help you deal with immediate symptoms like anxious episodes while creating a long-term focus on the positive aspects of your life.  These techniques are backed by the latest psychology research; if you're interested you can find more readings in the Learn section.", attributes: [NSParagraphStyleAttributeName: paragraphStyle])
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
			let views = [
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
