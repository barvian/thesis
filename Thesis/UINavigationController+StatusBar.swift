//
//  FullScreenNavigationController.swift
//  Thesis
//
//  Created by Maxwell Barvian on 2/26/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit

extension UINavigationController {
	
	public override func childViewControllerForStatusBarHidden() -> UIViewController? {
		return self.topViewController
	}
	
	public override func childViewControllerForStatusBarStyle() -> UIViewController? {
		return self.topViewController
	}
	
}
