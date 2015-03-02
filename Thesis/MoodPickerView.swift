//
//  MoodPickerview.swift
//  Thesis
//
//  Created by Maxwell Barvian on 2/24/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit
import SSDynamicText

@objc protocol MoodPickerViewDelegate {
	optional func moodPickerView(moodPickerView: MoodPickerView, didPickMood mood: Mood)
}

class MoodPickerView: UIView {
	
	weak var delegate: MoodPickerViewDelegate?
	
	private(set) lazy var headlineLabel: UILabel = {
		let label = UILabel.applicationHeaderLabel()
		label.text = "How are you feeling right now?"
		label.setTranslatesAutoresizingMaskIntoConstraints(false)
		label.textColor = UIColor(r: 191, g: 234, b: 248)
		
		return label
	}()
	
	private(set) lazy var moodButtons: [Mood: UIButton] = {
		var buttons = [Mood: UIButton]()
		
		for mood in Mood.allValues {
			let button = ChunkyButton()
			button.setTranslatesAutoresizingMaskIntoConstraints(false)
			button.setTitle(mood.description, forState: .Normal)
			button.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 26)
			button.tag = mood.rawValue
			
			button.addTarget(self, action: "didTapMoodButton:", forControlEvents: .TouchUpInside)
			
			buttons[mood] = button
		}
		
		return buttons
	}()
	
	// MARK: Initializers
	
	convenience override init() {
		self.init(frame: CGRectZero)
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
				
		addSubview(headlineLabel)
		for (mood, button) in moodButtons {
			addSubview(button)
		}
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
				"headlineLabel": headlineLabel,
				"happyButton": moodButtons[.😊]!,
				"neutralButton": moodButtons[.😐]!,
				"flusteredButton": moodButtons[.😖]!
			]
			
			let vMargin: CGFloat = 34, hMargin: CGFloat = 26, buttonSize: CGFloat = 70
			let metrics = [
				"vMargin": vMargin,
				"hMargin": hMargin,
				"buttonSize": buttonSize
			]
			
			addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[headlineLabel]-(vMargin)-[neutralButton]|", options: nil, metrics: metrics, views: views))
			addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(hMargin)-[headlineLabel]-(hMargin)-|", options: nil, metrics: metrics, views: views))
			addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[neutralButton(buttonSize,==happyButton,==flusteredButton)]", options: nil, metrics: metrics, views: views))
			addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[flusteredButton]-(hMargin)-[neutralButton]-(hMargin)-[happyButton]", options: nil, metrics: metrics, views: views))
			addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[neutralButton(buttonSize,==happyButton,==flusteredButton)]", options: nil, metrics: metrics, views: views))
			addConstraint(NSLayoutConstraint(item: moodButtons[.😐]!, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: 0))
			for (mood, button) in filter(moodButtons, { (key, value) in key != .😐 }) {
				addConstraint(NSLayoutConstraint(item: button, attribute: .CenterY, relatedBy: .Equal, toItem: moodButtons[.😐]!, attribute: .CenterY, multiplier: 1, constant: 0))
			}
			
			_didSetupConstraints = true
		}
		
		super.updateConstraints()
	}
	
	// MARK: Handlers
	
	func didTapMoodButton(button: UIButton!) {
		delegate?.moodPickerView?(self, didPickMood: Mood(rawValue: button.tag)!)
	}
	
}