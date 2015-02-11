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
    
    var navigationBarHidden = true
    var navigationBarTranslucent = false
    
    private var _prevNavigationBarImage: UIImage?
    private var _prevNavigationBarShadowImage: UIImage?
    private var _prevNavigationBarTranslucent: Bool? = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = backgroundColor
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        UIView.animateWithDuration(animated ? 0.3 : 0) {
            [unowned self] in
            UIApplication.window.tintColor = self.tintColor
            UIApplication.statusBarCover.hidden = false
            UIApplication.statusBarCover.tintColor = self.backgroundColor
            self.tabBarController?.tabBar.unselectedColor = self.tabColor
            self.tabBarController?.tabBar.selectedColor = self.selectedTabColor
            (self.tabBarController?.tabBar as? FloatingTabBar)?.color = self.backgroundColor
        }
        
        if (navigationBarTranslucent) {
            _prevNavigationBarImage = navigationController?.navigationBar.backgroundImageForBarMetrics(.Default)
            _prevNavigationBarShadowImage = navigationController?.navigationBar.shadowImage
            _prevNavigationBarTranslucent = navigationController?.navigationBar.translucent
            
            navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
            navigationController?.navigationBar.shadowImage = UIImage()
            navigationController?.navigationBar.translucent = true
        }
        
        if navigationBarHidden {
            navigationController?.setNavigationBarHidden(true, animated: animated)
        }
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        if (navigationBarTranslucent) {
            navigationController?.navigationBar.setBackgroundImage(_prevNavigationBarImage, forBarMetrics: .Default)
            navigationController?.navigationBar.shadowImage = _prevNavigationBarShadowImage
            navigationController?.navigationBar.translucent = _prevNavigationBarTranslucent!
        }
        
        if navigationBarHidden {
            navigationController?.setNavigationBarHidden(false, animated: animated)
        }
    }
    
}