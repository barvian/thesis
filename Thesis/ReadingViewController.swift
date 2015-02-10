//
//  ReadingViewController.swift
//  Thesis
//
//  Created by Maxwell Barvian on 2/1/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit
import WebKit

class ReadingViewController: UIViewController, UIWebViewDelegate {
    
    var reading: NSDictionary? {
        didSet {
            webView.configureForReading(reading)
        }
    }
    
    private(set) lazy var webView: UIWebView = {
        let webView = UIWebView()
        webView.backgroundColor = UIColor.whiteColor()
        
        return webView
    }()
    
    convenience override init() {
        self.init(nibName: nil, bundle: nil)
        
        hidesBottomBarWhenPushed = true
    }

    override func viewDidLoad() {
        self.view = webView
        
        view.setNeedsUpdateConstraints()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        UIApplication.statusBarCover.hidden = true
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

