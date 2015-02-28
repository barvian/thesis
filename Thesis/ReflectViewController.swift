//
//  ReflectViewController.swift
//  Thesis
//
//  Created by Maxwell Barvian on 2/5/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit
import Realm

class ReflectViewController: UIViewController, FullScreenViewController, DailyReminderViewDelegate, UITableViewDataSource, UITableViewDelegate, ReflectHeaderViewDelegate, AddReflectionViewControllerDelegate {
	
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
	
	private(set) lazy var reminderView: DailyReminderView = {
		let picker = DailyReminderView()
		picker.setTranslatesAutoresizingMaskIntoConstraints(false)
		picker.reminderLabel.text = "Daily reflection reminder"
		if let reflectionReminder = UIApplication.reflectionReminder {
			picker.timePicker.date = reflectionReminder.fireDate!
			picker.toggleReminder(true)
		} else {
			picker.timePicker.date = NSDate.applicationDefaultReflectionReminderTime()
			picker.toggleReminder(false)
		}
		picker.delegate = self
		
		return picker
	}()
	
	private(set) lazy var tableView: ConstrainedTableView = {
		let tableView = ConstrainedTableView()
		tableView.setTranslatesAutoresizingMaskIntoConstraints(false)
		tableView.backgroundColor = self.backgroundColor
		tableView.dataSource = self
		tableView.delegate = self
		tableView.allowsSelection = false
		tableView.registerClass(ReflectTableViewCell.self, forCellReuseIdentifier: "cell")
		tableView.separatorStyle = .None
		tableView.rowHeight = UITableViewAutomaticDimension
		tableView.estimatedRowHeight = 64.0
		tableView.tableHeaderView = self.headerView
		
		return tableView
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
	
	convenience override init() {
		self.init(nibName: nil, bundle: nil)
		
		title = "Reflect"
		tabBarItem.image = UIImage(named: "Reflect")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.addSubview(tableView)
		
		setupFullScreenControllerView(self)
		
		view.addSubview(reminderView)
		toggleReminderView(false)
		
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
		
		view.setNeedsUpdateConstraints() // bootstrap AutoLayout
	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		
		updateFullScreenControllerColors(self, animated: animated)
		hideFullScreenControllerNavigationBar(self, animated: animated)
	}
	
	override func viewDidDisappear(animated: Bool) {
		super.viewDidDisappear(animated)
		
		unhideFullScreenControllerNavigationBar(self, animated: false)
	}
	
	override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
		super.touchesEnded(touches, withEvent: event)
		
		if (_showingReminderView) {
			UIView.animateWithDuration(0.4) {
				self.toggleReminderView(false)
			}
		}
	}
	
	// MARK: API
	
	private var _showingReminderView = false
	
	func toggleReminderView(_ state: Bool? = nil) {
		_showingReminderView = state != nil ? state! : !_showingReminderView
		
		let transform = CGAffineTransformMakeTranslation(0, _showingReminderView ? reminderView.bounds.height : 0)
		reminderView.transform = transform
		tableView.transform = transform
		tableView.alpha = _showingReminderView ? 0.5 : 1
		tabBarController?.tabBar.alpha = _showingReminderView ? 0.5 : 1
		tabBarController?.tabBar.transform = transform
		
		tableView.userInteractionEnabled = !_showingReminderView
	}
	
	func remind() {
		headerView.reminderButton.animateWithApplicationShake(0.55, delay: 0, options: nil) {
			(completed) in
			self.headerView.reminderButton.animateWithApplicationShake(0.55, delay: 0.35, options: nil) {
				(completed) in
				self.headerView.reminderButton.animateWithApplicationShake(0.55, delay: 0.35, options: nil, completion: nil)
			}
		}
	}
	
	func addReflection(reflection: Reflection) {
		let date = reflection.date.beginningOfDay()
		
		// If we don't yet have an array to hold the reflections for this day, add one
		if 📅[date] == nil {
			📅[date] = [reflection]
		} else {
			📅[date]!.insert(reflection, atIndex: 0)
		}
	}
	
	// MARK: Constraints
	
	private var _didSetupConstraints = false
	
	override func updateViewConstraints() {
		if !_didSetupConstraints {
			setupFullScreenControllerViewConstraints(self)
			
			let views: [NSObject: AnyObject] = [
				"topLayoutGuide": topLayoutGuide,
				"reminderView": reminderView,
				"tableView": tableView,
				"bottomLayoutGuide": bottomLayoutGuide
			]
			
			let margin: CGFloat = 14
			let metrics = [
				"margin": margin
			]
			
			reminderView.layoutMargins = UIEdgeInsets(top: topLayoutGuide.length + margin, left: margin, bottom: margin, right: margin)
			
			view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[reminderView][topLayoutGuide]", options: nil, metrics: metrics, views: views))
			view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[reminderView]|", options: nil, metrics: metrics, views: views))
			
			view.addConstraint(NSLayoutConstraint(item: tableView, attribute: .Top, relatedBy: .Equal, toItem: topLayoutGuide, attribute: .Top, multiplier: 1, constant: 0))
			view.addConstraint(NSLayoutConstraint(item: tableView, attribute: .Bottom, relatedBy: .Equal, toItem: bottomLayoutGuide, attribute: .Bottom, multiplier: 1, constant: 0))
			view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[tableView]|", options: nil, metrics: nil, views: views))
			
			_didSetupConstraints = true
		}
		
		super.updateViewConstraints()
	}
	
	// MARK: UITableViewDataSource
	
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return Int(📅.count)
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		let date = sortedDays[section]
		return 📅[date]!.count
	}
	
	func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 64
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! ReflectTableViewCell
		let date = sortedDays[indexPath.section]
		let reflection = 📅[date]![indexPath.row]
		
		cell.configureForReflection(reflection)
		
		cell.setNeedsUpdateConstraints()
		cell.updateConstraintsIfNeeded()
		
		return cell
	}
	
	// MARK: UITableViewDelegate
	
	func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
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
	
	// MARK: ReflectHeaderViewDelegate
	
	func reflectHeaderView(reflectHeaderView: ReflectHeaderView, didTapReminderButton reminderButton: UIButton!) {
		UIView.animateWithDuration(0.3) {
			self.tableView.contentOffset = CGPoint(x: 0, y: -self.tableView.contentInset.top)
			self.toggleReminderView(true)
		}
	}
	
	func reflectHeaderView(reflectHeaderView: ReflectHeaderView, didTapAddButton addButton: UIButton!) {
		let addController = AddReflectionViewController()
		addController.delegate = self
		let navController = UINavigationController(rootViewController: addController)
		
		presentViewController(navController, animated: true, completion: nil)
	}
	
	// MARK: DailyReminderViewDelegate
	
	func dailyReminderView(dailyReminderView: DailyReminderView, didToggleReminder reminder: Bool) {
		UIApplication.reflectionReminder = reminder ? UILocalNotification.applicationReflectionReminder(reminderView.timePicker.date) : nil
	}
	
	func dailyReminderView(dailyReminderView: DailyReminderView, didChangeTime time: NSDate) {
		UIApplication.reflectionReminder = UILocalNotification.applicationReflectionReminder(time)
	}
	
	// MARK: AddReflectionViewControllerDelegate
	
	func addReflectionViewController(addReflectionViewController: AddReflectionViewController, didFinishTypingEvent eventText: String!, reason reasonText: String!) {
		if count(eventText) > 0 && count(reasonText) > 0 {
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
