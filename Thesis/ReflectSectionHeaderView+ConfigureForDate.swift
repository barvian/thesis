//
//  ReflectSectionHeaderView+ConfigureForDate.swift
//  Thesis
//
//  Created by Maxwell Barvian on 2/10/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

extension ReflectSectionHeaderView {
    
    func configureForDate(date: NSDate) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeStyle = .NoStyle
        dateFormatter.dateStyle = .MediumStyle
        
        let locale = NSLocale.currentLocale()
        dateFormatter.locale = locale
        
        dateFormatter.doesRelativeDateFormatting = true
        
        dateLabel.text = dateFormatter.stringFromDate(date)
    }
    
}
