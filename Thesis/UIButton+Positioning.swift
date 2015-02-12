//
//  UIButton+Positioning.swift
//  Thesis
//
//  Created by Maxwell Barvian on 2/12/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit

extension UIButton {
    
    func centerVertically(padding: CGFloat = 0) {
        let imageSize = imageView!.frame.size
        let titleSize = titleLabel!.text!.sizeWithAttributes([NSFontAttributeName: self.titleLabel!.font])
        
        let totalHeight = imageSize.height + titleSize.height + padding
        
        imageEdgeInsets = UIEdgeInsets(top: -(totalHeight - imageSize.height), left: 0, bottom: 0, right: -titleSize.width)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageSize.width, bottom: -(totalHeight - titleSize.height), right: 0)
    }
    
}
