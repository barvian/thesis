//
//  OnboardingViewController.swift
//  Thesis
//
//  Created by Maxwell Barvian on 1/25/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit

class OnboardingViewController: SlidingViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource, UIScrollViewDelegate {
    
    init() {
        super.init()
        
        title = "Welcome"
        viewControllers = [
            OnboardingWelcomeController(),
            OnboardingCompleteController()
        ]
        selectedIndex = 0
        paginated = true
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.whiteColor()
    }
    
}
