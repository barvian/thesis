//
//  ReflectViewController.swift
//  Thesis
//
//  Created by Maxwell Barvian on 2/5/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit
import Realm

class ReflectViewController: UITableViewController, ReflectHeaderViewDelegate, AddReflectionViewControllerDelegate {
    
    var 📅: RLMResults {
        return Reflection.allObjects().sortedResultsUsingProperty("date", ascending: false)
    }
    
    private(set) lazy var headerView: ReflectHeaderView = {
        let header = ReflectHeaderView()
        header.delegate = self
        
        return header
    }()
    
    var notificationToken: RLMNotificationToken?
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    convenience override init() {
        self.init(style: .Plain)
        
        title = "Reflect"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        
        // Set realm notification block
        notificationToken = RLMRealm.defaultRealm().addNotificationBlock { note, realm in
            self.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func configureTableView() {
        UIApplication.sharedApplication().keyWindow?.tintColor = UIColor.applicationGreenColor()
        tableView.backgroundColor = UIColor.applicationGreenColor()
        
        tableView.tableHeaderView = headerView
        headerView.setNeedsLayout()
        headerView.layoutIfNeeded()
        let height = headerView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height
        
        // Update the header's frame and add it again
        var headerFrame = headerView.frame
        headerFrame.size.height = height
        headerView.frame = headerFrame
        tableView.tableHeaderView = headerView
        
        tableView.allowsSelection = false
        tableView.registerClass(ReflectTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorStyle = .None
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 64.0

    }
    
    // MARK: UITableViewDataSource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(📅.count)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as ReflectTableViewCell
        let index = UInt(indexPath.row)
        let reflection = 📅.objectAtIndex(index) as Reflection
        cell.configureForReflection(reflection)
        
        cell.setNeedsUpdateConstraints()
        cell.updateConstraintsIfNeeded()
        
        return cell
    }
    
    // MARK: UITableViewDelegate
    
    
    // MARK: ReflectHeaderViewDelegate
    
    func reflectHeaderView(reflectHeaderView: ReflectHeaderView, didTapAddButton addButton: UIButton!) {
        let addController = AddReflectionViewController()
        addController.delegate = self
        let navController = UINavigationController(rootViewController: addController)
        
        presentViewController(navController, animated: true, completion: nil)
    }
    
    // MARK: AddReflectionViewControllerDelegate
    
    func addReflectionViewController(addReflectionViewController: AddReflectionViewController, didFinishTyping typedText: String!) {
        if typedText?.utf16Count > 0 {
            let reflection = Reflection()
            reflection.event = typedText!
            reflection.reason = typedText!
            
            let realm = RLMRealm.defaultRealm()
            realm.transactionWithBlock() {
                realm.addObject(reflection)
            }
        }
    }
    
}
