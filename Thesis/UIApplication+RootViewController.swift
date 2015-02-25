//
//  UIApplication+RootViewController.swift
//  Thesis
//
//  Created by Maxwell Barvian on 2/10/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit

extension UIApplication {
	
	class var appDelegate: AppDelegate {
		return UIApplication.sharedApplication().delegate as! AppDelegate
	}
	
	class var window: UIWindow {
		return appDelegate.window!
	}
	
	class var rootViewController: RootViewController {
		return window.rootViewController as! RootViewController
	}
	
}
