//
//  FullScreenController.swift
//  Thesis
//
//  Created by Maxwell Barvian on 2/21/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit

private var _prevNavigationBarImageAssociationKey: UInt8 = 0
private var _prevNavigationBarShadowImageAssociationKey: UInt8 = 1
private var _prevNavigationBarTranslucentAssociationKey: UInt8 = 2

protocol FullScreenViewController {
	
	var tintColor: UIColor { get }
	var backgroundColor: UIColor { get }
	var tabColor: UIColor { get }
	var selectedTabColor: UIColor { get }
	
	var navigationBarHidden: Bool { get }
	var navigationBarTranslucent: Bool { get }
	
}

func setupFullScreenView(controller: FullScreenViewController) {
	let vc = controller as! UIViewController

	vc.view.backgroundColor = controller.backgroundColor
	if let tabBarController = vc.tabBarController where !vc.hidesBottomBarWhenPushed {
		vc.edgesForExtendedLayout = .All;
		(vc.view as? UIScrollView)?.contentInset = UIEdgeInsetsMake(0.0, 0.0, tabBarController.tabBar.frame.height + 20, 0.0);
	}
}

func updateFullScreenColors(controller: FullScreenViewController, animated: Bool = true) {
	let vc = controller as! UIViewController
	
	UIView.animateWithDuration(animated ? 0.3 : 0) {
		vc.view.tintColor = controller.tintColor
		if let navigationController = vc.navigationController {
			navigationController.navigationBar.tintColor = controller.tintColor
		}
		UIApplication.statusBarCover.tintColor = controller.backgroundColor
		
		if !vc.hidesBottomBarWhenPushed {
			vc.tabBarController?.tabBar.unselectedColor = controller.tabColor
			vc.tabBarController?.tabBar.selectedColor = controller.selectedTabColor
			(vc.tabBarController?.tabBar as? FloatingTabBar)?.color = controller.backgroundColor
		}
	}
}

func hideFullScreenNavigationBar(controller: FullScreenViewController, animated: Bool = false) {
	let vc = controller as! UIViewController
	vc.navigationController?.setNavigationBarHidden(controller.navigationBarHidden, animated: animated)
	
	if !controller.navigationBarHidden && controller.navigationBarTranslucent {
		objc_setAssociatedObject(vc, &_prevNavigationBarImageAssociationKey, vc.navigationController?.navigationBar.backgroundImageForBarMetrics(.Default), objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN))
		objc_setAssociatedObject(vc, &_prevNavigationBarShadowImageAssociationKey, vc.navigationController?.navigationBar.shadowImage, objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN))
		objc_setAssociatedObject(vc, &_prevNavigationBarTranslucentAssociationKey, vc.navigationController?.navigationBar.translucent, objc_AssociationPolicy(OBJC_ASSOCIATION_ASSIGN))
		
		vc.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "NavigationBarBlur")?.add_tintedImageWithColor(controller.backgroundColor, style: ADDImageTintStyleKeepingAlpha), forBarMetrics: .Default)
		vc.navigationController?.navigationBar.shadowImage = UIImage()
		vc.navigationController?.navigationBar.translucent = true
	}
}

func unhideFullScreenNavigationBar(controller: FullScreenViewController, animated: Bool = false) {
	let vc = controller as! UIViewController
	vc.navigationController?.setNavigationBarHidden(false, animated: animated)
	
	if !controller.navigationBarHidden && controller.navigationBarTranslucent {
		vc.navigationController?.navigationBar.setBackgroundImage(objc_getAssociatedObject(vc, &_prevNavigationBarImageAssociationKey) as? UIImage, forBarMetrics: .Default)
		vc.navigationController?.navigationBar.shadowImage = objc_getAssociatedObject(vc, &_prevNavigationBarShadowImageAssociationKey) as? UIImage
		vc.navigationController?.navigationBar.translucent = objc_getAssociatedObject(vc, &_prevNavigationBarTranslucentAssociationKey) as! Bool
	}
}
