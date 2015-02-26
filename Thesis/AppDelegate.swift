//
//  AppDelegate.swift
//  Thesis
//
//  Created by Maxwell Barvian on 1/10/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit
import SDCloudUserDefaults
import Realm

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	var window: UIWindow!
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        SDCloudUserDefaults.registerForNotifications()
		applyStylesheet()
		
		if let launchOptions = launchOptions {
			if let localNotification = launchOptions[UIApplicationLaunchOptionsLocalNotificationKey] as? UILocalNotification {
				if localNotification == UIApplication.relaxationReminder {
					UIApplication.rootViewController.selectedIndex = RootViewControllerRelaxTabIndex
				} else if localNotification == UIApplication.reflectionReminder {
					UIApplication.rootViewController.selectedIndex = RootViewControllerReflectTabIndex
				}
			}
		}
		
        return true
    }
	
	func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
		UIApplication.didRegisterForNotifications(notificationSettings)
	}
	
	func applyStylesheet() {
		// UIPageControl
		let pageView = UIPageControl.bridge_appearanceWhenContainedIn(OnboardingViewController.self)
		pageView.backgroundColor = UIColor.clearColor()
		pageView.pageIndicatorTintColor = UIColor(r: 200, g: 200, b: 200)
		pageView.currentPageIndicatorTintColor = UIColor.blackColor()
	}
    
}

