//
//  OnboardingReminderController.swift
//  Thesis
//
//  Created by Maxwell Barvian on 2/22/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit
import SSDynamicText

class OnboardingReminderController: UIViewController {
	
	private(set) lazy var headlineLabel: UILabel = {
		let label = SSDynamicLabel(font: "HelveticaNeue", baseSize: 23.0)
		label.text = "Daily Relaxation Reminders"
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
		let text = NSAttributedString(string: "You may find it helpful to set aside time to practice deep relaxation every day.  Early mornings are great, but the best time is one that you can stick to most days.", attributes: [NSParagraphStyleAttributeName: paragraphStyle])
		label.attributedText = text
		
		return label
	}()
	
	private(set) lazy var timePicker: UIDatePicker = {
		let picker = UIDatePicker()
		picker.setTranslatesAutoresizingMaskIntoConstraints(false)
		picker.datePickerMode = .Time
		
		return picker
	}()
	
	private(set) lazy var setReminderButton: UIButton = {
		let button = UIButton.buttonWithType(.System) as! UIButton
		button.setTranslatesAutoresizingMaskIntoConstraints(false)
		button.setTitle("Set Reminder", forState: .Normal)
		
		button.addTarget(self, action: "didTapSetReminder:", forControlEvents: .TouchUpInside)
		
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
		
		title = "Welcome"
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.addSubview(spacerViews[0])
		view.addSubview(headlineLabel)
		view.addSubview(subheaderLabel)
		view.addSubview(setReminderButton)
		view.addSubview(timePicker)
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
				"setReminderButton": setReminderButton,
				"timePicker": timePicker,
				"spacer2": spacerViews[1]
			]
			let metrics = [
				"hMargin": 26
			]
			
			view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[spacer1(>=0)][headlineLabel]-[subheaderLabel]-(hMargin)-[timePicker]-[setReminderButton][spacer2(==spacer1)]|", options: nil, metrics: metrics, views: views))
			view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[spacer1(0,==spacer2)]", options: nil, metrics: metrics, views: views))
			view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(hMargin)-[headlineLabel]-(hMargin)-|", options: nil, metrics: metrics, views: views))
			view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(hMargin)-[subheaderLabel]-(hMargin)-|", options: nil, metrics: metrics, views: views))
			view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[timePicker]|", options: nil, metrics: metrics, views: views))
			for (_, subview) in views {
				view.addConstraint(NSLayoutConstraint(item: subview, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0))
			}
			
			_didSetupConstraints = true
		}
		
		super.updateViewConstraints()
	}
	
	// MARK: Handlers
	
	func didTapSetReminder(button: UIButton!) {
		UIApplication.appDelegate.registerForNotifications() {
			[unowned self] (settings: UIUserNotificationSettings) in
			UIApplication.sharedApplication().cancelAllLocalNotifications()
			
			let notif = UILocalNotification()
			notif.fireDate = self.timePicker.date.beginningOfMinute()
			println(self.timePicker.date.beginningOfMinute())
			notif.timeZone = NSTimeZone.defaultTimeZone()
			
			notif.alertBody = "Have some time to relax?"
			notif.alertAction = "Relax"
			notif.soundName = UILocalNotificationDefaultSoundName
			notif.repeatInterval = .DayCalendarUnit
			
			UIApplication.sharedApplication().scheduleLocalNotification(notif)
		}
	}
	
}
