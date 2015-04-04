//
//  SDCloudUserDefaults+Thesis.swift
//  Thesis
//
//  Created by Maxwell Barvian on 2/8/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import SDCloudUserDefaults

public let SDCloudUserDefaultsHasSeenWelcomeKey = "hasSeenWelcome",
	SDCloudUserDefaultsPreviousCalmingSceneKey = "previousCalmingScene"

extension SDCloudUserDefaults {
	
	class var hasSeenWelcome: Bool {
		get { return SDCloudUserDefaults.boolForKey(SDCloudUserDefaultsHasSeenWelcomeKey) }
		set { SDCloudUserDefaults.setBool(newValue, forKey: SDCloudUserDefaultsHasSeenWelcomeKey) }
	}
	
	class var previousCalmingScene: Int {
		get { return SDCloudUserDefaults.integerForKey(SDCloudUserDefaultsPreviousCalmingSceneKey) }
		set { SDCloudUserDefaults.setInteger(newValue, forKey: SDCloudUserDefaultsPreviousCalmingSceneKey) }
	}
	
}
