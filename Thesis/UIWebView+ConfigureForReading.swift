//
//  UIWebView+ConfigureForReading.swift
//  Thesis
//
//  Created by Maxwell Barvian on 2/10/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit

extension UIWebView {
    
    func configureForReading(reading: NSDictionary?) {
        if let file = reading?["File"] as? String {
            if let path = NSBundle.mainBundle().pathForResource(file, ofType: "html", inDirectory: "Readings") {
                if let url = NSURL(fileURLWithPath: path) {
                    loadRequest(NSURLRequest(URL: url))
                }
            }
        }
    }
    
}
