//
//  UIView+Animations.swift
//  Thesis
//
//  Created by Maxwell Barvian on 2/28/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit

private var _floatAnimations = [UIView: Bool]()

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
	
	func toggleApplicationFloatAnimation(_ state: Bool? = nil) {
		if let state = state {
			_floatAnimations[self] = state
		}
		if _floatAnimations[self] != nil && _floatAnimations[self]! {
			UIView.animateWithDuration(2.0, delay: 0, options: .CurveEaseInOut | .AllowUserInteraction, animations: {
				let dx = CGFloat(Int(arc4random()) % 10 - 5)
				let dy = CGFloat(Int(arc4random()) % 10 - 5)
				self.transform = CGAffineTransformMakeTranslation(dx, dy)
				}) { _ in
					self.toggleApplicationFloatAnimation()
			}
		}
		
	}
	
}
