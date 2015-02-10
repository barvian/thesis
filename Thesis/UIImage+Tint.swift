//
//  UIImage+Tint.swift
//  Thesis
//
//  Created by Maxwell Barvian on 2/9/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit

extension UIImage {
    
    func imageTintedWithColor(color: UIColor) -> UIImage {
        return imageTintedWithColor(color, fraction: 0.0)
    }
    
    func imageTintedWithColor(color: UIColor, fraction: CGFloat) -> UIImage {
        var image = UIImage()
        
        UIGraphicsBeginImageContext(self.size)
        
        var rect = CGRectZero
        rect.size = self.size
        
        // Composite tint color at its own opacity
        color.set()
        UIRectFill(rect)
        
        // Mask tint color-swatch to this image's opaque mask
        self.drawInRect(rect, blendMode: kCGBlendModeDestinationIn, alpha: 1.0)
        
        // Finally, composite this image over the tinted mask at desired opacity
        if (fraction > 0.0) {
            self.drawInRect(rect, blendMode: kCGBlendModeSourceAtop, alpha: fraction)
        }
        
        image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
}
