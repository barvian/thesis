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
    
    convenience override init() {
        self.init(style: .Plain)
        
        title = "Reflect"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableHeaderView = headerView
        headerView.setNeedsLayout()
        headerView.layoutIfNeeded()
        let height = headerView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height
        
        // Update the header's frame and add it again
        var headerFrame = headerView.frame
        headerFrame.size.height = height
        headerView.frame = headerFrame
        tableView.tableHeaderView = headerView
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        tableView.reloadData()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: UITableViewDataSource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(📅.count)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        let index = UInt(indexPath.row)
        let reflection = 📅.objectAtIndex(index) as Reflection
        
        cell.textLabel.text = reflection.event
        
        return cell
    }
    
    // MARK: UITableViewDelegate
    
    
    // MARK: ReflectHeaderViewDelegate
    
    func didTapAddButton() {
        let addController = AddReflectionViewController()
        addController.delegate = self
        let navController = UINavigationController(rootViewController: addController)
        
        presentViewController(navController, animated: true, completion: nil)
    }
    
    // MARK: AddReflectionViewControllerDelegate
    
    func didFinishTypingEvent(typedText: String!) {
        if typedText?.utf16Count > 0 {
            let reflection = Reflection()
            reflection.event = typedText!
            
            let realm = RLMRealm.defaultRealm()
            realm.transactionWithBlock() {
                realm.addObject(reflection)
            }
            tableView.reloadData()
        }
    }
    
}
