//
//  ReadingTableViewCell+ConfigureForReading.swift
//  Thesis
//
//  Created by WSOL Intern on 2/9/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit

extension ReadingTableViewCell {
    
    func configureForReading(reading: NSDictionary) {
        titleLabel.text = reading["Title"] as? String
        if let description = reading["Description"] as? String {
            descriptionLabel.text = description
            descriptionLabel.hidden = false
        } else {
            descriptionLabel.hidden = true
        }
    }
    
}