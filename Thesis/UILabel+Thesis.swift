//
//  UILabel+Thesis.swift
//  Thesis
//
//  Created by Maxwell Barvian on 3/1/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit
import SSDynamicText

extension UILabel {
	
	class func applicationHeaderLabel(shadow: Bool = true, thin: Bool = false) -> UILabel {
		let label = SSDynamicLabel(font: thin ? "HelveticaNeue-Light" : "HelveticaNeue", baseSize: 23.0)
		label.numberOfLines = 0
		label.textAlignment = .Center
		
		if (shadow) {
			label.layer.shadowOffset = CGSize(width: 0, height: 3)
			label.layer.shadowRadius = 4
			label.layer.shadowColor = UIColor.blackColor().CGColor
			label.layer.shadowOpacity = 0.1
			label.layer.shouldRasterize = true
			label.layer.rasterizationScale = UIScreen.mainScreen().scale
		}
	
		return label
	}
	
	class func applicationSubheaderLabel(shadow: Bool = true) -> UILabel {
		let label = SSDynamicLabel(font: "HelveticaNeue", baseSize: 17.0)
		label.numberOfLines = 0
		label.textAlignment = .Center
		
		if (shadow) {
			label.layer.shadowOffset = CGSize(width: 0, height: 2)
			label.layer.shadowRadius = 3
			label.layer.shadowColor = UIColor.blackColor().CGColor
			label.layer.shadowOpacity = 0.075
			label.layer.shouldRasterize = true
			label.layer.rasterizationScale = UIScreen.mainScreen().scale
		}
		
		return label
	}
	
}
