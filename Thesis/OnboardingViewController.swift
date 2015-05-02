//
//  OnboardingViewController.swift
//  Thesis
//
//  Created by Maxwell Barvian on 1/25/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit

@objc protocol OnboardingViewControllerDelegate {
	optional func onboardingViewControllerShouldDismiss(onboardingViewController: OnboardingViewController)
}

class OnboardingViewController: UIViewController, FullScreenViewController, OnboardingCompleteSlideDelegate, SlidingViewControllerDelegate {
	
	weak var delegate: OnboardingViewControllerDelegate?
	
	let backgroundColor = UIColor.whiteColor()
	let tintColor = UIColor.applicationBlueColor()
	let tabColor = UIColor.clearColor()
	let selectedTabColor = UIColor.clearColor()
	
	let navigationBarHidden = true
	let navigationBarTranslucent = true
	
	private(set) lazy var slidingViewController: SlidingViewController = {
		let controller = SlidingViewController()
		controller.delegate = self
		
		controller.viewControllers = [
			OnboardingSlideController(contentView: self.welcomeSlide),
			OnboardingSlideController(contentView: self.anxietySlide),
			OnboardingSlideController(contentView: self.tutorialSlide),
			OnboardingSlideController(contentView: self.reminderSlide),
			OnboardingSlideController(contentView: self.completeSlide)
		]
		controller.selectedIndex = 0
		controller.paginated = true
		
		return controller
	}()
	
	private(set) lazy var welcomeSlide: OnboardingSlide = {
		let slide = OnboardingSlide(header: "Welcome", subheader: "Thank you for downloading this application.  Swipe through this quick tutorial to get started.")
		
		return slide
	}()
	
	private(set) lazy var anxietySlide: OnboardingSlide = {
		let slide = OnboardingSlide(header: "Anxiety Disorder", subheader: "All of us worry about things like health, money, or family problems. But people with generalized anxiety disorder (GAD) are extremely worried about these and many other things, even when there is little or no reason to worry about them. They are very anxious about just getting through the day. They think things will always go badly. At times, worrying keeps people with GAD from doing everyday tasks.")
		
		return slide
	}()
	
	private(set) lazy var tutorialSlide: OnboardingSlide = {
		let slide = OnboardingTutorialSlide()
		
		return slide
	}()
	
	private(set) lazy var reminderSlide: OnboardingSlide = {
		let slide = OnboardingReminderSlide()
		
		return slide
	}()
	
	private(set) lazy var completeSlide: OnboardingSlide = {
		let slide = OnboardingCompleteSlide()
		slide.delegate = self
		
		return slide
	}()
	
	convenience init() {
		self.init(nibName: nil, bundle: nil)
		
		title = "Onboarding"
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		addChildViewController(slidingViewController)
		view.addSubview(slidingViewController.view)
		slidingViewController.didMoveToParentViewController(self)
		
		setupFullScreenControllerView(self)
		slidingViewController.pageControlCover.tintColor = backgroundColor
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
	
	// MARK: SlidingViewControllerDelegate
	
	func slidingViewController(slidingViewController: SlidingViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
		if let previousViewController = previousViewControllers[0] as? OnboardingSlideController, slide = previousViewController.contentView as? OnboardingReminderSlide {
			UIApplication.sharedApplication().relaxationReminder = UILocalNotification.applicationRelaxationReminder(slide.timePicker.date)
		}
	}
	
	// MARK: OnboardingCompleteSlideDelegate
	
	func onboardingCompleteSlide(onboardingCompleteslide: OnboardingCompleteSlide, didTapDoneButton doneButton: UIButton!) {
		delegate?.onboardingViewControllerShouldDismiss?(self)
	}
	
}
