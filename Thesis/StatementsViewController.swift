//
//  StatementsViewController.swift
//  Thesis
//
//  Created by Maxwell Barvian on 2/23/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

//
//  LearnViewController.swift
//  Thesis
//
//  Created by Maxwell Barvian on 2/1/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit

class StatementsViewController: UIViewController, FullScreenViewController, RelaxationViewController, StatementsFooterViewDelegate, UITableViewDataSource, UITableViewDelegate {
	
	weak var relaxationDelegate: RelaxationViewControllerDelegate?
	
	let tintColor = UIColor.whiteColor()
	let backgroundColor = UIColor.applicationDarkColor()
	let tabColor = UIColor.clearColor()
	let selectedTabColor = UIColor.clearColor()
	
	let navigationBarHidden = true
	let navigationBarTranslucent = true
	
	private(set) lazy var 🌞: NSArray = {
		let path = NSBundle.mainBundle().pathForResource("Statements", ofType: "plist")!
		let data = NSArray(contentsOfFile: path)!
		
		return data
	}()
	
	private(set) lazy var tableView: ConstrainedTableView = {
		let tableView = ConstrainedTableView()
		tableView.setTranslatesAutoresizingMaskIntoConstraints(false)
		tableView.backgroundColor = self.backgroundColor
		tableView.dataSource = self
		tableView.delegate = self
		tableView.allowsSelection = false
		tableView.registerClass(StatementTableViewCell.self, forCellReuseIdentifier: "cell")
		tableView.separatorStyle = .None
		tableView.rowHeight = UITableViewAutomaticDimension
		tableView.estimatedRowHeight = 64.0
		tableView.tableHeaderView = self.headerView
		tableView.tableFooterView = self.footerView
		
		return tableView
	}()
	
	private(set) lazy var headerView: StatementsHeaderView = {
		let header = StatementsHeaderView()
		
		return header
	}()
	
	private(set) lazy var footerView: StatementsFooterView = {
		let footer = StatementsFooterView()
		footer.delegate = self
		
		return footer
	}()
	
	override func preferredStatusBarStyle() -> UIStatusBarStyle {
		return .LightContent
	}
	
	convenience init() {
		self.init(nibName: nil, bundle: nil)
		
		title = "Statements"
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.addSubview(tableView)
		
		setupFullScreenControllerView(self)
		
		view.setNeedsUpdateConstraints() // bootstrap AutoLayout
	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		
		shouldUpdateProgressButton()
		
		updateFullScreenControllerColors(self, animated: false)
		hideFullScreenControllerNavigationBar(self, animated: false)
	}
	
	// MARK: Constraints
	
	private var _didSetupConstraints = false
	
	override func updateViewConstraints() {
		if !_didSetupConstraints {
			setupFullScreenControllerViewConstraints(self)
			
			let views: [NSObject: AnyObject] = [
				"topLayoutGuide": topLayoutGuide,
				"tableView": tableView,
				"bottomLayoutGuide": bottomLayoutGuide
			]
			
			view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[tableView]|", options: nil, metrics: nil, views: views))
			view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[tableView]|", options: nil, metrics: nil, views: views))
			
			_didSetupConstraints = true
		}
		
		super.updateViewConstraints()
	}
	
	// MARK: UITableViewDataSource
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 🌞.count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! StatementTableViewCell
		let statement = 🌞[indexPath.row] as! String
		
		cell.configureForStatement(statement, row: indexPath.row)
		
		cell.setNeedsUpdateConstraints()
		cell.updateConstraintsIfNeeded()
		
		return cell
	}
	
	// MARK: StatementsFooterViewDelegate
	
	func statementsFooterView(statementsFooterView: StatementsFooterView, didTapProgressButton progressButton: UIButton!) {
		relaxationDelegate?.relaxationViewControllerDidTapProgressButton?(self)
	}
	
	// MARK: RelaxationViewControllerDelegate
	
	func shouldUpdateProgressButton() {
		relaxationViewController(self, shouldUpdateProgressButton: footerView.progressButton)
	}
	
}
