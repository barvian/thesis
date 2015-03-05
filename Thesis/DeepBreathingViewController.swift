//
//  DeepBreathingViewController.swift
//  Thesis
//
//  Created by Maxwell Barvian on 2/23/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit
import Async

class DeepBreathingViewController: UIViewController, FullScreenViewController, RelaxationViewController {
	
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
		label.text = "Deep Breathing"
		label.setTranslatesAutoresizingMaskIntoConstraints(false)
		label.textColor = UIColor.whiteColor()
		
		return label
	}()
	
	private(set) lazy var instructionsLabel: UILabel = {
		let label = UILabel.applicationSubheaderLabel()
		label.text = "Match your breath with the circle below, letting thoughts and feelings come and go with little effort. Try to breathe as deeply into your abdomen as you can."
		label.setTranslatesAutoresizingMaskIntoConstraints(false)
		label.textColor = UIColor.whiteColor().colorWithAlphaComponent(0.85)
		
		return label
	}()
	
	private(set) lazy var breather: UIView = {
		let breather = UIView()
		breather.setTranslatesAutoresizingMaskIntoConstraints(false)
		breather.transform = CGAffineTransformMakeScale(0.75, 0.75)
		
		return breather
	}()
	
	private(set) lazy var breatherButton: ChunkyButton = {
		let button = ChunkyButton()
		button.setTranslatesAutoresizingMaskIntoConstraints(false)
		button.setTitle(nil, forState: .Normal)
		button.zIndex = 2
		
		button.addTarget(self, action: "didTapBreatherButton:", forControlEvents: .TouchUpInside)
		
		return button
	}()
	
	private(set) lazy var actionLabel: UILabel = {
		let label = UILabel()
		label.setTranslatesAutoresizingMaskIntoConstraints(false)
		label.text = "Begin"
		label.font = UIFont(name: "HelveticaNeue", size: 15)
		label.textColor = UIColor.applicationBaseColor()
		label.numberOfLines = 2
		label.textAlignment = .Center
		label.userInteractionEnabled = false
		
		return label
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
		
		title = "Deep Breathing"
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.addSubview(titleLabel)
		view.addSubview(instructionsLabel)
		view.addSubview(spacerViews[0])
		breather.addSubview(breatherButton)
		view.addSubview(breather)
		view.addSubview(actionLabel)
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
	
	// FIXME: crashes occassionally when dismissing VC
	func breathe(completion: (() -> Void)? = nil) {
		self.actionLabel.text = "Inhale"
		UIView.animateWithDuration(5, delay: 0.0, options: .CurveEaseOut | .AllowUserInteraction, animations: {
			[unowned self] in
			self.breather.transform = CGAffineTransformMakeScale(1.0, 1.0)
			self.breatherButton.zIndex = 3
			}) {
				[unowned self] (completed: Bool) in
				self.actionLabel.text = "Hold"
				Async.main(after: 5) {
					[unowned self] in
					self.actionLabel.text = "Exhale"
					UIView.animateWithDuration(5, delay: 0.0, options: .CurveEaseOut | .AllowUserInteraction, animations: {
						[unowned self] in
						self.breather.transform = CGAffineTransformMakeScale(0.75, 0.75)
						self.breatherButton.zIndex = 2
						}) {
							[unowned self] (completed: Bool) in
							self.actionLabel.text = "Breathe\nnormally"
							Async.main(after: 8) {
								[unowned self] in
								self.breathe()
							}
					}
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
				"breather": breather,
				"breatherButton": breatherButton,
				"actionLabel": actionLabel,
				"spacer2": spacerViews[1],
				"progressButton": progressButton
			]
			
			let vMargin: CGFloat = 34, hMargin: CGFloat = 26
			let metrics = [
				"vMargin": vMargin,
				"hMargin": hMargin
			]
			
			view.addConstraint(NSLayoutConstraint(item: progressButton, attribute: .Bottom, relatedBy: .Equal, toItem: bottomLayoutGuide, attribute: .Top, multiplier: 1, constant: -vMargin))
			view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-(54)-[titleLabel]-[instructionsLabel][spacer1(>=0)][breather(156)][spacer2(==spacer1)][progressButton]", options: nil, metrics: metrics, views: views))
			view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(hMargin)-[titleLabel]-(hMargin)-|", options: nil, metrics: metrics, views: views))
			view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(hMargin)-[instructionsLabel]-(hMargin)-|", options: nil, metrics: metrics, views: views))
			view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[spacer1(0,==spacer2)]", options: nil, metrics: metrics, views: views))
			view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[breather(156)]", options: nil, metrics: metrics, views: views))
			view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[breatherButton]|", options: nil, metrics: metrics, views: views))
			view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[breatherButton]|", options: nil, metrics: metrics, views: views))
			view.addConstraint(NSLayoutConstraint(item: actionLabel, attribute: .CenterY, relatedBy: .Equal, toItem: breather, attribute: .CenterY, multiplier: 1, constant: 0))
			for (_, subview) in views {
				view.addConstraint(NSLayoutConstraint(item: subview, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0))
			}
			
			_didSetupConstraints = true
		}
		
		super.updateViewConstraints()
	}
	
	// MARK: Handlers
	
	private var _started = false
	func didTapBreatherButton(button: UIButton!) {
		toggleInstructions()
		
		if !_started {
			breathe()
		}
		
		_started = true
	}
	
	func didTapProgressButton(button: UIButton!) {
		relaxationDelegate?.relaxationViewControllerDidTapProgressButton?(self)
	}
	
	// MARK: RelaxationViewControllerDelegate
	
	func shouldUpdateProgressButton() {
		relaxationViewController(self, shouldUpdateProgressButton: progressButton)
	}
	
}