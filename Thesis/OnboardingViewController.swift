//
//  OnboardingViewController.swift
//  Thesis
//
//  Created by Maxwell Barvian on 1/25/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit

class OnboardingViewController: SlidingViewController {
	
	convenience init() {
		self.init(spacing: 0)
		
		title = "Welcome"
		viewControllers = [
			OnboardingWelcomeController(),
			OnboardingCompleteController()
		]
		selectedIndex = 0
		paginated = true
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = UIColor.whiteColor()
	}
	
}
