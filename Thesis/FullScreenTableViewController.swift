//
//  FullScreenTableViewController.swift
//  Thesis
//
//  Created by Maxwell Barvian on 2/10/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit

class FullScreenTableViewController: UITableViewController {
    
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
        
        tableView.backgroundColor = backgroundColor
        
        if let headerView = tableView.tableHeaderView {
            headerView.setNeedsLayout()
            headerView.layoutIfNeeded()
            let height = headerView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height
            
            // Update the header's frame and add it again
            var headerFrame = headerView.frame
            headerFrame.size.height = height
            headerView.frame = headerFrame
            tableView.tableHeaderView = headerView
        }
        
        if tabBarController != nil {
            self.edgesForExtendedLayout = .All;
            self.tableView.contentInset = UIEdgeInsetsMake(0.0, 0.0, self.tabBarController!.tabBar.frame.height + 20, 0.0);
        }
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
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
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