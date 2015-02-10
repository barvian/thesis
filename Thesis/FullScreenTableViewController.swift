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
            self.tableView.contentInset = UIEdgeInsetsMake(0.0, 0.0, self.tabBarController!.tabBar.frame.height + 10, 0.0);
        }
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
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
}