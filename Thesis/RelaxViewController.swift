//
//  RelaxViewController.swift
//  Thesis
//
//  Created by WSOL Intern on 1/12/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit
import SSDynamicText

class RelaxViewController: UIViewController, FullScreenViewController, RelaxationControllerDelegate, MoodPickerViewDelegate, DurationPickerViewDelegate {
	
	let tintColor = UIColor.applicationBlueColor()
	let backgroundColor = UIColor.applicationBlueColor()
	let tabColor = UIColor(r: 57, g: 109, b: 128)
	let selectedTabColor = UIColor.whiteColor()
	
	let navigationBarHidden = true
	let navigationBarTranslucent = true
	
	let transitionManager = FadeTransitionManager()
	
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
	
	convenience override init() {
		self.init(nibName: nil, bundle: nil)
		
		title = "Relax"
		tabBarItem.image = UIImage(named: "Relax")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.addSubview(spacerViews[0])
		view.addSubview(moodPicker)
		view.addSubview(durationPicker)
		view.addSubview(spacerViews[1])
		
		setupFullScreenControllerView(self)
	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		
		updateFullScreenControllerColors(self, animated: false)
		toggleDurationPicker(false)
		for (m, button) in self.moodPicker.moodButtons {
			button.alpha = 1
		}
	}
	
	override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
		super.touchesEnded(touches, withEvent: event)
		
		UIView.animateWithDuration(0.25) {
			for (m, button) in self.moodPicker.moodButtons {
				button.alpha = 1
			}
			
			self.toggleDurationPicker(false)
		}
	}
	
	// MARK: Constraints
	
	private var _didSetupConstraints = false
	
	override func updateViewConstraints() {
		if !_didSetupConstraints {
			let views = [
				"spacer1": spacerViews[0],
				"moodPicker": moodPicker,
				"durationPicker": durationPicker,
				"spacer2": spacerViews[1]
			]
			
			let margin: CGFloat = 26
			let metrics = [
				"margin": margin
			]
			
			view.addConstraint(NSLayoutConstraint(item: spacerViews[0], attribute: .Top, relatedBy: .Equal, toItem: topLayoutGuide, attribute: .Bottom, multiplier: 1, constant: 0))
			view.addConstraint(NSLayoutConstraint(item: spacerViews[1], attribute: .Bottom, relatedBy: .Equal, toItem: bottomLayoutGuide, attribute: .Top, multiplier: 1, constant: 0))
			view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[spacer1(>=0,==spacer2)][moodPicker][spacer2]", options: nil, metrics: metrics, views: views))
			view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[spacer1(0,==spacer2)]", options: nil, metrics: metrics, views: views))
			view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[moodPicker]|", options: nil, metrics: metrics, views: views))
			view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[durationPicker]|", options: nil, metrics: metrics, views: views))
			view.addConstraint(NSLayoutConstraint(item: durationPicker, attribute: .CenterY, relatedBy: .Equal, toItem: moodPicker, attribute: .CenterY, multiplier: 1, constant: 0))
			for spacer in spacerViews {
				view.addConstraint(NSLayoutConstraint(item: spacer, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0))
			}
			
			_didSetupConstraints = true
		}
		
		super.updateViewConstraints()
	}
	
	// MARK: API
	
	private var _showingDurationPicker = false
	
	func toggleDurationPicker(_ state: Bool? = nil) {
		_showingDurationPicker = state != nil ? state! : !_showingDurationPicker
		
		moodPicker.alpha = _showingDurationPicker ? 0.15 : 1
		moodPicker.transform = CGAffineTransformMakeTranslation(0, _showingDurationPicker ? -50 : 0)
		
		durationPicker.alpha = _showingDurationPicker ? 1 : 0
		durationPicker.userInteractionEnabled = _showingDurationPicker
		durationPicker.transform = CGAffineTransformMakeTranslation(0, _showingDurationPicker ? 35 : 70)
	}
	
	// MARK: Handlers
	
	func moodPickerView(moodPickerView: MoodPickerView, didPickMood mood: Mood) {
		UIView.animateWithDuration(0.3) {
			for (m, button) in self.moodPicker.moodButtons {
				button.alpha = (m == mood ? 1 : 0)
			}
			
			self.toggleDurationPicker(true)
		}
	}
	
	func durationPickerView(durationPickerView: DurationPickerView, didPickDuration duration: Duration) {
		let relaxationController = DeepBreathingViewController()
		relaxationController.relaxationDelegate = self
		relaxationController.navigationItem.hidesBackButton = true
		let navigationController = UINavigationController(rootViewController: relaxationController)
		navigationController.transitioningDelegate = transitionManager
		navigationController.modalPresentationStyle = .Custom
		
		presentViewController(navigationController, animated: true, completion: nil)
	}
	
	// MARK: RelaxationControllerDelegate
	
	func relaxationControllerShouldDismiss(relaxationController: UIViewController) {
		dismissViewControllerAnimated(true, completion: nil)
	}
	
}
