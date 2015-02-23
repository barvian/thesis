//
//  RelaxViewController.swift
//  Thesis
//
//  Created by WSOL Intern on 1/12/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit
import SSDynamicText

class RelaxViewController: UIViewController, FullScreenViewController, RelaxationControllerDelegate {
	
	let tintColor = UIColor.applicationBlueColor()
	let backgroundColor = UIColor.applicationBlueColor()
	let tabColor = UIColor(r: 57, g: 109, b: 128)
	let selectedTabColor = UIColor.whiteColor()
	
	let navigationBarHidden = true
	let navigationBarTranslucent = true
	
	private(set) lazy var headlineLabel: UILabel = {
		let label = SSDynamicLabel(font: "HelveticaNeue", baseSize: 23.0)
		label.text = "How are you feeling right now?"
		label.setTranslatesAutoresizingMaskIntoConstraints(false)
		label.textColor = UIColor(r: 191, g: 234, b: 248)
		label.lineBreakMode = .ByTruncatingTail
		label.numberOfLines = 0
		label.textAlignment = .Center
		
		label.layer.shadowOffset = CGSize(width: 0, height: 2)
		label.layer.shadowRadius = 3
		label.layer.shadowColor = UIColor.blackColor().CGColor
		label.layer.shadowOpacity = 0.075
		label.layer.shouldRasterize = true
		label.layer.rasterizationScale = UIScreen.mainScreen().scale
		
		return label
	}()
	
	private(set) lazy var subheaderLabel: UILabel = {
		let label = SSDynamicLabel(font: "HelveticaNeue", baseSize: 17.0)
		label.text = ""
		label.setTranslatesAutoresizingMaskIntoConstraints(false)
		label.textColor = UIColor(r: 191, g: 234, b: 248, a: 0.8)
		label.lineBreakMode = .ByTruncatingTail
		label.numberOfLines = 0
		label.textAlignment = .Center
		
		label.layer.shadowOffset = CGSize(width: 0, height: 2)
		label.layer.shadowRadius = 3
		label.layer.shadowColor = UIColor.blackColor().CGColor
		label.layer.shadowOpacity = 0.075
		label.layer.shouldRasterize = true
		label.layer.rasterizationScale = UIScreen.mainScreen().scale
		
		return label
	}()
	
	private(set) lazy var 😊Button: UIButton = {
		let button = ChunkyButton()
		button.setTranslatesAutoresizingMaskIntoConstraints(false)
		button.setTitle("😊", forState: .Normal)
		button.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 26)
		
		button.addTarget(self, action: "didTapMoodButton:", forControlEvents: .TouchUpInside)
		
		return button
	}()
	
	private(set) lazy var 😐Button: UIButton = {
		let button = ChunkyButton()
		button.setTranslatesAutoresizingMaskIntoConstraints(false)
		button.setTitle("😐", forState: .Normal)
		button.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 26)
		
		button.addTarget(self, action: "didTapMoodButton:", forControlEvents: .TouchUpInside)
		
		return button
	}()
	
	private(set) lazy var 😖Button: UIButton = {
		let button = ChunkyButton()
		button.setTranslatesAutoresizingMaskIntoConstraints(false)
		button.setTitle("😖", forState: .Normal)
		button.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 26)
		
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
	
	override func preferredStatusBarStyle() -> UIStatusBarStyle {
		return .LightContent
	}
	
	convenience override init() {
		self.init(nibName: nil, bundle: nil)
		
		title = "Relax"
		tabBarItem.image = UIImage(named: "Relax")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupFullScreenView(self)
		
		view.addSubview(spacerViews[0])
		view.addSubview(headlineLabel)
		// view.addSubview(subheaderLabel)
		view.addSubview(😊Button)
		view.addSubview(😐Button)
		view.addSubview(😖Button)
		view.addSubview(spacerViews[1])
		
		view.setNeedsUpdateConstraints() // bootstrap AutoLayout
	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		
		updateFullScreenColors(self, animated: false)
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
			
			let headerSpacing: CGFloat = 52, margin: CGFloat = 26
			let metrics = [
				"headerSpacing": headerSpacing,
				"margin": margin
			]
			
			view.addConstraint(NSLayoutConstraint(item: spacerViews[0], attribute: .Top, relatedBy: .Equal, toItem: topLayoutGuide, attribute: .Bottom, multiplier: 1, constant: 0))
			view.addConstraint(NSLayoutConstraint(item: spacerViews[1], attribute: .Bottom, relatedBy: .Equal, toItem: bottomLayoutGuide, attribute: .Top, multiplier: 1, constant: 0))
			view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[spacer1(>=0)]-[headlineLabel]-(headerSpacing)-[happyButton(70)]-(margin)-[neutralButton(==happyButton)]-(margin)-[flusteredButton(==happyButton)]-[spacer2(==spacer1)]", options: nil, metrics: metrics, views: views))
			view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[spacer1(0,==spacer2)]", options: nil, metrics: metrics, views: views))
			view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(margin)-[headlineLabel]-(margin)-|", options: nil, metrics: metrics, views: views))
			view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[happyButton(70,==neutralButton,==flusteredButton)]", options: nil, metrics: metrics, views: views))
			for (_, subview) in views {
				view.addConstraint(NSLayoutConstraint(item: subview, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0))
			}
			
			didSetupConstraints = true
		}
		
		super.updateViewConstraints()
	}
	
	// MARK: Handlers
	
	func didTapMoodButton(button: UIButton!) {
		let mood = Character(button.titleForState(.Normal)!)
		let relaxationLaunchController = RelaxationLaunchController(mood: Mood(rawValue: mood)!)
		relaxationLaunchController.delegate = self
		let navigationController = UINavigationController(rootViewController: relaxationLaunchController)
		
		presentViewController(navigationController, animated: true, completion: nil)
	}
	
	// MARK: RelaxationControllerDelegate
	
	func relaxationControllerShouldDismiss(relaxationController: UIViewController) {
		dismissViewControllerAnimated(true, completion: nil)
	}
	
}
