//
//  RelaxViewController.swift
//  Thesis
//
//  Created by WSOL Intern on 1/12/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit
import SSDynamicText

class RelaxViewController: UIViewController, FullScreenViewController, RelaxationNavigationControllerDelegate, DailyReminderViewDelegate, MoodPickerViewDelegate, DurationPickerViewDelegate {
	
	let tintColor = UIColor.applicationBlueColor()
	let backgroundColor = UIColor.applicationBlueColor()
	let tabColor = UIColor(r: 57, g: 109, b: 128)
	let selectedTabColor = UIColor.whiteColor()
	
	let navigationBarHidden = false
	let navigationBarTranslucent = true
	
	let transitionManager = FadeTransitionManager()
	
	private(set) lazy var reminderView: DailyReminderView = {
		let picker = DailyReminderView()
		picker.setTranslatesAutoresizingMaskIntoConstraints(false)
		picker.reminderLabel.text = "Daily relaxation reminder"
		picker.delegate = self
		
		return picker
	}()
	
	private(set) lazy var contentView: UIView = {
		let content = UIView()
		content.setTranslatesAutoresizingMaskIntoConstraints(false)
		
		return content
	}()
	
	private(set) lazy var reminderButton: UIButton = {
		let button = UIButton.applicationBellButton()
		button.setTranslatesAutoresizingMaskIntoConstraints(false)
		button.tintColor = UIColor.whiteColor()
		
		button.addTarget(self, action: "didTapReminderButton:", forControlEvents: .TouchUpInside)
		
		return button
	}()
	
	private(set) lazy var moodPicker: MoodPickerView = {
		let picker = MoodPickerView()
		picker.setTranslatesAutoresizingMaskIntoConstraints(false)
		picker.delegate = self
		
		return picker
	}()
	
	private(set) lazy var durationPicker: DurationPickerView = {
		let picker = DurationPickerView()
		picker.setTranslatesAutoresizingMaskIntoConstraints(false)
		picker.delegate = self
		
		return picker
	}()
	
	private(set) lazy var spacerViews: [UIView] = {
		let spacers = [UIView(), UIView()]
		for spacer in spacers {
			spacer.setTranslatesAutoresizingMaskIntoConstraints(false)
			spacer.hidden = true
		}
		
		return spacers
	}()
	
	override func preferredStatusBarStyle() -> UIStatusBarStyle {
		return .LightContent
	}
	
	convenience init() {
		self.init(nibName: nil, bundle: nil)
		
		title = "Relax"
		tabBarItem.image = UIImage(named: "Relax")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		contentView.addSubview(reminderButton)
		contentView.addSubview(spacerViews[0])
		contentView.addSubview(moodPicker)
		contentView.addSubview(durationPicker)
		contentView.addSubview(spacerViews[1])
		toggleDurationPicker(false)
		view.addSubview(contentView)
		
		setupFullScreenControllerView(self)
		
		view.addSubview(reminderView)
		toggleReminderView(false)
		
	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		
		if let relaxationReminder = UIApplication.sharedApplication().relaxationReminder {
			reminderView.timePicker.date = relaxationReminder.fireDate!
			reminderView.toggleReminder(true)
		} else {
			reminderView.timePicker.date = NSDate.applicationDefaultRelaxationReminderTime()
			reminderView.toggleReminder(false)
		}
		
		updateFullScreenControllerColors(self, animated: animated)
	}
	
	override func viewDidDisappear(animated: Bool) {
		super.viewDidDisappear(animated)
		
		toggleDurationPicker(false)
		for (m, button) in self.moodPicker.moodButtons {
			button.alpha = 1
		}
	}
	
	override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
		super.touchesEnded(touches, withEvent: event)
		
		let touch = touches.first as! UITouch
		let location = touch.locationInView(touch.view)
		if _showingReminderView {
			if !CGRectContainsPoint(reminderView.frame, location) {
				UIView.animateWithDuration(0.4) {
					self.toggleReminderView(false)
				}
			}
		} else if _showingDurationPicker {
			UIView.animateWithDuration(0.25) {
				self._pickedMood = nil
				for (m, button) in self.moodPicker.moodButtons {
					button.alpha = 1
				}
				
				self.toggleDurationPicker(false)
			}
		}
	}
	
	// MARK: Constraints
	
	private var _didSetupConstraints = false
	
	override func updateViewConstraints() {
		if !_didSetupConstraints {
			setupFullScreenControllerViewConstraints(self)
			
			let views: [NSObject: AnyObject] = [
				"reminderView": reminderView,
				"topLayoutGuide": topLayoutGuide,
				"contentView": contentView,
				"reminderButton": reminderButton,
				"spacer1": spacerViews[0],
				"moodPicker": moodPicker,
				"durationPicker": durationPicker,
				"spacer2": spacerViews[1],
				"bottomLayoutGuide": bottomLayoutGuide
			]
			
			let margin: CGFloat = 14
			let metrics = [
				"margin": margin
			]
			
			reminderView.layoutMargins = UIEdgeInsets(top: topLayoutGuide.length + margin, left: margin, bottom: margin, right: margin)
			
			view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[reminderView][topLayoutGuide]", options: nil, metrics: metrics, views: views))
			view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[reminderView]|", options: nil, metrics: metrics, views: views))
			
			view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[topLayoutGuide][contentView][bottomLayoutGuide]", options: nil, metrics: metrics, views: views))
			view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[contentView]|", options: nil, metrics: metrics, views: views))
			
			contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-(margin)-[reminderButton]", options: nil, metrics: metrics, views: views))
			contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[spacer1(>=0,==spacer2)][moodPicker][spacer2]|", options: nil, metrics: metrics, views: views))
			contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[spacer1(0,==spacer2)]", options: nil, metrics: metrics, views: views))
			contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[moodPicker]|", options: nil, metrics: metrics, views: views))
			contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[durationPicker]|", options: nil, metrics: metrics, views: views))
			contentView.addConstraint(NSLayoutConstraint(item: durationPicker, attribute: .CenterY, relatedBy: .Equal, toItem: moodPicker, attribute: .CenterY, multiplier: 1, constant: 0))
			for subview in contentView.subviews {
				contentView.addConstraint(NSLayoutConstraint(item: subview, attribute: .CenterX, relatedBy: .Equal, toItem: contentView, attribute: .CenterX, multiplier: 1, constant: 0))
			}
			
			_didSetupConstraints = true
		}
		
		super.updateViewConstraints()
	}
	
	// MARK: API
	
	private var _showingReminderView = false
	
	func toggleReminderView(_ state: Bool? = nil) {
		_showingReminderView = state != nil ? state! : !_showingReminderView
		
		let transform = CGAffineTransformMakeTranslation(0, _showingReminderView ? reminderView.bounds.height : 0)
		reminderView.transform = transform
		contentView.transform = transform
		contentView.alpha = _showingReminderView ? 0.5 : 1
		tabBarController?.tabBar.alpha = _showingReminderView ? 0.5 : 1
		tabBarController?.tabBar.transform = transform
		
		contentView.userInteractionEnabled = !_showingReminderView
	}
	
	private var _showingDurationPicker = false
	
	func toggleDurationPicker(_ state: Bool? = nil) {
		_showingDurationPicker = state != nil ? state! : !_showingDurationPicker
		
		moodPicker.alpha = _showingDurationPicker ? 0.15 : 1
		moodPicker.transform = CGAffineTransformMakeTranslation(0, _showingDurationPicker ? -50 : 0)
		
		durationPicker.alpha = _showingDurationPicker ? 1 : 0
		durationPicker.userInteractionEnabled = _showingDurationPicker
		durationPicker.transform = CGAffineTransformMakeTranslation(0, _showingDurationPicker ? 35 : 70)
	}
	
	func remind() {
		reminderButton.animateWithApplicationShake(0.55, delay: 0, options: nil) {
			(completed) in
			self.reminderButton.animateWithApplicationShake(0.55, delay: 0.35, options: nil) {
				(completed) in
				self.reminderButton.animateWithApplicationShake(0.55, delay: 0.35, options: nil, completion: nil)
			}
		}
	}
	
	// MARK: Handlers
	
	func didTapReminderButton(button: UIButton!) {
		UIView.animateWithDuration(0.3) {
			self.toggleReminderView(true)
		}
	}
	
	private var _pickedMood: Mood! = nil
	
	func moodPickerView(moodPickerView: MoodPickerView, didPickMood mood: Mood) {
		_pickedMood = mood
		UIView.animateWithDuration(0.3) {
			for (m, button) in self.moodPicker.moodButtons {
				button.alpha = (m == self._pickedMood ? 1 : 0)
			}
			
			self.toggleDurationPicker(true)
		}
	}
	
	func durationPickerView(durationPickerView: DurationPickerView, didPickDuration duration: Duration) {
		let relaxationController = RelaxationNavigationController(mood: _pickedMood, duration: duration)
		relaxationController.delegate = self
		relaxationController.transitioningDelegate = transitionManager
		relaxationController.modalPresentationStyle = .Custom
		
		presentViewController(relaxationController, animated: true) {
			UIApplication.sharedApplication().idleTimerDisabled = true
		}
	}
	
	// MARK: DailyReminderViewDelegate
	
	func dailyReminderView(dailyReminderView: DailyReminderView, didToggleReminder reminder: Bool) {
		UIApplication.sharedApplication().relaxationReminder = reminder ? UILocalNotification.applicationRelaxationReminder(reminderView.timePicker.date) : nil
	}
	
	func dailyReminderView(dailyReminderView: DailyReminderView, didChangeTime time: NSDate) {
		UIApplication.sharedApplication().relaxationReminder = UILocalNotification.applicationRelaxationReminder(time)
	}
	
	// MARK: RelaxationNavigationControllerDelegate
	
	func relaxationNavigationControllerShouldDismiss(relaxationNavigationController: RelaxationNavigationController) {
		dismissViewControllerAnimated(true) {
			UIApplication.sharedApplication().idleTimerDisabled = false
		}
	}
	
}
