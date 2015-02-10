//
//  RootViewController.swift
//  Thesis
//
//  Created by Maxwell Barvian on 1/25/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit
import SDCloudUserDefaults
import AGWindowView

class RootViewController: UITabBarController {
    
    private(set) lazy var learnController: LearnViewController = {
        let learnController = LearnViewController()
        
        return learnController
    }()
    
    private(set) lazy var relaxController: RelaxViewController = {
        let relaxController = RelaxViewController()
        
        return relaxController
    }()
    
    private(set) lazy var reflectController: ReflectViewController = {
        let reflectController = ReflectViewController()
        
        return reflectController
    }()


    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        viewControllers = [
            UINavigationController(rootViewController: learnController),
            relaxController,
            reflectController
        ]
        selectedIndex = 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

