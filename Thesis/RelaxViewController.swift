//
//  RelaxViewController.swift
//  Thesis
//
//  Created by WSOL Intern on 1/12/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit

class RelaxViewController: UIViewController {
    
    private(set) lazy var headlineLabel: UILabel = {
        let label = UILabel()
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        label.text = "How are you feeling right now?"
        label.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        label.numberOfLines = 0
        label.textAlignment = .Center
        
        return label
    }()
    
    private(set) lazy var 😊Button: UIButton = {
        let button = UIButton.buttonWithType(.System) as UIButton
        button.setTranslatesAutoresizingMaskIntoConstraints(false)
        button.setTitle("☺️", forState: .Normal)
        button.layer.borderColor = UIColor.greenColor().CGColor
        button.layer.borderWidth = 3
        button.addTarget(self, action: "didTapMoodButton:", forControlEvents: .TouchUpInside)
        
        return button
    }()
    
    private(set) lazy var 😐Button: UIButton = {
        let button = UIButton.buttonWithType(.System) as UIButton
        button.setTranslatesAutoresizingMaskIntoConstraints(false)
        button.setTitle("😐", forState: .Normal)
        button.layer.borderColor = UIColor.yellowColor().CGColor
        button.layer.borderWidth = 3
        button.addTarget(self, action: "didTapMoodButton:", forControlEvents: .TouchUpInside)
        
        return button
    }()
    
    private(set) lazy var 😖Button: UIButton = {
        let button = UIButton.buttonWithType(.System) as UIButton
        button.setTranslatesAutoresizingMaskIntoConstraints(false)
        button.setTitle("😖", forState: .Normal)
        button.layer.borderColor = UIColor.redColor().CGColor
        button.layer.borderWidth = 3
        button.addTarget(self, action: "didTapMoodButton:", forControlEvents: .TouchUpInside)
        
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
        
        title = "Relax"
    }
    
    override func loadView() {
        self.view = UIView()
        
        view.addSubview(spacerViews[0])
        view.addSubview(headlineLabel)
        view.addSubview(😊Button)
        view.addSubview(😐Button)
        view.addSubview(😖Button)
        view.addSubview(spacerViews[1])
        
        view.setNeedsUpdateConstraints() // bootstrap AutoLayout
    }
    
    // MARK: Constraints
    
    private var didSetupConstraints = false
    
    override func updateViewConstraints() {
        if !didSetupConstraints {
            let views = [
                "spacer1": spacerViews[0],
                "headlineLabel": headlineLabel,
                "happyButton": 😊Button,
                "neutralButton": 😐Button,
                "flusteredButton": 😖Button,
                "spacer2": spacerViews[1]
            ]
            let metrics = [
                "margin": 16
            ]
            
            view.addConstraint(NSLayoutConstraint(item: spacerViews[0], attribute: .Top, relatedBy: .Equal, toItem: topLayoutGuide, attribute: .Bottom, multiplier: 1, constant: 0))
            view.addConstraint(NSLayoutConstraint(item: spacerViews[1], attribute: .Bottom, relatedBy: .Equal, toItem: bottomLayoutGuide, attribute: .Top, multiplier: 1, constant: 0))
            view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[spacer1(>=0)]-[headlineLabel]-(margin)-[happyButton(70)]-[neutralButton(==happyButton)]-[flusteredButton(==happyButton)]-[spacer2(==spacer1)]", options: nil, metrics: metrics, views: views))
            view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("[spacer1(0,==spacer2)]", options: nil, metrics: metrics, views: views))
            view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|-[headlineLabel]-|", options: nil, metrics: metrics, views: views))
            view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("[happyButton(70,==neutralButton,==flusteredButton)]", options: nil, metrics: metrics, views: views))
            for (_, subview) in views {
                view.addConstraint(NSLayoutConstraint(item: subview, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0))
            }
            
            didSetupConstraints = true
        }
        
        super.updateViewConstraints()
    }
    
    // MARK: Handlers
    
    func didTapMoodButton(button: UIButton!) {
        println(button.titleForState(.Normal))
    }
    
}
