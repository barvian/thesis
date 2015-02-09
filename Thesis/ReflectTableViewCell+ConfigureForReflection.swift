//
//  ReflectTableViewCell+ConfigureForReflection.swift
//  Thesis
//
//  Created by Maxwell Barvian on 2/8/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit

extension ReflectTableViewCell {
    
    func configureForReflection(reflection: Reflection) {
        eventLabel.text = reflection.event
        reasonLabel.text = reflection.event
    }
    
}
