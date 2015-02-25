//
//  UIImage+Thesis.swift
//  Thesis
//
//  Created by WSOL Intern on 2/25/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit

extension UIImageView {
	
	class func applicationStatusBarCover() -> UIImageView {
		let image = UIImage(named: "StatusBarBlur")?.imageWithRenderingMode(.AlwaysTemplate)
		let cover = UIImageView(image: image)
		let statusBarFrame = UIApplication.sharedApplication().statusBarFrame
		cover.frame = CGRectMake(0, 0, statusBarFrame.width, statusBarFrame.height * 2)
		cover.contentMode = .ScaleToFill
		cover.userInteractionEnabled = false
		
		return cover
	}
	
}