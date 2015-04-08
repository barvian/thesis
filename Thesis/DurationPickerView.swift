//
//  DurationPickerView.swift
//  Thesis
//
//  Created by Maxwell Barvian on 2/24/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit
import SSDynamicText

@objc protocol DurationPickerViewDelegate {
	optional func durationPickerView(durationPickerView: DurationPickerView, didPickDuration duration: Duration)
}

class DurationPickerView: UIView {
	
	weak var delegate: DurationPickerViewDelegate?
	
	private(set) lazy var headlineLabel: UILabel = {
		let label = UILabel.applicationHeaderLabel()
		label.text = "How long would you like your relaxation session to be?"
		label.setTranslatesAutoresizingMaskIntoConstraints(false)
		label.textColor = UIColor(r: 191, g: 234, b: 248)
		
		return label
	}()
	
	private(set) lazy var durationButtons: [Duration: UIButton] = {
		var buttons = [Duration: UIButton]()
		
		for duration in Duration.allValues {
			let button = ChunkyButton()
			button.round = true
			button.setTranslatesAutoresizingMaskIntoConstraints(false)
			button.setTitle(duration.description, forState: .Normal)
			button.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 13)
			button.setTitleColor(UIColor(r: 255, g: 255, b: 255, a: 0.8), forState: .Normal)
			button.tag = duration.rawValue
			
			let image = UIImage(named: "\(duration.description)Timer")?.imageWithRenderingMode(.AlwaysTemplate)
			button.setImage(image, forState: .Normal)
			
			button.addTarget(self, action: "didTapDurationButton:", forControlEvents: .TouchUpInside)
			
			buttons[duration] = button
		}
		
		return buttons
	}()
	
	// MARK: Initializers
	
	convenience init() {
		self.init(frame: CGRectZero)
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		addSubview(headlineLabel)
		for (duration, button) in durationButtons {
			addSubview(button)
		}
	}
	
	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	// MARK: Constraints
	
	override class func requiresConstraintBasedLayout() -> Bool {
		return true
	}
	
	private var _didSetupConstraints = false
	
	override func updateConstraints() {
		if !_didSetupConstraints {
			let views: [NSObject: AnyObject] = [
				"headlineLabel": headlineLabel,
				"shortButton": durationButtons[.Short]!,
				"moderateButton": durationButtons[.Moderate]!,
				"longButton": durationButtons[.Long]!
			]
			
			let vMargin: CGFloat = 34, hMargin: CGFloat = 26, buttonSize: CGFloat = 80
			let metrics = [
				"vMargin": vMargin,
				"hMargin": hMargin,
				"buttonSize": buttonSize
			]
			
			for (_, button) in durationButtons {
				let imageSize = button.imageView!.frame.size
				let titleSize = button.titleLabel!.text!.sizeWithAttributes([NSFontAttributeName: button.titleLabel!.font])
				
				button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
				button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageSize.width, bottom: -(buttonSize + titleSize.height + 20), right: 0)
			}
			
			addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[headlineLabel]-(vMargin)-[moderateButton(buttonSize,==shortButton,==longButton)]|", options: nil, metrics: metrics, views: views))
			addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(hMargin)-[headlineLabel]-(hMargin)-|", options: nil, metrics: metrics, views: views))
			addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[shortButton]-(hMargin)-[moderateButton(buttonSize,==shortButton,==longButton)]-(hMargin)-[longButton]", options: nil, metrics: metrics, views: views))
			addConstraint(NSLayoutConstraint(item: durationButtons[.Moderate]!, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: 0))
			for (duration, button) in filter(durationButtons, { (key, value) in key != .Moderate }) {
				addConstraint(NSLayoutConstraint(item: button, attribute: .CenterY, relatedBy: .Equal, toItem: durationButtons[.Moderate]!, attribute: .CenterY, multiplier: 1, constant: 0))
			}
			
			_didSetupConstraints = true
		}
		
		super.updateConstraints()
	}
	
	// MARK: Handlers
	
	func didTapDurationButton(button: UIButton!) {
		delegate?.durationPickerView?(self, didPickDuration: Duration(rawValue: button.tag)!)
	}
	
}