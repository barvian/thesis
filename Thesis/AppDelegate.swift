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
	
	private var _notificationCompletionBlock: ((UIUserNotificationSettings) -> ())?
	
	func registerForNotifications(completion: (UIUserNotificationSettings) -> ()) {
		let settings = UIUserNotificationSettings(forTypes:
			UIUserNotificationType.Badge | UIUserNotificationType.Sound | UIUserNotificationType.Alert,
			categories: nil)
		UIApplication.sharedApplication().registerUserNotificationSettings(settings)
		
		_notificationCompletionBlock = completion
	}
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        SDCloudUserDefaults.registerForNotifications()
				
		applyStylesheet()
        
        return true
    }
	
	func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
		_notificationCompletionBlock?(notificationSettings)
	}
	
	func applyStylesheet() {
		// UIPageControl
		let pageView = UIPageControl.bridge_appearanceWhenContainedIn(OnboardingViewController.self)
		pageView.backgroundColor = UIColor.clearColor()
		pageView.pageIndicatorTintColor = UIColor(r: 200, g: 200, b: 200)
		pageView.currentPageIndicatorTintColor = UIColor.blackColor()
	}
    
}

