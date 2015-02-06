//
//  OnboardingViewController.swift
//  Thesis
//
//  Created by Maxwell Barvian on 1/25/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource, UIScrollViewDelegate {
    
    let viewControllers: [UIViewController] = [
        OnboardingWelcomeController(),
        OnboardingCompleteController()
    ]
    
    private(set) lazy var pageViewController: UIPageViewController! = {
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
    
    convenience override init() {
        self.init(nibName: nil, bundle: nil)
        
        title = "Welcome"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildViewController(pageViewController)
        view.addSubview(pageViewController.view)
        
        pageViewController.didMoveToParentViewController(self)
        pageViewController.setViewControllers([viewControllers[0]], direction: .Forward, animated: true, completion: nil)
        
        // Add the page view controller's gesture recognizers to the book view controller's view so that the gestures are started more easily.
        self.view.gestureRecognizers = self.pageViewController.gestureRecognizers
        
        view.setNeedsUpdateConstraints() // bootstrap AutoLayout
    }
    
    // MARK: Constraints
    
    private var didSetupConstraints = false
    
    override func updateViewConstraints() {
        if !didSetupConstraints {
            view.addConstraint(NSLayoutConstraint(item: pageViewController.view, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1, constant: 0))
            view.addConstraint(NSLayoutConstraint(item: pageViewController.view, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1, constant: 0))
            view.addConstraint(NSLayoutConstraint(item: pageViewController.view, attribute: .Right, relatedBy: .Equal, toItem: view, attribute: .Right, multiplier: 1, constant: 0))
            view.addConstraint(NSLayoutConstraint(item: pageViewController.view, attribute: .Left, relatedBy: .Equal, toItem: view, attribute: .Left, multiplier: 1, constant: 0))
            
            didSetupConstraints = true
        }
        
        super.updateViewConstraints()
    }
    
    
    // MARK: UIPageViewControllerDataSource
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return viewControllers.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
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
