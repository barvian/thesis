//
//  RootViewController.swift
//  Thesis
//
//  Created by Maxwell Barvian on 1/25/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit

class RootViewController: SlidingTabController {
    
    convenience override init() {
        self.init(nibName: nil, bundle: nil)
        
        viewControllers = [
            UIViewController(),
            RelaxViewController(),
            UIViewController()
        ]
        selectedIndex = 1
    }
    
    override func viewDidAppear(animated: Bool) {
        if !SDCloudUserDefaults.boolForKey(Constants.UserDefaults.hasSeenWelcome) {
            let welcomeController = WelcomeViewController()
            welcomeController.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .Plain, target: self, action: "didTapDoneButton:")
            presentViewController(UINavigationController(rootViewController: welcomeController), animated: true, completion: {
                SDCloudUserDefaults.setBool(true, forKey: Constants.UserDefaults.hasSeenWelcome)
            })
        }
    }
    
    // MARK: Handlers
    
    func didTapDoneButton(button: UIBarButtonItem!) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: Constraints
    
    private var didSetupConstraints = false
    
    override func updateViewConstraints() {
        if !didSetupConstraints {
            
            didSetupConstraints = true
        }
        
        super.updateViewConstraints()
    }
}

