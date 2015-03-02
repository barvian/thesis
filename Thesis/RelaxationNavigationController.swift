//
//  RelaxationNavigationController.swift
//  Thesis
//
//  Created by Maxwell Barvian on 3/2/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit

@objc protocol RelaxationNavigationControllerDelegate {
	optional func relaxationNavigationControllerShouldDismiss(relaxationNavigationController: RelaxationNavigationController)
}

class RelaxationNavigationController: UIViewController, RelaxationViewControllerDelegate {
	
	weak var delegate: RelaxationNavigationControllerDelegate?
	
	let coordinator: RelaxationCoordinator
	
	private lazy var _navigationController: UINavigationController = {
		let statements = DeepBreathingViewController()
		statements.relaxationDelegate = self
		let controller = UINavigationController(rootViewController: statements)
		
		return controller
	}()
	override var navigationController: UINavigationController {
		return _navigationController
	}
	
	override func childViewControllerForStatusBarHidden() -> UIViewController? {
		return navigationController
	}
	
	override func childViewControllerForStatusBarStyle() -> UIViewController? {
		return navigationController
	}
	
	init(mood: Mood, duration: Duration) {
		self.coordinator = RelaxationCoordinator(mood: mood, duration: duration)
		
		super.init(nibName: nil, bundle: nil)
	}

	required init(coder aDecoder: NSCoder) {
	    fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		addChildViewController(navigationController)
		view.addSubview(navigationController.view)
		navigationController.didMoveToParentViewController(self)
	}
	
	// MARK: RelaxationViewControllerDelegate
	
	func relaxationControllerDidTapProgressButton(relaxationController: UIViewController) {
		
	}
	
	func relaxationViewControllerNeedsTextForProgressButton(relaxationController: UIViewController) -> String {
		return "Next"
	}
	
}
