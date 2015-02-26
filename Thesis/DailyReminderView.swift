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
	optional func dailyReminderView(dailyReminderView: DailyReminderView, didToggleReminder reminder: Bool)
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
	
	private(set) lazy var reminderToggle: UISwitch = {
		let toggle = UISwitch()
		toggle.setTranslatesAutoresizingMaskIntoConstraints(false)
		toggle.addTarget(self, action: "didChangeReminderToggle:", forControlEvents: .ValueChanged)
		
		return toggle
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
		picker.addTarget(self, action: "didChangeTimePicker:", forControlEvents: .ValueChanged)
		
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
		
		contentView.addSubview(reminderToggle)
		
		toggleReminder(false)
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
				"reminderToggle": reminderToggle,
				"borderView": borderView,
				"timePicker": timePicker,
			]
			
			let margin: CGFloat = 12
			let metrics = [
				"margin": margin
			]
			
			addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[vibrancyView]|", options: nil, metrics: metrics, views: views))
			addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[vibrancyView]|", options: nil, metrics: metrics, views: views))
			
			addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[reminderLabel(==reminderToggle)]", options: nil, metrics: metrics, views: views))
			addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[reminderToggle]-(margin)-[borderView(0.5)][timePicker(175)]|", options: nil, metrics: metrics, views: views))
			addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[reminderLabel]-[reminderToggle]-|", options: nil, metrics: metrics, views: views))
			addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[borderView]|", options: nil, metrics: metrics, views: views))
			addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[timePicker]|", options: nil, metrics: metrics, views: views))
			
			_didSetupConstraints = true
		}
		
		super.updateConstraints()
	}
	
	// MARK: API
	
	private var _reminderEnabled = false
	
	func toggleReminder(_ state: Bool? = nil) {
		_reminderEnabled = state != nil ? state! : !_reminderEnabled
		reminderToggle.on = _reminderEnabled
		
		timePicker.userInteractionEnabled = _reminderEnabled
		timePicker.enabled = _reminderEnabled
		timePicker.alpha = _reminderEnabled ? 1 : 0.5
	}
	
	// MARK: Handlers
	
	func didChangeReminderToggle(toggle: UISwitch!) {
		toggleReminder(toggle.on)
		
		delegate?.dailyReminderView?(self, didToggleReminder: toggle.on)
	}
	
	func didChangeTimePicker(picker: UIDatePicker!) {
		delegate?.dailyReminderView?(self, didChangeTime: picker.date)
	}
	
}