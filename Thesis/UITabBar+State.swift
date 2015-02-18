//
//  FloatingTabBarItem.swift
//  Thesis
//
//  Created by Maxwell Barvian on 2/10/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit

extension UITabBarItem {
	
	var unselectedColor: UIColor {
		get {
			let attributes = titleTextAttributesForState(.Normal)
			return attributes[NSForegroundColorAttributeName] as! UIColor
		}
		set(newValue) {
			setTitleTextAttributes([NSForegroundColorAttributeName: newValue], forState: .Normal)
			image = image?.add_tintedImageWithColor(newValue, style: ADDImageTintStyleKeepingAlpha).imageWithRenderingMode(.AlwaysOriginal)
		}
	}
	
	var selectedColor: UIColor {
		get {
			let attributes = titleTextAttributesForState(.Selected)
			return attributes[NSForegroundColorAttributeName] as! UIColor
		}
		set(newValue) {
			setTitleTextAttributes([NSForegroundColorAttributeName: newValue], forState: .Selected)
			selectedImage = image?.add_tintedImageWithColor(newValue, style: ADDImageTintStyleKeepingAlpha).imageWithRenderingMode(.AlwaysOriginal)
		}
	}
	
}

extension UITabBar {
	
	var unselectedColor: UIColor? {
		get {
			if items?.count > 0 {
				return items?[0].titleTextAttributesForState(.Normal)[NSForegroundColorAttributeName] as? UIColor
			}
			
			return nil
		}
		set(newValue) {
			if let tabs = items as? [UITabBarItem] {
				for tab in tabs {
					tab.unselectedColor = newValue!
				}
			}
		}
	}
	
	var selectedColor: UIColor? {
		get {
			return tintColor
		}
		set(newValue) {
			tintColor = newValue
			if let items = items as? [UITabBarItem] {
				for tab in items {
					tab.selectedColor = newValue!
				}
			}
		}
	}
	
}
