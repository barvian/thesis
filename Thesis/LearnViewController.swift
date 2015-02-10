//
//  LearnViewController.swift
//  Thesis
//
//  Created by Maxwell Barvian on 2/1/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit

class LearnViewController: FullScreenTableViewController, LearnHeaderViewDelegate {
    
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
        tintColor = UIColor.applicationBaseColor()
        backgroundColor = UIColor.applicationLightColor()
        tabColor = UIColor(r: 178, g: 186, b: 196)
        selectedTabColor = UIColor.applicationBaseColor()
    }
    
    override func viewDidLoad() {
        tableView.tableHeaderView = headerView
        
        super.viewDidLoad()
        
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
