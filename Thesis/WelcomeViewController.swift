//
//  WelcomeViewController.swift
//  Thesis
//
//  Created by Maxwell Barvian on 1/25/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        label.text = "Welcome to Thesis."
        label.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        
        return label
    }()
    
    convenience override init() {
        self.init(nibName: nil, bundle: nil)
        
        title = "Welcome"
    }
    
    override func loadView() {
        self.view = UIView()
        view.addSubview(welcomeLabel)
        
        view.setNeedsUpdateConstraints()
    }
    
    // MARK: Constraints
    
    private var didSetupConstraints = false
    
    override func updateViewConstraints() {
        if !didSetupConstraints {
            view.addConstraint(NSLayoutConstraint(item: welcomeLabel, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0))
            view.addConstraint(NSLayoutConstraint(item: welcomeLabel, attribute: .CenterY, relatedBy: .Equal, toItem: view, attribute: .CenterY, multiplier: 1, constant: 0))
            
            didSetupConstraints = true
        }
        
        super.updateViewConstraints()
    }
}
