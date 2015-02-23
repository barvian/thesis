//
//  ReflectViewController.swift
//  Thesis
//
//  Created by Maxwell Barvian on 2/5/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit
import Realm

class ReflectViewController: ConstrainedTableViewController, FullScreenViewController, UITableViewDataSource, ReflectHeaderViewDelegate, AddReflectionViewControllerDelegate {
	
	let daysToShow = 30
	
	let tintColor = UIColor.applicationGreenColor()
	let backgroundColor = UIColor.applicationGreenColor()
	let tabColor = UIColor(r: 53, g: 120, b: 109)
	let selectedTabColor = UIColor.whiteColor()
	
	let navigationBarHidden = true
	let navigationBarTranslucent = true
	
	private(set) var 📅 = [NSDate: [Reflection]]()
	var sortedDays: [NSDate] {
		return 📅.keys.array.sorted() { return $0 > $1 }
	}
	
	private(set) lazy var sectionDateFormatter: NSDateFormatter = {
		let dateFormatter = NSDateFormatter()
		dateFormatter.dateStyle = .ShortStyle
		dateFormatter.timeStyle = .NoStyle
		
		return dateFormatter
	}()
	
	private(set) lazy var headerView: ReflectHeaderView = {
		let header = ReflectHeaderView()
		header.delegate = self
		
		return header
	}()
	
	var notificationToken: RLMNotificationToken?
	
	override func preferredStatusBarStyle() -> UIStatusBarStyle {
		return .LightContent
	}
	
	convenience init() {
		self.init(style: .Plain)
		
		title = "Reflect"
		tabBarItem.image = UIImage(named: "Reflect")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupFullScreenView(self)
		
		tableView.allowsSelection = false
		tableView.registerClass(ReflectTableViewCell.self, forCellReuseIdentifier: "cell")
		tableView.separatorStyle = .None
		tableView.rowHeight = UITableViewAutomaticDimension
		tableView.estimatedRowHeight = 64.0
		tableView.tableHeaderView = headerView
		
		let startDate = NSDate()
		let today = startDate.beginningOfDay()
		let endDate = today.addDays(-daysToShow)
		let predicate = NSPredicate(format: "date <= %@ AND date >= %@", startDate, endDate)
		let sortedReflections = Reflection.objectsWithPredicate(predicate).sortedResultsUsingProperty("date", ascending: true) // reverse for API's sake
		for var i: UInt = 0; i < sortedReflections.count; i++  {
			addReflection(sortedReflections.objectAtIndex(i) as! Reflection)
		}
		if 📅[today] == nil {
			📅[today] = [Reflection]()
		}
	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		
		updateFullScreenColors(self, animated: false)
		hideFullScreenNavigationBar(self, animated: false)
	}
	
	override func viewDidDisappear(animated: Bool) {
		super.viewDidDisappear(animated)
		
		unhideFullScreenNavigationBar(self, animated: false)
	}
	
	// MARK: API
	
	func addReflection(reflection: Reflection) {
		let date = reflection.date.beginningOfDay()
		
		// If we don't yet have an array to hold the reflections for this day, add one
		if 📅[date] == nil {
			📅[date] = [reflection]
		} else {
			📅[date]!.insert(reflection, atIndex: 0)
		}
	}
	
	// MARK: UITableViewDataSource
	
	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return Int(📅.count)
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		let date = sortedDays[section]
		return 📅[date]!.count
	}
	
	override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let date = sortedDays[section]
		switch date {
		case NSDate().beginningOfDay():
			let header = ReflectReminderView()
			header.configureForTodaySection(📅[date])
			if header.hidden {
				fallthrough
			} else {
				return header
			}
		default:
			let header = ReflectSectionHeaderView()
			header.configureForDate(sortedDays[section])
			return header
		}
	}
	
	override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		switch (section, sortedDays[section]) {
		case (0, NSDate().beginningOfDay()):
			return 80
		default:
			return 74
		}
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! ReflectTableViewCell
		let date = sortedDays[indexPath.section]
		let reflection = 📅[date]![indexPath.row]
		
		cell.configureForReflection(reflection)
		
		cell.setNeedsUpdateConstraints()
		cell.updateConstraintsIfNeeded()
		
		return cell
	}
	
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
			addReflection(reflection)
			tableView.reloadData()
			
			addReflectionViewController.view.endEditing(true)
			dismissViewControllerAnimated(true, completion: nil)
		}
	}
	
	func addReflectionViewControllerShouldCancel(addReflectionViewController: AddReflectionViewController) {
		addReflectionViewController.view.endEditing(true)
		dismissViewControllerAnimated(true, completion: nil)
	}
	
}
