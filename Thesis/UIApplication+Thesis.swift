//
//  UIApplication+Thesis.swift
//  Thesis
//
//  Created by Maxwell Barvian on 2/10/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit

private var _notificationCompletionBlock: ((UIUserNotificationSettings) -> ())?

extension UIApplication {
	
	class var appDelegate: AppDelegate {
		return sharedApplication().delegate as! AppDelegate
	}
	
	class var window: UIWindow {
		return appDelegate.window!
	}
	
	class var rootViewController: RootViewController {
		return window.rootViewController as! RootViewController
	}
	
	// MARK: Local notifications
	
	class func registerForNotifications(completion: ((UIUserNotificationSettings) -> ())? = nil) {
		let settings = UIUserNotificationSettings(
			forTypes: .Badge | .Sound | .Alert,
			categories: nil)
		UIApplication.sharedApplication().registerUserNotificationSettings(settings)
		
		_notificationCompletionBlock = completion
	}
	
	class func didRegisterForNotifications(notificationSettings: UIUserNotificationSettings) {
		_notificationCompletionBlock?(notificationSettings)
	}
	
	class var relaxationReminder: UILocalNotification? {
		get {
			for notification in sharedApplication().scheduledLocalNotifications {
				if let notification = notification as? UILocalNotification, userInfo = notification.userInfo, name = userInfo[UILocalNotificationUserInfoNameKey] as? String
						where name == UILocalNotificationRelaxationReminderName {
					return notification
				}
			}
			
			return nil
		}
		set(newValue) {
			if let relaxationReminder = relaxationReminder {
				sharedApplication().cancelLocalNotification(relaxationReminder)
			}
			if let newValue = newValue {
				sharedApplication().scheduleLocalNotification(newValue)
			}
		}
	}
	
	class var reflectionReminder: UILocalNotification? {
		get {
			for notification in sharedApplication().scheduledLocalNotifications {
				if let notification = notification as? UILocalNotification, userInfo = notification.userInfo, name = userInfo[UILocalNotificationUserInfoNameKey] as? String
						where name == UILocalNotificationReflectionReminderName {
					return notification
				}
			}
			
			return nil
		}
		set(newValue) {
			if let reflectionReminder = reflectionReminder {
				sharedApplication().cancelLocalNotification(reflectionReminder)
			}
			if let newValue = newValue {
				sharedApplication().scheduleLocalNotification(newValue)
			}
		}
	}
	
}
