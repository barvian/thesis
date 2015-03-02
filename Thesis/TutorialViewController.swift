//
//  TutorialViewController.swift
//  Thesis
//
//  Created by Maxwell Barvian on 3/1/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit

@objc protocol TutorialViewControllerDelegate {
	optional func tutorialViewControllerShouldDismiss(tutorialViewController: TutorialViewController)
}

// FIXME: Buggy layout

class TutorialViewController: UIViewController, FullScreenViewController {
	
	weak var delegate: TutorialViewControllerDelegate?
	
	let backgroundColor = UIColor.whiteColor()
	let tintColor = UIColor.applicationBlueColor()
	let tabColor = UIColor.clearColor()
	let selectedTabColor = UIColor.clearColor()
	
	let navigationBarHidden = true
	let navigationBarTranslucent = true
	
	private(set) lazy var scrollView: UIScrollView = {
		let scrollView = UIScrollView()
		scrollView.setTranslatesAutoresizingMaskIntoConstraints(false)
		
		return scrollView
	}()
	
	private(set) lazy var wrapperView: UIView = {
		let wrapperView = UIView()
		wrapperView.setTranslatesAutoresizingMaskIntoConstraints(false)
		
		return wrapperView
	}()
	
	private(set) lazy var spacerViews: [UIView] = {
		let spacers = [UIView(), UIView()]
		for spacer in spacers {
			spacer.setTranslatesAutoresizingMaskIntoConstraints(false)
			spacer.hidden = true
		}
		
		return spacers
	}()
	
	private(set) lazy var contentView: OnboardingSlide = {
		let slide = OnboardingTutorialSlide()
		slide.setTranslatesAutoresizingMaskIntoConstraints(false)
		
		return slide
	}()
	
	private(set) lazy var doneButton: UIButton = {
		let button = UIButton.buttonWithType(.System) as! UIButton
		button.setTranslatesAutoresizingMaskIntoConstraints(false)
		button.setTitle("Done", forState: .Normal)
		
		button.addTarget(self, action: "didTapDoneButton:", forControlEvents: .TouchUpInside)
		
		return button
	}()
	
	override convenience init() {
		self.init(nibName: nil, bundle: nil)
		
		title = "Tutorial"
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		wrapperView.addSubview(spacerViews[0])
		wrapperView.addSubview(contentView)
		wrapperView.addSubview(doneButton)
		wrapperView.addSubview(spacerViews[1])
		
		scrollView.addSubview(wrapperView)
		view.addSubview(scrollView)
		
		setupFullScreenControllerView(self)
		
		view.setNeedsUpdateConstraints() // bootstrap AutoLayout
	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		
		updateFullScreenControllerColors(self, animated: animated)
		hideFullScreenControllerNavigationBar(self, animated: false)
	}

	override func viewDidDisappear(animated: Bool) {
		super.viewDidDisappear(animated)
		
		unhideFullScreenControllerNavigationBar(self, animated: false)
	}

	// MARK: Constraints
	
	private var _didSetupConstraints = false
	
	override func updateViewConstraints() {
		if !_didSetupConstraints {
			setupFullScreenControllerViewConstraints(self)
			
			let views: [NSObject: AnyObject] = [
				"scrollView": scrollView,
				"wrapperView": wrapperView,
				"spacer1": spacerViews[0],
				"contentView": contentView,
				"doneButton": doneButton,
				"spacer2": spacerViews[1]
			]
			let margin: CGFloat = 26
			let metrics = [
				"margin": margin
			]
			
			view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[scrollView]|", options: nil, metrics: metrics, views: views))
			view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[scrollView]|", options: nil, metrics: metrics, views: views))
			
			view.addConstraint(NSLayoutConstraint(item: wrapperView, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: 1, constant: 0))
			view.addConstraint(NSLayoutConstraint(item: wrapperView, attribute: .Height, relatedBy: .GreaterThanOrEqual, toItem: view, attribute: .Height, multiplier: 1, constant: 0))
			scrollView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[wrapperView]|", options: nil, metrics: metrics, views: views))
			scrollView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[wrapperView]|", options: nil, metrics: metrics, views: views))
			
			wrapperView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[spacer1(>=margin)][contentView]-(margin)-[doneButton][spacer2(==spacer1)]|", options: nil, metrics: metrics, views: views)) // FIXME: should not use static status bar height
			wrapperView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[contentView]|", options: nil, metrics: metrics, views: views))
			wrapperView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[spacer1(0,==spacer2)]", options: nil, metrics: metrics, views: views))
			for spacer in [doneButton] + spacerViews {
				wrapperView.addConstraint(NSLayoutConstraint(item: spacer, attribute: .CenterX, relatedBy: .Equal, toItem: wrapperView, attribute: .CenterX, multiplier: 1, constant: 0))
			}
			
			_didSetupConstraints = true
		}
		
		super.updateViewConstraints()
	}
	
	// MARK: TutorialViewControllerDelegate
	
	func didTapDoneButton(doneButton: UIButton!) {
		delegate?.tutorialViewControllerShouldDismiss?(self)
	}
	
}