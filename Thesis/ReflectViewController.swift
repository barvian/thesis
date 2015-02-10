//
//  ReflectViewController.swift
//  Thesis
//
//  Created by Maxwell Barvian on 2/5/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit
import Realm

class ReflectViewController: FullScreenTableViewController, ReflectHeaderViewDelegate, AddReflectionViewControllerDelegate {
    
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
        tabBarItem.image = UIImage(named: "Reflect")
        tintColor = UIColor.applicationGreenColor()
        backgroundColor = UIColor.applicationGreenColor()
        tabColor = UIColor(r: 53, g: 120, b: 109)
        selectedTabColor = UIColor.whiteColor()
    }
    
    override func viewDidLoad() {
        tableView.tableHeaderView = headerView
        
        super.viewDidLoad()
        
        tableView.allowsSelection = false
        tableView.registerClass(ReflectTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorStyle = .None
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 64.0
        
        // Set realm notification block
        notificationToken = RLMRealm.defaultRealm().addNotificationBlock { note, realm in
            self.tableView.reloadData()
        }
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
    
    func addReflectionViewController(addReflectionViewController: AddReflectionViewController, didFinishTypingEvent eventText: String!, reason reasonText: String!) {
        if eventText?.utf16Count > 0 && reasonText?.utf16Count > 0 {
            let reflection = Reflection()
            reflection.event = eventText!
            reflection.reason = reasonText!
            
            let realm = RLMRealm.defaultRealm()
            realm.transactionWithBlock() {
                realm.addObject(reflection)
            }
            
            addReflectionViewController.view.endEditing(true)
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func addReflectionViewControllerShouldCancel(addReflectionViewController: AddReflectionViewController) {
        addReflectionViewController.view.endEditing(true)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
