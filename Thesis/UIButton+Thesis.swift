//
//  UIButton+Thesis.swift
//  Thesis
//
//  Created by Maxwell Barvian on 3/1/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit

public let UIButtonApplicationTextButtonPadding: CGFloat = 15

extension UIButton {
	
	class func applicationTextButton() -> UIButton {
		let button = UIButton.buttonWithType(.System) as! UIButton
		button.setTranslatesAutoresizingMaskIntoConstraints(false)
		button.contentEdgeInsets = UIEdgeInsets(top: UIButtonApplicationTextButtonPadding, left: UIButtonApplicationTextButtonPadding, bottom: UIButtonApplicationTextButtonPadding, right: UIButtonApplicationTextButtonPadding)
		
		return button
	}
	
	class func applicationBellButton() -> UIButton {
		let button = UIButton.buttonWithType(.System) as! UIButton
		let bell = UIImage(named: "Bell")?.imageWithRenderingMode(.AlwaysTemplate)
		button.setImage(bell, forState: .Normal)
		button.contentEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
		
		button.layer.shadowOffset = CGSize(width: 0, height: 2)
		button.layer.shadowRadius = 3
		button.layer.shadowColor = UIColor.blackColor().CGColor
		button.layer.shadowOpacity = 0.075
		
		return button
	}
	
}
