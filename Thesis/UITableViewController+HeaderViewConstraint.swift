//
//  UITableViewController+HeaderViewConstraint.swift
//  Thesis
//
//  Created by Maxwell Barvian on 2/21/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit

extension UITableViewController {
	
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
	
}
