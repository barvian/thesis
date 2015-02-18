//
//  UIColor+RGB.swift
//  Thesis
//
//  Created by Maxwell Barvian on 2/8/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit

extension UIColor {
	
	// MARK: Initializers
	
	convenience init(rgb: UInt, a: Float = 1.0) {
		self.init(r: Int((rgb & 0xFF0000) >> 16), g: Int((rgb & 0xFF00) >> 8), b: Int(rgb & 0xFF), a: a)
	}
	
	convenience init(r: Int, g: Int, b: Int, a: Float = 1.0) {
		self.init(red: CGFloat(r)/255, green: CGFloat(g)/255, blue: CGFloat(b)/255, alpha: CGFloat(a))
	}
	
	// MARK: Helpers
	
	func lighterColor(percent : Double) -> UIColor {
		return colorWithBrightnessFactor(CGFloat(1 + percent));
	}
	
	func darkerColor(percent : Double) -> UIColor {
		return colorWithBrightnessFactor(CGFloat(1 - percent));
	}
	
	func colorWithBrightnessFactor(factor: CGFloat) -> UIColor {
		var hue : CGFloat = 0
		var saturation : CGFloat = 0
		var brightness : CGFloat = 0
		var alpha : CGFloat = 0
		
		if getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
			return UIColor(hue: hue, saturation: saturation, brightness: brightness * factor, alpha: alpha)
		} else {
			return self;
		}
	}
	
}