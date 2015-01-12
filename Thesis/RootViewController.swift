//
//  RootViewController.swift
//  Thesis
//
//  Created by Maxwell Barvian on 1/10/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit

class RootViewController: UIPageViewController, UIPageViewControllerDelegate, UIScrollViewDelegate {
    
    var pages = [UIViewController]()
    
    lazy var pageScrollView: UIScrollView! = {
        for view in self.pageController.view.subviews {
            if view is UIScrollView {
                let scrollView = view as UIScrollView
                scrollView.delegate = self
                
                return scrollView
            }
        }
        
        return nil
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        transitionStyle = .Scroll
        navigationOrientation = .Horizontal
    }
    
    // MARK: UIScrollViewDelegate
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let xFromCenter = self.view.frame.size.width - pageScrollView.contentOffset.x
    }
    
}

