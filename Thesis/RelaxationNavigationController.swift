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
	
	let relaxations: RelaxationList
	var currentRelaxation: Int {
		didSet {
			var controller = (self.relaxations[self.currentRelaxation] as! NSObject.Type)() as! RelaxationViewController
			controller.relaxationDelegate = self
			self.navigationController.pushViewController(controller as! UIViewController, animated: true)
		}
	}
	
	private lazy var _navigationController: UINavigationController = {
		var root = (self.relaxations[self.currentRelaxation] as! NSObject.Type)() as! RelaxationViewController
		root.relaxationDelegate = self
		let controller = UINavigationController(rootViewController: root as! UIViewController)
		
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
		self.relaxations = RelaxationList(mood: mood, duration: duration)
		self.currentRelaxation = relaxations.startIndex
		
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
	
	func relaxationViewControllerDidTapProgressButton(relaxationController: UIViewController) {
		if currentRelaxation < relaxations.endIndex {
			currentRelaxation++
		} else {
			delegate?.relaxationNavigationControllerShouldDismiss?(self)
		}
	}
	
	func relaxationViewControllerNeedsTextForProgressButton(relaxationController: UIViewController) -> String {
		return currentRelaxation < relaxations.endIndex ? "Next" : "Done"
	}
	
}
