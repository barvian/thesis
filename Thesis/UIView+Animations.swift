//
//  UIView+Animations.swift
//  Thesis
//
//  Created by Maxwell Barvian on 2/28/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit

extension UIView {
	
	func animateWithApplicationShake(duration: NSTimeInterval, delay: NSTimeInterval, options: UIViewKeyframeAnimationOptions, completion: ((Bool) -> Void)?) {
		UIView.animateKeyframesWithDuration(duration, delay: delay, options: options, animations: {
			UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 0.2) {
				self.transform = CGAffineTransformMakeTranslation(-5, 0)
			}
			UIView.addKeyframeWithRelativeStartTime(0.2, relativeDuration: 0.2) {
				self.transform = CGAffineTransformMakeTranslation(5, 0)
			}
			UIView.addKeyframeWithRelativeStartTime(0.4, relativeDuration: 0.2) {
				self.transform = CGAffineTransformMakeTranslation(-5, 0)
			}
			UIView.addKeyframeWithRelativeStartTime(0.6, relativeDuration: 0.2) {
				self.transform = CGAffineTransformMakeTranslation(5, 0)
			}
			UIView.addKeyframeWithRelativeStartTime(0.8, relativeDuration: 0.2) {
				self.transform = CGAffineTransformMakeTranslation(0, 0)
			}
		}, completion: completion)
	}
	
}
