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
	
	let tintColor = UIColor.applicationBaseColor()
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
	
	convenience override init() {
		self.init(nibName: nil, bundle: nil)
		hidesBottomBarWhenPushed = true
	}
	
	override func viewDidLoad() {
		self.view = webView
		
		setupFullScreenView(self)
		
		view.setNeedsUpdateConstraints()
	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		
		updateFullScreenColors(self, animated: animated)
		hideFullScreenNavigationBar(self, animated: animated)
		navigationController?.hidesBarsOnSwipe = true
	}
	
	override func viewWillDisappear(animated: Bool) {
		super.viewWillDisappear(animated)
		
		navigationController?.hidesBarsOnSwipe = false
	}
	
	override func viewDidDisappear(animated: Bool) {
		super.viewDidDisappear(animated)
		
		unhideFullScreenNavigationBar(self, animated: animated)
	}
	
	// MARK: Constraints
	
	private var didSetupConstraints = false
	
	override func updateViewConstraints() {
		if !didSetupConstraints {
			didSetupConstraints = true
		}
		
		super.updateViewConstraints()
	}
	
}

