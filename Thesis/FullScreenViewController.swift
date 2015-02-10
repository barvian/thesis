//
//  FullScreenViewController.swift
//  Thesis
//
//  Created by Maxwell Barvian on 2/10/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit

class FullScreenViewController: UIViewController {
    
    var tintColor = UIColor.clearColor()
    var backgroundColor = UIColor.clearColor()
    var tabColor = UIColor.clearColor()
    var selectedTabColor = UIColor.clearColor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = backgroundColor
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        UIApplication.window.tintColor = tintColor
        UIApplication.statusBarCover.hidden = false
        UIApplication.statusBarCover.tintColor = backgroundColor
        tabBarController?.tabBar.unselectedColor = tabColor
        tabBarController?.tabBar.selectedColor = selectedTabColor
        (tabBarController?.tabBar as? FloatingTabBar)?.color = backgroundColor
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
}