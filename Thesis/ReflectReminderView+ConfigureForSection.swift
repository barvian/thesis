//
//  ReflectReminderView+ConfigureForSection.swift
//  Thesis
//
//  Created by Maxwell Barvian on 2/21/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit

extension ReflectReminderView {
	
	func configureForTodaySection(section: [Reflection]?) {
		let count = (section == nil ? 0 : section!.count), remaining = reflectionsPerDay - count
		switch remaining {
		case reflectionsPerDay:
			reminderLabel.text = "What \(remaining) things were you grateful for today?"
		case 1:
			reminderLabel.text = "What else are you grateful for today?"
		default:
			reminderLabel.text = "What other \(remaining) things went well today?"
		}
		
		hidden = remaining <= 0
	}
	
}
