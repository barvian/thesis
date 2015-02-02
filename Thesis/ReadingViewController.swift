//
//  ReadingViewController.swift
//  Thesis
//
//  Created by Maxwell Barvian on 2/1/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit
import WebKit

class ReadingViewController: UIViewController {
    
    var reading: AnyObject? {
        didSet {
            configureView()
        }
    }
    
    private(set) lazy var webView: WKWebView = {
        let webView = WKWebView()
//         webView.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        return webView
    }()
    
    func configureView() {
        // Update the user interface for the detail item.
        if let reading: AnyObject = self.reading as? NSDictionary {
            title = reading["Title"] as? String
            
            let file = reading["File"] as String
            let path = NSBundle.mainBundle().pathForResource(file, ofType: "html", inDirectory: "Readings")!
            let html = String(contentsOfFile: path, encoding: NSUTF8StringEncoding, error: nil)!
            webView.loadHTMLString(html, baseURL: nil)
        }
    }
    
    convenience override init() {
        self.init(nibName: nil, bundle: nil)
        
        hidesBottomBarWhenPushed = true
    }

    override func loadView() {
        self.view = webView
        
//        view.setNeedsUpdateConstraints()
    }
    
    // MARK: Constraints
    
    private var didSetupConstraints = false
    
    override func updateViewConstraints() {
        if !didSetupConstraints {
//            view.addConstraint(NSLayoutConstraint(item: webView, attribute: .Top, relatedBy: .Equal, toItem: topLayoutGuide, attribute: .Bottom, multiplier: 1, constant: 0))
//            view.addConstraint(NSLayoutConstraint(item: webView, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1, constant: 0))
//            view.addConstraint(NSLayoutConstraint(item: webView, attribute: .Left, relatedBy: .Equal, toItem: view, attribute: .Left, multiplier: 1, constant: 0))
//            view.addConstraint(NSLayoutConstraint(item: webView, attribute: .Right, relatedBy: .Equal, toItem: view, attribute: .Right, multiplier: 1, constant: 0))
            
            didSetupConstraints = true
        }
        
        super.updateViewConstraints()
    }
    
}

