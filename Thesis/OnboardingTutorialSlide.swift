//
//  OnboardingTutorialController.swift
//  Thesis
//
//  Created by Maxwell Barvian on 2/22/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit
import SSDynamicText

class OnboardingTutorialSlide: OnboardingSlide {
	
	private(set) lazy var learnTab: UIImageView = {
		let tab = UIImageView(image: UIImage(named: "LearnTab"))
		tab.setTranslatesAutoresizingMaskIntoConstraints(false)
		
		return tab
	}()
	
	private(set) lazy var learnTabLabel: UILabel = {
		let label = SSDynamicLabel(font: "HelveticaNeue", baseSize: 15.0)
		label.setTranslatesAutoresizingMaskIntoConstraints(false)
		label.textColor = UIColor.applicationBaseColor()
		label.numberOfLines = 0
		
		var paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.lineSpacing = 3.5
		paragraphStyle.alignment = .Left
		let text = NSAttributedString(string: "The Learn tab contains readings from various sources that broadly explain the various aspects of Generalized Anxiety Disorder. Use this tab whenever you'd like a better understanding of the disorder or its many symptoms.", attributes: [NSParagraphStyleAttributeName: paragraphStyle])
		label.attributedText = text
		
		return label
	}()
	
	private(set) lazy var relaxTab: UIImageView = {
		let tab = UIImageView(image: UIImage(named: "RelaxTab"))
		tab.setTranslatesAutoresizingMaskIntoConstraints(false)
		
		return tab
	}()
	
	private(set) lazy var relaxTabLabel: UILabel = {
		let label = SSDynamicLabel(font: "HelveticaNeue", baseSize: 15.0)
		label.setTranslatesAutoresizingMaskIntoConstraints(false)
		label.textColor = UIColor.applicationBlueColor()
		label.numberOfLines = 0
		
		var paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.lineSpacing = 3.5
		paragraphStyle.alignment = .Left
		let text = NSAttributedString(string: "The Relax tab uses the research-backed relaxation methods to treat the more immediate, unpleasant symptoms of anxiety. You're encouraged to relax in this way once or twice every day.", attributes: [NSParagraphStyleAttributeName: paragraphStyle])
		label.attributedText = text
		
		return label
	}()
	
	private(set) lazy var reflectTab: UIImageView = {
		let tab = UIImageView(image: UIImage(named: "ReflectTab"))
		tab.setTranslatesAutoresizingMaskIntoConstraints(false)
		
		return tab
	}()
	
	private(set) lazy var reflectTabLabel: UILabel = {
		let label = SSDynamicLabel(font: "HelveticaNeue", baseSize: 15.0)
		label.setTranslatesAutoresizingMaskIntoConstraints(false)
		label.textColor = UIColor.applicationGreenColor()
		label.numberOfLines = 0
		
		var paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.lineSpacing = 3.5
		paragraphStyle.alignment = .Left
		let text = NSAttributedString(string: "The Reflect tab uses Positive Psychology principles to shift the long-term focus away from anxiety and towards the positive aspects in your life. You're encouraged to use this tab to reflect on at least \(reflectionsPerDay) events each day.", attributes: [NSParagraphStyleAttributeName: paragraphStyle])
		label.attributedText = text
		
		return label
	}()
	
	override init(header: String, subheader: String) {
		super.init(header: header, subheader: subheader)
		
		addSubview(learnTab)
		addSubview(learnTabLabel)
		addSubview(relaxTab)
		addSubview(relaxTabLabel)
		addSubview(reflectTab)
		addSubview(reflectTabLabel)
	}
	
	convenience init() {
		self.init(header: "Using this App", subheader: "You've already made a step in the right direction towards overcoming anxiety. Here's how to get the most from this app:")
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
				"learnTab": learnTab,
				"learnTabLabel": learnTabLabel,
				"relaxTab": relaxTab,
				"relaxTabLabel": relaxTabLabel,
				"reflectTab": reflectTab,
				"reflectTabLabel": reflectTabLabel
			]
			
			let margin: CGFloat = 26
			let metrics = [
				"margin": margin
			]
			
			removeConstraint(subheaderBottomConstraint)
			subheaderBottomConstraint = NSLayoutConstraint(item: subheaderLabel, attribute: .Bottom, relatedBy: .Equal, toItem: learnTabLabel, attribute: .Top, multiplier: 1, constant: -margin)
			addConstraint(subheaderBottomConstraint)
			addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[learnTabLabel]-(margin)-[relaxTabLabel]-(margin)-[reflectTabLabel]|", options: nil, metrics: metrics, views: views))
			
			addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(margin)-[learnTab]-(12)-[learnTabLabel]-(margin)-|", options: nil, metrics: metrics, views: views))
			learnTab.setContentCompressionResistancePriority(1000, forAxis: .Horizontal)
			learnTab.setContentHuggingPriority(1000, forAxis: .Horizontal)
			addConstraint(NSLayoutConstraint(item: learnTab, attribute: .Top, relatedBy: .Equal, toItem: learnTabLabel, attribute: .Top, multiplier: 1, constant: 0))
			addConstraint(NSLayoutConstraint(item: learnTabLabel, attribute: .Bottom, relatedBy: .GreaterThanOrEqual, toItem: learnTab, attribute: .Bottom, multiplier: 1, constant: 0))
			
			addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(margin)-[relaxTab]-(12)-[relaxTabLabel]-(margin)-|", options: nil, metrics: metrics, views: views))
			relaxTab.setContentCompressionResistancePriority(1000, forAxis: .Horizontal)
			relaxTab.setContentHuggingPriority(1000, forAxis: .Horizontal)
			addConstraint(NSLayoutConstraint(item: relaxTab, attribute: .Top, relatedBy: .Equal, toItem: relaxTabLabel, attribute: .Top, multiplier: 1, constant: 0))
			addConstraint(NSLayoutConstraint(item: relaxTabLabel, attribute: .Bottom, relatedBy: .GreaterThanOrEqual, toItem: relaxTab, attribute: .Bottom, multiplier: 1, constant: 0))
			
			addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(margin)-[reflectTab]-(12)-[reflectTabLabel]-(margin)-|", options: nil, metrics: metrics, views: views))
			reflectTab.setContentCompressionResistancePriority(1000, forAxis: .Horizontal)
			reflectTab.setContentHuggingPriority(1000, forAxis: .Horizontal)
			addConstraint(NSLayoutConstraint(item: reflectTab, attribute: .Top, relatedBy: .Equal, toItem: reflectTabLabel, attribute: .Top, multiplier: 1, constant: 0))
			addConstraint(NSLayoutConstraint(item: reflectTabLabel, attribute: .Bottom, relatedBy: .GreaterThanOrEqual, toItem: reflectTab, attribute: .Bottom, multiplier: 1, constant: 0))
			
			_didSetupConstraints = true
		}
	}
	
}
