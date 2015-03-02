//
//  ConstrainedTableView.swift
//  Thesis
//
//  Created by Maxwell Barvian on 2/21/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit

class ConstrainedTableView: UITableView {
	
	// MARK: Initializers
	
	convenience override init() {
		self.init(frame: CGRectZero)
	}
	
	convenience override init(frame: CGRect) {
		self.init(frame: frame, style: .Plain)
	}
	
	override init(frame: CGRect, style: UITableViewStyle) {
		super.init(frame: frame, style: style)
		
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "didChangePreferredContentSize:", name: UIContentSizeCategoryDidChangeNotification, object: nil)
	}
	
	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	// MARK: Handlers
	
	func didChangePreferredContentSize(notification: NSNotification) {
		_needsConstraints = true
	}
	
	// MARK: Constraints
	
	func reconstrainView(view: UIView?) -> UIView? {
		if let view = view {
			for subview in view.subviews {
				(subview as? UILabel)?.preferredMaxLayoutWidth = subview.frame.width
			}
			
			view.setNeedsLayout()
			view.layoutIfNeeded()
			let height = view.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height
			
			// Update the header's frame and add it again
			var headerFrame = view.frame
			headerFrame.size.height = height
			view.frame = headerFrame
		}
		
		return view
	}
	
	private var _needsConstraints = true
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		if _needsConstraints {
			tableHeaderView = reconstrainView(tableHeaderView)
			tableFooterView = reconstrainView(tableFooterView)
		}
		
		_needsConstraints = false
	}
	
	// MARK: Deinitializer
	
	deinit {
		NSNotificationCenter.defaultCenter().removeObserver(self)
	}
	
}
