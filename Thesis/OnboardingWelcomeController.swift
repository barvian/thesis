//
//  OnboardingWelcomeController.swift
//  Thesis
//
//  Created by WSOL Intern on 1/12/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit

class OnboardingWelcomeController: UIViewController {
    
    private(set) lazy var label: UILabel = {
        let label = UILabel()
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        label.text = "Welcome to Thesis."
        label.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        label.numberOfLines = 0
        label.textAlignment = .Center
        
        return label
    }()
    
    private(set) lazy var spacerViews: [UIView] = {
        let spacers = [UIView(), UIView()]
        for spacer in spacers {
            spacer.setTranslatesAutoresizingMaskIntoConstraints(false)
            spacer.hidden = true
        }
        
        return spacers
    }()
    
    convenience override init() {
        self.init(nibName: nil, bundle: nil)
        
        title = "Welcome"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(spacerViews[0])
        view.addSubview(label)
        view.addSubview(spacerViews[1])
        
        view.setNeedsUpdateConstraints() // bootstrap AutoLayout
    }
    
    // MARK: Constraints
    
    private var didSetupConstraints = false
    
    override func updateViewConstraints() {
        if !didSetupConstraints {
            let views = [
                "spacer1": spacerViews[0],
                "label": label,
                "spacer2": spacerViews[1]
            ]
            
            view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[spacer1(>=0)]-[label]-[spacer2(==spacer1)]|", options: nil, metrics: nil, views: views))
            view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("[spacer1(0,==spacer2)]", options: nil, metrics: nil, views: views))
            view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|-[label]-|", options: nil, metrics: nil, views: views))
            for (_, subview) in views {
                view.addConstraint(NSLayoutConstraint(item: subview, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0))
            }
            
            didSetupConstraints = true
        }
        
        super.updateViewConstraints()
    }
    
}
