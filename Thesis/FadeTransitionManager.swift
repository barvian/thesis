//
//  FadeTransitionManager.swift
//  Thesis
//
//  Created by Maxwell Barvian on 2/24/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit

class FadeTransitionManager: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
	
	private var _presenting = false
	
	// MARK: UIViewControllerAnimatedTransitioning
	
	func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
		let container = transitionContext.containerView()
		container.backgroundColor = UIColor.blackColor()
		
		let screens = (from: transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!, to: transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!)
		let fromView = screens.from.view, toView = screens.to.view
		
		container.addSubview(fromView)
		container.addSubview(toView)
		
		// Fade
		fromView.alpha = 1
		toView.alpha = 0
		UIView.animateKeyframesWithDuration(transitionDuration(transitionContext), delay: 0, options: nil, animations: {
			UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 0.33) {
				fromView.alpha = 0
			}
			UIView.addKeyframeWithRelativeStartTime(0.66, relativeDuration: 0.33) {
				toView.alpha = 1
			}
		}) {
			finished in
			
			transitionContext.completeTransition(true)
			
			// bug: we have to manually add our 'to view' back http://openradar.appspot.com/radar?id=5320103646199808
			UIApplication.window.addSubview(toView)
		}
	}
	
	func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
		return 1
	}
	
	// MARK: UIViewControllerTransitioningDelegate
	
	func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		_presenting = true
		return self
	}
	
	func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		_presenting = false
		return self
	}
	
}
