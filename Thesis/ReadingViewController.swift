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
        
        view.setNeedsUpdateConstraints()
    }
    
    // MARK: Constraints
    
    private var didSetupConstraints = false
    
    override func updateViewConstraints() {
        if !didSetupConstraints {            
            didSetupConstraints = true
        }
        
        super.updateViewConstraints()
    }
    
}

