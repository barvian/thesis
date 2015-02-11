//
//  NSDate+Additions.swift
//  Thesis
//
//  Created by Maxwell Barvian on 2/10/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import Foundation

extension NSDate: Comparable {
    
    func beginningOfDay() -> NSDate {
        // Use the user's current calendar and time zone
        let calendar = NSCalendar.currentCalendar()
        let timeZone = NSTimeZone.systemTimeZone()
        calendar.timeZone = timeZone
        
        // Selectively convert the date components (year, month, day) of the input date
        let dateComps = calendar.components(.YearCalendarUnit | .MonthCalendarUnit | .DayCalendarUnit, fromDate: self)
        
        // Set the time components manually
        dateComps.hour = 0
        dateComps.minute = 0
        dateComps.second = 0
        
        // Convert back
        return calendar.dateFromComponents(dateComps)!
    }
    
    func addDays(days: Int) -> NSDate {
        // Use the user's current calendar and time zone
        let calendar = NSCalendar.currentCalendar()
        
        let dateComps = NSDateComponents()
        dateComps.day = days
        
        return calendar.dateByAddingComponents(dateComps, toDate: self, options: nil)!
    }
    
}

public func ==(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs === rhs || lhs.compare(rhs) == .OrderedSame
}

public func <(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) == .OrderedAscending
}