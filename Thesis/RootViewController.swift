//
//  RootViewController.swift
//  Thesis
//
//  Created by Maxwell Barvian on 1/25/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit

class RootViewController: UITabBarController {
    
    private(set) lazy var learnController: UIViewController = {
        let learnController = LearnViewController()
        
        return learnController
    }()
    
    private(set) lazy var relaxController: RelaxViewController = {
        let relaxController = RelaxViewController()
        
        return relaxController
    }()
    
    private(set) lazy var reflectController: UIViewController = {
        let reflectController = UIViewController()
        
        return reflectController
    }()
    
    convenience override init() {
        self.init(nibName: nil, bundle: nil)
        
        viewControllers = [
            UINavigationController(rootViewController: learnController),
            relaxController,
            reflectController
        ]
        selectedIndex = 1
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if !SDCloudUserDefaults.boolForKey(Constants.UserDefaults.hasSeenWelcome) {
            let welcomeController = OnboardingViewController()
            presentViewController(welcomeController, animated: true, completion: {
                SDCloudUserDefaults.setBool(true, forKey: Constants.UserDefaults.hasSeenWelcome)
            })
        }
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

