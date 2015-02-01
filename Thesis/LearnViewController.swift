//
//  LearnViewController.swift
//  Thesis
//
//  Created by Maxwell Barvian on 2/1/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit

class LearnViewController: UITableViewController {
    
    private(set) lazy var 📖: NSArray = {
        let path = NSBundle.mainBundle().pathForResource("Readings", ofType: "plist")!
        let data = NSArray(contentsOfFile: path)!
        println(data)
        
        return data
    }()
    
    convenience override init() {
        self.init(style: .Plain)
        
        title = "Learn"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
        
        super.viewWillDisappear(animated)
    }
    
    // MARK: UITableViewDataSource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 📖.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        let reading = 📖[indexPath.row] as NSDictionary
        
        cell.textLabel.text = reading["Title"] as? String
        
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
