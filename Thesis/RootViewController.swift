//
//  RootViewController.swift
//  Thesis
//
//  Created by Maxwell Barvian on 1/10/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit

class RootViewController: UINavigationController, UIPageViewControllerDelegate, UIPageViewControllerDataSource, UIScrollViewDelegate {
    
    var pages = [
        RelaxViewController(),
        UIViewController()
    ]
    
    lazy var pageViewController: UIPageViewController! = {
        let controller = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        controller.dataSource = self
        controller.delegate = self
        
        return controller
    }()
    
    lazy var pageScrollView: UIScrollView! = {
        for view in self.pageViewController.view.subviews {
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
        
        self.addChildViewController(self.pageViewController!)
        self.view.addSubview(self.pageViewController.view)
        
        // Set the page view controller's bounds using an inset rect so that self's view is visible around the edges of the pages.
        // self.pageViewController.view.frame = self.view.bounds
        
        self.pageViewController.didMoveToParentViewController(self)
        
        // Add the page view controller's gesture recognizers to the book view controller's view so that the gestures are started more easily.
        self.view.gestureRecognizers = self.pageViewController.gestureRecognizers
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        setNavigationBarHidden(true, animated: animated)
        self.pageViewController.setViewControllers([pages[0]], direction: .Forward, animated: true, completion: {done in })
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: UIPageViewControllerDataSource
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        if let index = find(pages, viewController) {
            return index > 0 ? pages[index - 1] : nil
        } else {
            return nil
        }
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        if let index = find(pages, viewController) {
            return index >= pages.count - 1 ? nil : pages[index + 1]
        } else {
            return nil
        }
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    // MARK: UIScrollViewDelegate
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let xFromCenter = self.view.frame.size.width - pageScrollView.contentOffset.x
        println(xFromCenter)
    }
    
}



