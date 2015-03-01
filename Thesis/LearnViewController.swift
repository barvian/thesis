//
//  LearnViewController.swift
//  Thesis
//
//  Created by Maxwell Barvian on 2/1/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit

class LearnViewController: UIViewController, FullScreenViewController, UITableViewDataSource, UITableViewDelegate, LearnHeaderViewDelegate {
	
	let tintColor = UIColor.applicationBaseColor()
	let backgroundColor = UIColor.applicationLightColor()
	let tabColor = UIColor(r: 178, g: 186, b: 196)
	let selectedTabColor = UIColor.applicationBaseColor()
	
	let navigationBarHidden = true
	let navigationBarTranslucent = false
	
	private(set) lazy var transitionManager: UIViewControllerTransitioningDelegate = {
		let manager = FadeTransitionManager()
		manager.backgroundColor = UIColor.whiteColor()
		
		return manager
	}()
	
	private(set) lazy var 📖: NSArray = {
		let path = NSBundle.mainBundle().pathForResource("Readings", ofType: "plist")!
		let data = NSArray(contentsOfFile: path)!
		
		return data
	}()
	
	private(set) lazy var tableView: ConstrainedTableView = {
		let tableView = ConstrainedTableView()
		tableView.setTranslatesAutoresizingMaskIntoConstraints(false)
		tableView.backgroundColor = self.backgroundColor
		tableView.dataSource = self
		tableView.delegate = self
		tableView.allowsSelection = true
		tableView.registerClass(ReadingTableViewCell.self, forCellReuseIdentifier: "cell")
		tableView.separatorStyle = .None
		tableView.rowHeight = UITableViewAutomaticDimension
		tableView.estimatedRowHeight = 44.0
		tableView.tableHeaderView = self.headerView
		
		return tableView
	}()
	
	private(set) lazy var headerView: LearnHeaderView = {
		let header = LearnHeaderView()
		header.delegate = self
		
		return header
	}()
	
	convenience override init() {
		self.init(nibName: nil, bundle: nil)
		
		title = "Learn"
		tabBarItem.image = UIImage(named: "Learn")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.addSubview(tableView)
		
		setupFullScreenControllerView(self)
		
		view.setNeedsUpdateConstraints() // bootstrap AutoLayot
	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		
		updateFullScreenControllerColors(self, animated: animated)
		hideFullScreenControllerNavigationBar(self, animated: animated)
	}
	
	override func viewWillDisappear(animated: Bool) {
		super.viewWillDisappear(animated)
		
		unhideFullScreenControllerNavigationBar(self, animated: animated)
	}
	
	// MARK: Constraints
	
	private var _didSetupConstraints = false
	
	override func updateViewConstraints() {
		if !_didSetupConstraints {
			setupFullScreenControllerViewConstraints(self)
			
			let views: [NSObject: AnyObject] = [
				"tableView": tableView,
			]
			
			view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[tableView]|", options: nil, metrics: nil, views: views))
			view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[tableView]|", options: nil, metrics: nil, views: views))
			
			_didSetupConstraints = true
		}
		
		super.updateViewConstraints()
	}
	
	// MARK: UITableViewDataSource
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 📖.count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! ReadingTableViewCell
		let reading = 📖[indexPath.row] as! NSDictionary
		
		cell.configureForReading(reading)
		
		cell.setNeedsUpdateConstraints()
		cell.updateConstraintsIfNeeded()
		
		return cell
	}
	
	// MARK: UITableViewDelegate
	
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		let reading = 📖[indexPath.row] as! NSDictionary
		let readingController = ReadingViewController()
		readingController.reading = reading
		
		navigationController?.pushViewController(readingController, animated: true)
	}
	
	// MARK: LearnHeaderViewDelegate {
	
	func learnHeaderView(learnHeaderView: LearnHeaderView, didTapHowToUseButton howToUseButton: UIButton!) {
		let tutorialController = OnboardingSlideController(contentView: OnboardingTutorialSlide())
		tutorialController.transitioningDelegate = transitionManager
		tutorialController.modalPresentationStyle = .Custom
		UIApplication.rootViewController.presentViewController(tutorialController, animated: true, completion: nil)
	}
	
}
