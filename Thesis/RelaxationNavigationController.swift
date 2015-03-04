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

private func instantiateRelaxationController(controllerType: AnyClass, delegate: RelaxationViewControllerDelegate? = nil) -> UIViewController {
	var controller = (controllerType as! NSObject.Type)() as! RelaxationViewController
	controller.relaxationDelegate = delegate
	
	return controller as! UIViewController
}

class RelaxationNavigationController: UIViewController, RelaxationViewControllerDelegate {
	
	weak var delegate: RelaxationNavigationControllerDelegate?
	
	let relaxations: RelaxationList
	var currentRelaxation: Int {
		didSet {
			let controller = instantiateRelaxationController(self.relaxations[self.currentRelaxation], delegate: self)
			self.navigationController.pushViewController(controller, animated: true)
		}
	}
	
	private lazy var _navigationController: UINavigationController = {
		let root = instantiateRelaxationController(self.relaxations[0], delegate: self)
		let controller = UINavigationController(rootViewController: root)
		
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
