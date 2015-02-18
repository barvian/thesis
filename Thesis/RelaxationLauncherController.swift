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
	
	let mood: Mood
	weak var delegate: RelaxationControllerDelegate?
	
	private(set) lazy var moodLabel: UILabel = {
		let label = UILabel()
		label.setTranslatesAutoresizingMaskIntoConstraints(false)
		label.font = UIFont(name: "HelveticaNeue", size: 34.0)
		label.text = String(self.mood.rawValue)
		label.lineBreakMode = .ByTruncatingTail
		label.numberOfLines = 0
		label.textAlignment = .Center
		
		return label
	}()
	
	private(set) lazy var subheaderLabel: UILabel = {
		let label = SSDynamicLabel(font: "HelveticaNeue", baseSize: 23.0)
		label.setTranslatesAutoresizingMaskIntoConstraints(false)
		label.text = "Relaxation Excercise"
		label.textColor = UIColor.applicationBaseColor()
		label.lineBreakMode = .ByTruncatingTail
		label.numberOfLines = 0
		label.textAlignment = .Center
		
		return label
	}()
	
	private(set) lazy var timeLabel: UILabel = {
		let label = SSDynamicLabel(font: "HelveticaNeue-Light", baseSize: 21.0)
		label.setTranslatesAutoresizingMaskIntoConstraints(false)
		label.text = "Choose a session duration:"
		label.textColor = UIColor(r: 149, g: 160, b: 176)
		label.lineBreakMode = .ByTruncatingTail
		label.numberOfLines = 0
		label.textAlignment = .Center
		
		return label
	}()
	
	private(set) lazy var timerButtons: [UIButton] = {
		return ["Short", "Medium", "Long"].map {
			let button = UIButton()
			button.setTranslatesAutoresizingMaskIntoConstraints(false)
			button.setTitle($0, forState: .Normal)
			button.setTitleColor(UIColor(r: 149, g: 160, b: 176), forState: .Normal)
			button.setTitleColor(UIColor.applicationBaseColor(), forState: .Highlighted)
			button.setTitleColor(UIColor.whiteColor(), forState: .Selected)
			
			let image = UIImage(named: "Timer")
			button.setImage(image?.add_tintedImageWithColor(UIColor(r: 149, g: 160, b: 176), style: ADDImageTintStyleKeepingAlpha), forState: .Normal)
			button.setImage(image?.add_tintedImageWithColor(UIColor.applicationBaseColor(), style: ADDImageTintStyleKeepingAlpha), forState: .Highlighted)
			button.setImage(image?.add_tintedImageWithColor(UIColor.whiteColor(), style: ADDImageTintStyleKeepingAlpha), forState: .Selected)
			
			button.setBackgroundImage(UIImage.add_resizableImageWithColor(UIColor.clearColor()), forState: .Normal)
			button.setBackgroundImage(UIImage.add_resizableImageWithColor(UIColor.applicationBlueColor(), cornerRadius: 5.0), forState: .Selected)
			
			button.addTarget(self, action: "didTapTimerOption:", forControlEvents: .TouchUpInside)
			
			return button
		}
	}()
	
	private(set) lazy var beginButton: UIButton = {
		let button = UIButton.buttonWithType(.System) as! UIButton
		button.setTranslatesAutoresizingMaskIntoConstraints(false)
		button.setTitle("Begin", forState: .Normal)
		
		button.addTarget(self, action: "didTapBeginButton:", forControlEvents: .TouchUpInside)
		
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
	
	init(mood: Mood) {
		self.mood = mood
		
		super.init(nibName: nil, bundle: nil)
		
		tintColor = UIColor.applicationBlueColor()
		backgroundColor = UIColor.whiteColor()
		navigationBarHidden = true
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		navigationController?.interactivePopGestureRecognizer.enabled = false
		
		view.addSubview(moodLabel)
		view.addSubview(subheaderLabel)
		view.addSubview(spacerViews[0])
		view.addSubview(timeLabel)
		view.addSubview(timerButtons[0])
		view.addSubview(timerButtons[1])
		view.addSubview(timerButtons[2])
		view.addSubview(spacerViews[1])
		view.addSubview(beginButton)
		
		timerButtons[1].selected = true
		
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
				"timeLabel": timeLabel,
				"timer1": timerButtons[0],
				"timer2": timerButtons[1],
				"timer3": timerButtons[2],
				"spacer2": spacerViews[1],
				"beginButton": beginButton
			]
			let metrics = [
				"vMargin": 34,
				"hMargin": 26
			]
			
			for button in timerButtons {
				button.centerVertically(padding: 10)
			}
			
			view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-(vMargin)-[moodLabel]-[subheaderLabel][spacer1(>=0)][timeLabel]-(vMargin)-[timer2(100,==timer1,==timer3)][spacer2(==spacer1)]-[beginButton]-(vMargin)-|", options: nil, metrics: metrics, views: views))
			view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[spacer1(0,==spacer2)]", options: nil, metrics: metrics, views: views))
			view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(hMargin)-[moodLabel]-(hMargin)-|", options: nil, metrics: metrics, views: views))
			view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(hMargin)-[subheaderLabel]-(hMargin)-|", options: nil, metrics: metrics, views: views))
			view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(hMargin)-[timeLabel]-(hMargin)-|", options: nil, metrics: metrics, views: views))
			view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[timer1(==timer2)]-[timer2(100)]-[timer3(==timer2)]", options: nil, metrics: metrics, views: views))
			for (name, subview) in views {
				if name.rangeOfString("timer") == nil {
					view.addConstraint(NSLayoutConstraint(item: subview, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0))
				}
			}
			view.addConstraint(NSLayoutConstraint(item: timerButtons[1], attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0))
			view.addConstraint(NSLayoutConstraint(item: timerButtons[0], attribute: .CenterY, relatedBy: .Equal, toItem: timerButtons[1], attribute: .CenterY, multiplier: 1, constant: 0))
			view.addConstraint(NSLayoutConstraint(item: timerButtons[2], attribute: .CenterY, relatedBy: .Equal, toItem: timerButtons[1], attribute: .CenterY, multiplier: 1, constant: 0))
			
			didSetupConstraints = true
		}
		
		super.updateViewConstraints()
	}
	
	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
		
		
	}
	
	// MARK: Handlers
	
	func didTapTimerOption(button: UIButton!) {
		for timer in timerButtons {
			timer.selected = timer == button
		}
	}
	
	func didTapBeginButton(button: UIButton!) {
		let relaxationController = CalmingScenesViewController()
		relaxationController.relaxationDelegate = delegate
		relaxationController.navigationItem.hidesBackButton = true
		
		navigationController?.pushViewController(relaxationController, animated: true)
	}
	
}
