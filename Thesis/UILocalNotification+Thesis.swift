//
//  UILocalNotification+Thesis.swift
//  Thesis
//
//  Created by Maxwell Barvian on 2/26/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit

public let UILocalNotificationUserInfoNameKey = "name"

public let UILocalNotificationRelaxationReminderName = "relaxationReminder"
public let UILocalNotificationReflectionReminderName = "reflectionReminder"

extension UILocalNotification {
	
	// MARK: Reminders
	
	class func applicationRelaxationReminder(time: NSDate) -> UILocalNotification {
		let notif = UILocalNotification()
		let userInfo: [NSObject: AnyObject] = [
			UILocalNotificationUserInfoNameKey: UILocalNotificationRelaxationReminderName
		]
		notif.userInfo = userInfo
		notif.fireDate = time.beginningOfMinute()
		notif.timeZone = NSTimeZone.defaultTimeZone()
		
		notif.alertBody = "Have some time to relax?"
		notif.alertAction = "Relax"
		notif.soundName = UILocalNotificationDefaultSoundName
		notif.repeatInterval = .DayCalendarUnit
		
		return notif
	}
	
	class func applicationReflectionReminder(time: NSDate) -> UILocalNotification {
		let notif = UILocalNotification()
		let userInfo: [NSObject: AnyObject] = [
			UILocalNotificationUserInfoNameKey: UILocalNotificationReflectionReminderName
		]
		notif.userInfo = userInfo
		notif.fireDate = time.beginningOfMinute()
		notif.timeZone = NSTimeZone.defaultTimeZone()
		
		notif.alertBody = "Have you reflected on what went well today?"
		notif.alertAction = "Reflect"
		notif.soundName = UILocalNotificationDefaultSoundName
		notif.repeatInterval = .DayCalendarUnit
		
		return notif
	}
	
}
