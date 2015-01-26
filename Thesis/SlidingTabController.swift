//
//  RootViewController.swift
//  Thesis
//
//  Created by Maxwell Barvian on 1/10/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit

class SlidingTabController: UIViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource, UIScrollViewDelegate {
    
    var viewControllers: [UIViewController]!
    var selectedIndex = 0
    
    lazy var pageViewController: UIPageViewController! = {
        let controller = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        controller.dataSource = self
        controller.delegate = self
        controller.view.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        for view in controller.view.subviews {
            if view is UIScrollView {
                let scrollView = view as UIScrollView
                scrollView.delegate = self
            }
        }
        
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildViewController(pageViewController)
        view.addSubview(pageViewController.view)
        
        pageViewController.view.layer.borderColor = UIColor.redColor().CGColor
        pageViewController.view.layer.borderWidth = 3
        
        pageViewController.didMoveToParentViewController(self)
        
        // Add the page view controller's gesture recognizers to the book view controller's view so that the gestures are started more easily.
        self.view.gestureRecognizers = self.pageViewController.gestureRecognizers
        
        view.setNeedsUpdateConstraints()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.pageViewController.setViewControllers([viewControllers[selectedIndex]], direction: .Forward, animated: true, completion: {done in })
        
        for viewController in viewControllers {
            if let tabTitle = viewController.title {
                let label = UILabel()
                label.text = tabTitle
                self.view.addSubview(label)
            }
        }
    }
    
    // MARK: Constraints
    
    var didSetupConstraints = false
    
    override func updateViewConstraints() {
        if !didSetupConstraints {
            view.addConstraint(NSLayoutConstraint(item: pageViewController.view, attribute: .Top, relatedBy: .Equal, toItem: topLayoutGuide, attribute: .Bottom, multiplier: 1, constant: 0))
            view.addConstraint(NSLayoutConstraint(item: pageViewController.view, attribute: .Bottom, relatedBy: .Equal, toItem: bottomLayoutGuide, attribute: .Top, multiplier: 1, constant: 0))
            view.addConstraint(NSLayoutConstraint(item: pageViewController.view, attribute: .Right, relatedBy: .Equal, toItem: view, attribute: .Right, multiplier: 1, constant: 0))
            view.addConstraint(NSLayoutConstraint(item: pageViewController.view, attribute: .Left, relatedBy: .Equal, toItem: view, attribute: .Left, multiplier: 1, constant: 0))

            
            didSetupConstraints = true
        }
        
        super.updateViewConstraints()
    }
    
    // MARK: UIPageViewControllerDataSource
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        if let index = find(viewControllers, viewController) {
            return index > 0 ? viewControllers[index - 1] : nil
        } else {
            return nil
        }
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        if let index = find(viewControllers, viewController) {
            return index >= viewControllers.count - 1 ? nil : viewControllers[index + 1]
        } else {
            return nil
        }
    }
    
    // MARK: UIScrollViewDelegate
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let xFromCenter = self.view.frame.size.width - scrollView.contentOffset.x
        println(xFromCenter)
    }
    
}


