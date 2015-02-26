//
//  DailyReminderView.swift
//  Thesis
//
//  Created by Maxwell Barvian on 2/26/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit
import SSDynamicText

@objc protocol DailyReminderViewDelegate {
	optional func dailyReminderView(dailyReminderView: DailyReminderView, didChangeTime time: NSDate)
}

class DailyReminderView: UIVisualEffectView {
	
	weak var delegate: DailyReminderViewDelegate?
	
	private(set) lazy var vibrancyView: UIVisualEffectView = {
		let vibrancyEffect = UIVibrancyEffect(forBlurEffect: self.effect as! UIBlurEffect)
		let vibrancy = UIVisualEffectView(effect: vibrancyEffect)
		vibrancy.setTranslatesAutoresizingMaskIntoConstraints(false)
		
		return vibrancy
	}()
	
	private(set) lazy var reminderLabel: UILabel = {
		let label = SSDynamicLabel(font: "HelveticaNeue", baseSize: 17.0)
		label.text = "Daily reminder"
		label.setTranslatesAutoresizingMaskIntoConstraints(false)
		label.textColor = UIColor.whiteColor()
		label.lineBreakMode = .ByTruncatingTail
		label.numberOfLines = 0
		label.textAlignment = .Left
		
		return label
	}()
	
	private(set) lazy var toggleSwitch: UISwitch = {
		let picker = UISwitch()
		picker.setTranslatesAutoresizingMaskIntoConstraints(false)
		
		return picker
	}()
	
	private(set) lazy var borderView: UIView = {
		let line = UIView()
		line.setTranslatesAutoresizingMaskIntoConstraints(false)
		line.backgroundColor = UIColor.whiteColor()
		
		return line
	}()
	
	private(set) lazy var timePicker: UIDatePicker = {
		let picker = UIDatePicker()
		picker.setTranslatesAutoresizingMaskIntoConstraints(false)
		picker.datePickerMode = .Time
		picker.setValue(UIColor.whiteColor(), forKeyPath: "textColor")
		
		return picker
	}()
	
	// MARK: Initializers
	
	convenience init() {
		let effect = UIBlurEffect(style: .Dark)
		self.init(effect: effect)
	}
	
	override init(effect: UIVisualEffect) {
		super.init(effect: effect)
		
		contentView.preservesSuperviewLayoutMargins = true
		vibrancyView.preservesSuperviewLayoutMargins = true
		vibrancyView.contentView.preservesSuperviewLayoutMargins = true
		
		vibrancyView.contentView.addSubview(reminderLabel)
		vibrancyView.contentView.addSubview(borderView)
		vibrancyView.contentView.addSubview(timePicker)
		contentView.addSubview(vibrancyView)
		
		contentView.addSubview(toggleSwitch)
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
				"vibrancyView": vibrancyView,
				"reminderLabel": reminderLabel,
				"toggleSwitch": toggleSwitch,
				"borderView": borderView,
				"timePicker": timePicker,
			]
			
			let margin: CGFloat = 12
			let metrics = [
				"margin": margin
			]
			
			addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[vibrancyView]|", options: nil, metrics: metrics, views: views))
			addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[vibrancyView]|", options: nil, metrics: metrics, views: views))
			
			addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[reminderLabel(==toggleSwitch)]", options: nil, metrics: metrics, views: views))
			addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[toggleSwitch]-(margin)-[borderView(0.5)][timePicker(175)]|", options: nil, metrics: metrics, views: views))
			addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[reminderLabel]-[toggleSwitch]-|", options: nil, metrics: metrics, views: views))
			addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[borderView]|", options: nil, metrics: metrics, views: views))
			addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[timePicker]|", options: nil, metrics: metrics, views: views))
			
			_didSetupConstraints = true
		}
		
		super.updateConstraints()
	}
	
	// MARK: Handlers
	
	
	
}