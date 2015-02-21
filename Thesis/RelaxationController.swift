//
//  RelaxationController.swift
//  Thesis
//
//  Created by Maxwell Barvian on 2/12/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit

@objc protocol RelaxationControllerDelegate {
	optional func relaxationControllerShouldDismiss(relaxationController: UIViewController)
}

protocol RelaxationController: FullScreenViewController {
	
	// var relaxationDelegate: RelaxationControllerDelegate?
	
}
