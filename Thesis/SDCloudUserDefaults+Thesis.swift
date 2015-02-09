//
//  SDCloudUserDefaults+Thesis.swift
//  Thesis
//
//  Created by Maxwell Barvian on 2/8/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import SDCloudUserDefaults

extension SDCloudUserDefaults {
    
    class var hasSeenWelcome: Bool {
        get { return SDCloudUserDefaults.boolForKey("hasSeenWelcome") }
        set { SDCloudUserDefaults.setBool(newValue, forKey: "hasSeenWelcome") }
    }
    
}
