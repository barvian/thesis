//
//  LearnViewController.swift
//  Thesis
//
//  Created by Maxwell Barvian on 2/1/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit

class LearnViewController: ConstrainedTableViewController, FullScreenViewController, UITableViewDataSource, UITableViewDelegate, LearnHeaderViewDelegate {
	
	let tintColor = UIColor.applicationBaseColor()
	let backgroundColor = UIColor.applicationLightColor()
	let tabColor = UIColor(r: 178, g: 186, b: 196)
	let selectedTabColor = UIColor.applicationBaseColor()
	
	let navigationBarHidden = true
	let navigationBarTranslucent = false
	
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
	
	convenience init() {
		self.init(style: .Plain)
		
		title = "Learn"
		tabBarItem.image = UIImage(named: "Learn")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupFullScreenView(self)
		
		tableView.allowsSelection = true
		tableView.registerClass(ReadingTableViewCell.self, forCellReuseIdentifier: "cell")
		tableView.separatorStyle = .None
		tableView.rowHeight = UITableViewAutomaticDimension
		tableView.estimatedRowHeight = 44.0
		tableView.tableHeaderView = headerView
	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		
		updateFullScreenColors(self, animated: animated)
		hideFullScreenNavigationBar(self, animated: animated)
	}
	
	override func viewWillDisappear(animated: Bool) {
		super.viewWillDisappear(animated)
		
		unhideFullScreenNavigationBar(self, animated: animated)
	}
	
	// MARK: UITableViewDataSource
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 📖.count
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! ReadingTableViewCell
		let reading = 📖[indexPath.row] as! NSDictionary
		
		cell.configureForReading(reading)
		
		cell.setNeedsUpdateConstraints()
		cell.updateConstraintsIfNeeded()
		
		return cell
	}
	
	// MARK: UITableViewDelegate
	
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		let reading = 📖[indexPath.row] as! NSDictionary
		let readingController = ReadingViewController()
		readingController.reading = reading
		
		navigationController?.pushViewController(readingController, animated: true)
	}
	
	// MARK: LearnHeaderViewDelegate {
	
	func learnHeaderView(learnHeaderView: LearnHeaderView, didTapHowToUseButton howToUseButton: UIButton!) {
		let welcomeController = OnboardingViewController()
		UIApplication.rootViewController.presentViewController(welcomeController, animated: true, completion: nil)
	}
	
}
