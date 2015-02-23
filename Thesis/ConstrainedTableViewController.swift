//
//  ConstrainedTableViewController.swift
//  Thesis
//
//  Created by Maxwell Barvian on 2/21/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit

class ConstrainedTableViewController: UITableViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "didChangePreferredContentSize:", name: UIContentSizeCategoryDidChangeNotification, object: nil)
	}
	
	func constrainHeaderView() {
		if let headerView = tableView.tableHeaderView {
			headerView.setNeedsLayout()
			headerView.layoutIfNeeded()
			let height = headerView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height
			
			// Update the header's frame and add it again
			var headerFrame = headerView.frame
			headerFrame.size.height = height
			headerView.frame = headerFrame
			tableView.tableHeaderView = headerView
		}
	}
	
	func constrainFooterView() {
		if let footerView = tableView.tableFooterView {
			footerView.setNeedsLayout()
			footerView.layoutIfNeeded()
			let height = footerView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height
			
			// Update the footer's frame and add it again
			var footerFrame = footerView.frame
			footerFrame.size.height = height
			footerView.frame = footerFrame
			tableView.tableFooterView = footerView
		}
	}
	
	func didChangePreferredContentSize(notification: NSNotification) {
		_needsConstraints = true
	}
	
	private var _needsConstraints = true
	
	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
		
		if _needsConstraints {
			constrainHeaderView()
			constrainFooterView()
		}
		
		_needsConstraints = false
	}
	
	deinit {
		NSNotificationCenter.defaultCenter().removeObserver(self)
	}
	
}
