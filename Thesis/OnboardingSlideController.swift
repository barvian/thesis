//
//  OnboardingSlideController.swift
//  Thesis
//
//  Created by Maxwell Barvian on 3/1/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit

class OnboardingSlideController: UIViewController {
	
	weak var delegate: CalmingSceneViewControllerDelegate?
	
	private(set) lazy var scrollView: UIScrollView = {
		let scrollView = UIScrollView()
		scrollView.setTranslatesAutoresizingMaskIntoConstraints(false)
		
		return scrollView
	}()
	
	private(set) lazy var wrapperView: UIView = {
		let wrapperView = UIView()
		wrapperView.setTranslatesAutoresizingMaskIntoConstraints(false)
		
		return wrapperView
	}()
	
	private(set) lazy var spacerViews: [UIView] = {
		let spacers = [UIView(), UIView()]
		for spacer in spacers {
			spacer.setTranslatesAutoresizingMaskIntoConstraints(false)
			spacer.hidden = true
		}
		
		return spacers
	}()
	
	let contentView: OnboardingSlide
	
	init(contentView: OnboardingSlide) {
		self.contentView = contentView
		self.contentView.setTranslatesAutoresizingMaskIntoConstraints(false)
		
		super.init(nibName: nil, bundle: nil)
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		wrapperView.addSubview(spacerViews[0])
		wrapperView.addSubview(contentView)
		wrapperView.addSubview(spacerViews[1])
		
		scrollView.addSubview(wrapperView)
		view.addSubview(scrollView)
		
		view.setNeedsUpdateConstraints() // bootstrap AutoLayout
	}
	
	// MARK: Constraints
	
	private var _didSetupConstraints = false
	
	override func updateViewConstraints() {
		if !_didSetupConstraints {
			let views: [NSObject: AnyObject] = [
				"scrollView": scrollView,
				"wrapperView": wrapperView,
				"spacer1": spacerViews[0],
				"contentView": contentView,
				"spacer2": spacerViews[1]
			]
			let margin: CGFloat = 26
			let metrics = [
				"margin": margin,
				"vMargin": margin + 20
			]
			
			view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[scrollView]|", options: nil, metrics: metrics, views: views))
			view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[scrollView]|", options: nil, metrics: metrics, views: views))
			
			view.addConstraint(NSLayoutConstraint(item: wrapperView, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: 1, constant: 0))
			view.addConstraint(NSLayoutConstraint(item: wrapperView, attribute: .Height, relatedBy: .GreaterThanOrEqual, toItem: view, attribute: .Height, multiplier: 1, constant: 0))
			scrollView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[wrapperView]|", options: nil, metrics: metrics, views: views))
			scrollView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[wrapperView]|", options: nil, metrics: metrics, views: views))
			
			wrapperView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-(vMargin)-[spacer1(>=margin)][contentView][spacer2(==spacer1)]-(vMargin)-|", options: nil, metrics: metrics, views: views)) // FIXME: should not use static status bar height
			wrapperView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[contentView]|", options: nil, metrics: metrics, views: views))
			wrapperView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[spacer1(0,==spacer2)]", options: nil, metrics: metrics, views: views))
			for spacer in spacerViews {
				wrapperView.addConstraint(NSLayoutConstraint(item: spacer, attribute: .CenterX, relatedBy: .Equal, toItem: wrapperView, attribute: .CenterX, multiplier: 1, constant: 0))
			}
			
			_didSetupConstraints = true
		}
		
		super.updateViewConstraints()
	}
	
}