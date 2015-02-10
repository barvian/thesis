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
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        SDCloudUserDefaults.registerForNotifications()
        
        window.rootViewController?.view.addSubview(statusBarCover)
        
        if !SDCloudUserDefaults.hasSeenWelcome {
            let welcomeController = OnboardingViewController()
            window.rootViewController?.presentViewController(welcomeController, animated: true, completion: {
                SDCloudUserDefaults.hasSeenWelcome = true
            })
        }
        
        return true
    }
    
}

