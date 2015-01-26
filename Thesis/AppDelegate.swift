//
//  AppDelegate.swift
//  Thesis
//
//  Created by Maxwell Barvian on 1/10/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    lazy var window: UIWindow = {
        let win = UIWindow(frame: UIScreen.mainScreen().bounds)
        win.backgroundColor = UIColor.whiteColor()
        
        let slidingTabController = SlidingTabController()
        slidingTabController.viewControllers = [
            UIViewController(),
            RelaxViewController(),
            UIViewController()
        ]
        slidingTabController.selectedIndex = 1
        win.rootViewController = slidingTabController
        
        return win
    }()
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        SDCloudUserDefaults.registerForNotifications()
        
        window.makeKeyAndVisible()
        return true
    }

}

