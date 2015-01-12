//
//  AppDelegate.swift
//  Thesis
//
//  Created by Maxwell Barvian on 1/10/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit
import Async

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    lazy var window: UIWindow = {
        let win = UIWindow(frame: UIScreen.mainScreen().bounds)
        win.backgroundColor = UIColor.whiteColor()
        win.rootViewController = UINavigationController(rootViewController: RootViewController())
        return win
    }()
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        window.makeKeyAndVisible()
        return true
    }

}

