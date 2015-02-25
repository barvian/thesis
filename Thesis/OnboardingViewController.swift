//
//  OnboardingViewController.swift
//  Thesis
//
//  Created by Maxwell Barvian on 1/25/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit

class OnboardingViewController: SlidingViewController, FullScreenViewController {
	
	let backgroundColor = UIColor.whiteColor()
	let tintColor = UIColor.applicationBlueColor()
	let tabColor = UIColor.clearColor()
	let selectedTabColor = UIColor.clearColor()
	
	let navigationBarHidden = true
	let navigationBarTranslucent = true
	
	convenience init() {
		self.init(spacing: 0)
		
		title = "Welcome"
		viewControllers = [
			OnboardingWelcomeController(),
			OnboardingGADController(),
			OnboardingTutorialController(),
			OnboardingReminderController(),
			OnboardingCompleteController()
		]
		selectedIndex = 0
		paginated = true
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupFullScreenControllerView(self)
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
	
}
