//
//  LearnViewController.swift
//  Thesis
//
//  Created by Maxwell Barvian on 2/1/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit

class LearnViewController: UITableViewController, LearnHeaderViewDelegate {
    
    private(set) lazy var 📖: NSArray = {
        let path = NSBundle.mainBundle().pathForResource("Readings", ofType: "plist")!
        let data = NSArray(contentsOfFile: path)!
        
        return data
    }()
    
    private(set) lazy var headerView: LearnHeaderView = {
        let header = LearnHeaderView()
        header.delegate = self
        
        return header
    }()
    
    convenience override init() {
        self.init(style: .Plain)
        
        title = "Learn"
        tabBarItem.image = UIImage(named: "Learn")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        UIApplication.sharedApplication().keyWindow?.tintColor = UIColor.applicationBaseColor()
        tabBarController?.tabBar.unselectedColor = UIColor(r: 149, g: 160, b: 176)
        tabBarController?.tabBar.selectedColor = UIColor.applicationBaseColor()
        (tabBarController?.tabBar as? FloatingTabBar)?.color = UIColor.applicationLightColor()
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func configureTableView() {
        tableView.backgroundColor = UIColor.applicationLightColor()
        
        if tabBarController != nil {
            self.edgesForExtendedLayout = .All;
            self.tableView.contentInset = UIEdgeInsetsMake(0.0, 0.0, self.tabBarController!.tabBar.frame.height + 10, 0.0);
        }
        
        tableView.tableHeaderView = headerView
        headerView.setNeedsLayout()
        headerView.layoutIfNeeded()
        let height = headerView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height
        
        // Update the header's frame and add it again
        var headerFrame = headerView.frame
        headerFrame.size.height = height
        headerView.frame = headerFrame
        tableView.tableHeaderView = headerView
        
        tableView.allowsSelection = true
        tableView.registerClass(ReadingTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorStyle = .None
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44.0
        
    }
    
    // MARK: UITableViewDataSource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 📖.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as ReadingTableViewCell
        let reading = 📖[indexPath.row] as NSDictionary
        
        cell.configureForReading(reading)
        
        return cell
    }
    
    // MARK: UITableViewDelegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let reading = 📖[indexPath.row] as NSDictionary
        let readingController = ReadingViewController()
        readingController.reading = reading
        
        navigationController?.pushViewController(readingController, animated: true)
    }
    
}
