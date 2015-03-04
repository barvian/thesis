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
	
	var appDelegate: AppDelegate {
		return delegate as! AppDelegate
	}
	
	var window: UIWindow {
		return appDelegate.window!
	}
	
	var rootViewController: RootViewController {
		return window.rootViewController as! RootViewController
	}
	
	// MARK: Local notifications
	
	func registerForNotifications(completion: ((UIUserNotificationSettings) -> ())? = nil) {
		let settings = UIUserNotificationSettings(
			forTypes: .Badge | .Sound | .Alert,
			categories: nil)
		registerUserNotificationSettings(settings)
		
		_notificationCompletionBlock = completion
	}
	
	func didRegisterForNotifications(notificationSettings: UIUserNotificationSettings) {
		_notificationCompletionBlock?(notificationSettings)
	}
	
	var relaxationReminder: UILocalNotification? {
		get {
			for notification in scheduledLocalNotifications {
				if let notification = notification as? UILocalNotification, userInfo = notification.userInfo, name = userInfo[UILocalNotificationUserInfoNameKey] as? String
						where name == UILocalNotificationRelaxationReminderName {
					return notification
				}
			}
			
			return nil
		}
		set(newValue) {
			if let relaxationReminder = relaxationReminder {
				cancelLocalNotification(relaxationReminder)
			}
			if let newValue = newValue {
				scheduleLocalNotification(newValue)
			}
		}
	}
	
	var reflectionReminder: UILocalNotification? {
		get {
			for notification in scheduledLocalNotifications {
				if let notification = notification as? UILocalNotification, userInfo = notification.userInfo, name = userInfo[UILocalNotificationUserInfoNameKey] as? String
						where name == UILocalNotificationReflectionReminderName {
					return notification
				}
			}
			
			return nil
		}
		set(newValue) {
			if let reflectionReminder = reflectionReminder {
				cancelLocalNotification(reflectionReminder)
			}
			if let newValue = newValue {
				scheduleLocalNotification(newValue)
			}
		}
	}
	
}
