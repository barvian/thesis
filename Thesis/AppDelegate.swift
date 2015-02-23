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
	
    private(set) lazy var statusBarCover: UIImageView = {
        let image = UIImage(named: "StatusBarBlur")?.imageWithRenderingMode(.AlwaysTemplate)
        let cover = UIImageView(image: image)
        let statusBarFrame = UIApplication.sharedApplication().statusBarFrame
        cover.frame = CGRectMake(0, 0, statusBarFrame.width, statusBarFrame.height * 2)
        cover.contentMode = .ScaleToFill
        cover.userInteractionEnabled = false
        
        return cover
    }()
	
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
        window.rootViewController?.view.addSubview(statusBarCover)
        
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

