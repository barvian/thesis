//
//  ReadingViewController.swift
//  Thesis
//
//  Created by Maxwell Barvian on 2/1/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit
import WebKit

class ReadingViewController: UIViewController, FullScreenViewController {
	
	let tintColor = UIColor.blackColor()
	let backgroundColor = UIColor.whiteColor()
	let tabColor = UIColor(r: 178, g: 186, b: 196)
	let selectedTabColor = UIColor.applicationBaseColor()
	
	let navigationBarHidden = false
	let navigationBarTranslucent = true
	
	var reading: NSDictionary? {
		didSet {
			webView.configureForReading(reading)
		}
	}
	
	private(set) lazy var webView: UIWebView = {
		let webView = UIWebView()
		
		return webView
	}()
	
	override func prefersStatusBarHidden() -> Bool {
		return _shouldHideStatusBar
	}
	
	convenience override init() {
		self.init(nibName: nil, bundle: nil)
		
		hidesBottomBarWhenPushed = true
	}
	
	override func viewDidLoad() {
		self.view = webView
		
		setupFullScreenControllerView(self)
		
		view.setNeedsUpdateConstraints()
	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		
		updateFullScreenControllerColors(self, animated: animated)
		hideFullScreenControllerNavigationBar(self, animated: animated)
		navigationController?.hidesBarsOnSwipe = true
		navigationController?.barHideOnSwipeGestureRecognizer.addTarget(self, action: "didSwipe:")
	}
	
	override func viewWillDisappear(animated: Bool) {
		super.viewWillDisappear(animated)
		
		navigationController?.hidesBarsOnSwipe = false
		navigationController?.barHideOnSwipeGestureRecognizer.removeTarget(self, action: "didSwipe:")
	}
	
	override func viewDidDisappear(animated: Bool) {
		super.viewDidDisappear(animated)
		
		unhideFullScreenControllerNavigationBar(self, animated: animated)
	}
	
	// MARK: Constraints
	
	private var didSetupConstraints = false
	
	override func updateViewConstraints() {
		if !didSetupConstraints {
			setupFullScreenControllerViewConstraints(self)
			
			didSetupConstraints = true
		}
		
		super.updateViewConstraints()
	}
	
	// MARK: Handlers
	
	private var _shouldHideStatusBar = false
	
	func didSwipe(recognizer: UISwipeGestureRecognizer) {
		_shouldHideStatusBar = navigationController?.navigationBar.frame.origin.y < 0
		UIView.animateWithDuration(0.2) {
			fullScreenControllerStatusBarCover(self)?.hidden = self._shouldHideStatusBar
			self.setNeedsStatusBarAppearanceUpdate()
		}
	}
	
}

