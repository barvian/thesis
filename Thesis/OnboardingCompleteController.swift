//
//  OnboardingCompleteController.swift
//  Thesis
//
//  Created by WSOL Intern on 1/12/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit

class OnboardingCompleteController: UIViewController {
    
    private(set) lazy var doneButton: UIButton = {
        let button = UIButton.buttonWithType(.System) as UIButton
        button.setTranslatesAutoresizingMaskIntoConstraints(false)
        button.setTitle("Get Started", forState: .Normal)
        button.addTarget(self, action: "didTapDoneButton:", forControlEvents: .TouchUpInside)
        
        return button
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
        
        title = "Complete"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(spacerViews[0])
        view.addSubview(doneButton)
        view.addSubview(spacerViews[1])
        
        view.setNeedsUpdateConstraints() // bootstrap AutoLayout
    }
    
    // MARK: Constraints
    
    private var didSetupConstraints = false
    
    override func updateViewConstraints() {
        if !didSetupConstraints {
            let views = [
                "spacer1": spacerViews[0],
                "doneButton": doneButton,
                "spacer2": spacerViews[1]
            ]
            
            view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[spacer1(>=0)]-[doneButton]-[spacer2(==spacer1)]|", options: nil, metrics: nil, views: views))
            view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("[spacer1(200,==spacer2)]", options: nil, metrics: nil, views: views))
            for (_, subview) in views {
                view.addConstraint(NSLayoutConstraint(item: subview, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0))
            }
            
            didSetupConstraints = true
        }
        
        super.updateViewConstraints()
    }
    
    // MARK: Handlers
    
    func didTapDoneButton(button: UIButton!) {
        (UIApplication.sharedApplication().keyWindow?.rootViewController as? RootViewController)?.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
