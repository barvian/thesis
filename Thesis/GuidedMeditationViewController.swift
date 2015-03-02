//
//  GuidedMeditationViewController.swift
//  Thesis
//
//  Created by Maxwell Barvian on 3/2/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit
import Async

class GuidedMeditationViewController: UIViewController, FullScreenViewController, RelaxationViewController {
	
	weak var relaxationDelegate: RelaxationViewControllerDelegate?
	
	let tintColor = UIColor.whiteColor()
	let backgroundColor = UIColor.applicationDarkColor()
	let tabColor = UIColor.clearColor()
	let selectedTabColor = UIColor.clearColor()
	
	let navigationBarHidden = true
	let navigationBarTranslucent = true
	
	private(set) var showingInstructions = true
	
	private(set) lazy var titleLabel: UILabel = {
		let label = UILabel.applicationHeaderLabel()
		label.text = "Guided Meditation"
		label.setTranslatesAutoresizingMaskIntoConstraints(false)
		label.textColor = UIColor.whiteColor()
		
		return label
	}()
	
	private(set) lazy var instructionsLabel: UILabel = {
		let label = UILabel.applicationSubheaderLabel()
		label.text = "Tap the play button below and follow the instructions.  Headphones may work best with this exercise."
		label.setTranslatesAutoresizingMaskIntoConstraints(false)
		label.textColor = UIColor.whiteColor().colorWithAlphaComponent(0.85)
		
		return label
	}()
	
	private(set) lazy var audioButton: ChunkyButton = {
		let button = ChunkyButton()
		button.setTranslatesAutoresizingMaskIntoConstraints(false)
		button.setTitle(nil, forState: .Normal)
		button.zIndex = 2
		
		button.addTarget(self, action: "didTapAudioButton:", forControlEvents: .TouchUpInside)
		
		return button
	}()
	
	private(set) lazy var progressButton: UIButton = {
		let button = UIButton.buttonWithType(.System) as! UIButton
		button.setTranslatesAutoresizingMaskIntoConstraints(false)
		button.tintColor = UIColor.whiteColor()
		
		button.addTarget(self, action: "didTapProgressButton:", forControlEvents: .TouchUpInside)
		
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
	
	override func prefersStatusBarHidden() -> Bool {
		return !showingInstructions
	}
	
	override func preferredStatusBarStyle() -> UIStatusBarStyle {
		return .LightContent
	}
	
	convenience override init() {
		self.init(nibName: nil, bundle: nil)
		
		title = "Guided Meditation"
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.addSubview(titleLabel)
		view.addSubview(instructionsLabel)
		view.addSubview(spacerViews[0])
		view.addSubview(audioButton)
		view.addSubview(spacerViews[1])
		view.addSubview(progressButton)
		
		setupFullScreenControllerView(self)
	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		
		shouldUpdateProgressButton()
		
		updateFullScreenControllerColors(self, animated: false)
		hideFullScreenControllerNavigationBar(self, animated: false)
	}
	
	// MARK: API
	
	private var _hideBlock: Async?
	
	func toggleInstructions(_ state: Bool? = nil, timer: Double? = nil) {
		showingInstructions = state != nil ? state! : !showingInstructions
		let alpha: CGFloat = showingInstructions ? 1.0 : 0.0
		
		UIView.animateWithDuration(0.33) {
			self.titleLabel.alpha = alpha
			self.instructionsLabel.alpha = alpha
			self.progressButton.alpha = alpha
			self.setNeedsStatusBarAppearanceUpdate()
		}
		
		_hideBlock?.cancel()
		if showingInstructions && timer != nil {
			_hideBlock = Async.main(after: timer!) {
				self.toggleInstructions(false)
			}
		}
	}
	
	override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
		super.touchesEnded(touches, withEvent: event)
		
		if _started {
			toggleInstructions(timer: 5)
		}
	}
	
	// MARK: Constraints
	
	private var _didSetupConstraints = false
	
	override func updateViewConstraints() {
		if !_didSetupConstraints {
			setupFullScreenControllerViewConstraints(self)
			
			let views: [NSObject: AnyObject] = [
				"titleLabel": titleLabel,
				"instructionsLabel": instructionsLabel,
				"spacer1": spacerViews[0],
				"audioButton": audioButton,
				"spacer2": spacerViews[1],
				"progressButton": progressButton
			]
			
			let vMargin: CGFloat = 34, hMargin: CGFloat = 26
			let metrics = [
				"vMargin": vMargin,
				"hMargin": hMargin
			]
			
			view.addConstraint(NSLayoutConstraint(item: progressButton, attribute: .Bottom, relatedBy: .Equal, toItem: bottomLayoutGuide, attribute: .Top, multiplier: 1, constant: -vMargin))
			view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-(54)-[titleLabel]-[instructionsLabel][spacer1(>=0)][audioButton(100)][spacer2(==spacer1)][progressButton]", options: nil, metrics: metrics, views: views))
			view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(hMargin)-[titleLabel]-(hMargin)-|", options: nil, metrics: metrics, views: views))
			view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(hMargin)-[instructionsLabel]-(hMargin)-|", options: nil, metrics: metrics, views: views))
			view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[spacer1(0,==spacer2)]", options: nil, metrics: metrics, views: views))
			view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[audioButton(100)]", options: nil, metrics: metrics, views: views))
			for (_, subview) in views {
				view.addConstraint(NSLayoutConstraint(item: subview, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0))
			}
			
			_didSetupConstraints = true
		}
		
		super.updateViewConstraints()
	}
	
	// MARK: Handlers
	
	private var _started = false
	func didTapAudioButton(button: UIButton!) {
		toggleInstructions()
		
		_started = true
	}
	
	func didTapProgressButton(button: UIButton!) {
		relaxationDelegate?.relaxationViewControllerDidTapProgressButton?(self)
	}
	
	// MARK: RelaxationViewController
	
	func shouldUpdateProgressButton() {
		relaxationViewController(self, shouldUpdateProgressButton: progressButton)
	}
	
}