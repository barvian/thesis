//
//  RelaxationViewController.swift
//  Thesis
//
//  Created by Maxwell Barvian on 2/12/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit

@objc protocol RelaxationViewControllerDelegate {
	func relaxationViewControllerNeedsTextForProgressButton(relaxationController: UIViewController) -> String
	optional func relaxationViewControllerDidTapProgressButton(relaxationController: UIViewController)
}

protocol RelaxationViewController {
	
	weak var relaxationDelegate: RelaxationViewControllerDelegate? { get set }
	
	func shouldUpdateProgressButton()
	
}

func relaxationViewController(controller: RelaxationViewController, shouldUpdateProgressButton progressButton: UIButton) {
	if let delegate = controller.relaxationDelegate {
		progressButton.setTitle(delegate.relaxationViewControllerNeedsTextForProgressButton(controller as! UIViewController), forState: .Normal)
	}
}