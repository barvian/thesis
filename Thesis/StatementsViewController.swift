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

class StatementsViewController: ConstrainedTableViewController, FullScreenViewController, RelaxationController, StatementsFooterViewDelegate, UITableViewDataSource, UITableViewDelegate, LearnHeaderViewDelegate {
	
	weak var relaxationDelegate: RelaxationControllerDelegate?
	
	let tintColor = UIColor.whiteColor()
	let backgroundColor = UIColor.applicationBaseColor()
	let tabColor = UIColor.clearColor()
	let selectedTabColor = UIColor.clearColor()
	
	let navigationBarHidden = true
	let navigationBarTranslucent = true
	
	private(set) lazy var 🌞: NSArray = {
		let path = NSBundle.mainBundle().pathForResource("Statements", ofType: "plist")!
		let data = NSArray(contentsOfFile: path)!
		
		return data
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
		self.init(style: .Plain)
		
		title = "Statements"
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupFullScreenView(self)
		
		tableView.allowsSelection = true
		tableView.registerClass(StatementTableViewCell.self, forCellReuseIdentifier: "cell")
		tableView.separatorStyle = .None
		tableView.rowHeight = UITableViewAutomaticDimension
		tableView.estimatedRowHeight = 44.0
		tableView.tableHeaderView = headerView
		tableView.tableFooterView = footerView
	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		
		updateFullScreenColors(self, animated: false)
		hideFullScreenNavigationBar(self, animated: false)
	}
	
	// MARK: UITableViewDataSource
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 🌞.count
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! StatementTableViewCell
		let statement = 🌞[indexPath.row] as! String
		
		cell.configureForStatement(statement, row: indexPath.row)
		
		cell.setNeedsUpdateConstraints()
		cell.updateConstraintsIfNeeded()
		
		return cell
	}
	
	// MARK: StatementsFooterViewDelegate {
	
	func statementsFooterView(statementsFooterView: StatementsFooterView, didTapDoneButton doneButton: UIButton!) {
		relaxationDelegate?.relaxationControllerShouldDismiss?(self)
	}
	
}
