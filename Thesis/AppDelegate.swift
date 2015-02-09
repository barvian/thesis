//
//  AppDelegate.swift
//  Thesis
//
//  Created by Maxwell Barvian on 1/10/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit
import SDCloudUserDefaults

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    lazy var window: UIWindow = {
        let win = UIWindow(frame: UIScreen.mainScreen().bounds)
        win.backgroundColor = UIColor.whiteColor()
        win.rootViewController = RootViewController()
        
        return win
    }()
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        SDCloudUserDefaults.registerForNotifications()
        
        window.makeKeyAndVisible()
        return true
    }
    
    func applyStylehsset() {
        // Page Control
        let pageControl = UIPageControl.appearance()
        pageControl.pageIndicatorTintColor = UIColor.lightGrayColor()
        pageControl.currentPageIndicatorTintColor = UIColor.blackColor()
        pageControl.backgroundColor = UIColor.whiteColor()
    }

}

