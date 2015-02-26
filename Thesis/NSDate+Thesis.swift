//
//  NSDate+Thesis.swift
//  Thesis
//
//  Created by Maxwell Barvian on 2/26/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import Foundation

extension NSDate {
	
	class func applicationDefaultRelaxationReminderTime() -> NSDate {
		return NSDate().beginningOfDay().addHours(8)
	}
	
	class func applicationDefaultReflectionReminderTime() -> NSDate {
		return NSDate().beginningOfDay().addHours(12+8)
	}
	
}