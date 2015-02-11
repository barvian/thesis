//
//  RelaxationLauncherController.swift
//  Thesis
//
//  Created by Maxwell Barvian on 2/10/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit
import SSDynamicText

class RelaxationLaunchController: FullScreenViewController {
    
    var mood: Mood!
    
    private(set) lazy var moodLabel: UILabel = {
        let label = UILabel()
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        label.font = UIFont(name: "HelveticaNeue", size: 52.0)
        label.text = String(self.mood.rawValue)
        label.lineBreakMode = .ByTruncatingTail
        label.numberOfLines = 0
        label.textAlignment = .Center
        
        return label
    }()
    
    private(set) lazy var subheaderLabel: UILabel = {
        let label = SSDynamicLabel(font: "HelveticaNeue", baseSize: 23.0)
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        label.text = "Relaxation Technique"
        label.textColor = UIColor.applicationBaseColor()
        label.lineBreakMode = .ByTruncatingTail
        label.numberOfLines = 0
        label.textAlignment = .Center
        
        return label
    }()
    
    private(set) lazy var quoteLabel: UILabel = {
        let label = SSDynamicLabel(font: "HelveticaNeue-Light", baseSize: 18.0)
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        label.text = "Quote goes here."
        label.textColor = UIColor(r: 149, g: 160, b: 176)
        label.lineBreakMode = .ByTruncatingTail
        label.numberOfLines = 0
        label.textAlignment = .Center
        
        return label
    }()
    
    private(set) lazy var beginButton: UIButton = {
        let button = UIButton.buttonWithType(.System) as UIButton
        button.setTranslatesAutoresizingMaskIntoConstraints(false)
        button.setTitle("Begin", forState: .Normal)
        
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
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .Default
    }
    
    convenience override init() {
        self.init(nibName: nil, bundle: nil)
        
        tintColor = UIColor.applicationBlueColor()
        backgroundColor = UIColor.whiteColor()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(moodLabel)
        view.addSubview(subheaderLabel)
        view.addSubview(spacerViews[0])
        view.addSubview(quoteLabel)
        view.addSubview(spacerViews[1])
        view.addSubview(beginButton)
        
        view.setNeedsUpdateConstraints() // bootstrap AutoLayout
    }
    
    // MARK: Constraints
    
    private var didSetupConstraints = false
    
    override func updateViewConstraints() {
        if !didSetupConstraints {
            let views = [
                "moodLabel": moodLabel,
                "subheaderLabel": subheaderLabel,
                "spacer1": spacerViews[0],
                "quoteLabel": quoteLabel,
                "spacer2": spacerViews[1],
                "beginButton": beginButton
            ]
            let metrics = [
                "vMargin": 52,
                "hMargin": 26
            ]
            
            view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-(vMargin)-[moodLabel]-[subheaderLabel][spacer1(>=0)][quoteLabel][spacer2(==spacer1)]-[beginButton]-(vMargin)-|", options: nil, metrics: metrics, views: views))
            view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[spacer1(0,==spacer2)]", options: nil, metrics: metrics, views: views))
            view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(hMargin)-[moodLabel]-(hMargin)-|", options: nil, metrics: metrics, views: views))
            view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(hMargin)-[subheaderLabel]-(hMargin)-|", options: nil, metrics: metrics, views: views))
            for (_, subview) in views {
                view.addConstraint(NSLayoutConstraint(item: subview, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0))
            }
            
            didSetupConstraints = true
        }
        
        super.updateViewConstraints()
    }
    
}
