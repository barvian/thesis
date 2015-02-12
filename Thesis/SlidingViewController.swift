//
//  SlidingViewController.swift
//  Thesis
//
//  Created by WSOL Intern on 2/11/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit

@objc protocol SlidingViewControllerDelegate {
    optional func slidingViewController(slidingViewController: SlidingViewController, willTransitionToViewControllers pendingViewControllers: [UIViewController])
    optional func slidingViewController(slidingViewController: SlidingViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool)
    optional func slidingViewController(slidingViewController: SlidingViewController, isTransitioningToViewControllers pendingViewControllers: [UIViewController], percentComplete: CGFloat)
}

class SlidingViewController: UIViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource, UIScrollViewDelegate {
    
    weak var delegate: SlidingViewControllerDelegate?
    
    private var _viewDidAppear = false
    
    var viewControllers: [UIViewController]! {
        willSet {
            if viewControllers != nil {
                let previousViewController = viewControllers[_selectedIndex]
                if let newIndex = find(newValue, previousViewController) {
                    _selectedIndex = newIndex
                } else if _selectedIndex >= newValue.count - 1 {
                    _selectedIndex = 0
                }
            }
            
            pageViewController.setViewControllers([newValue[_selectedIndex]], direction: .Forward, animated: false, completion: nil)
        }
    }
    
    private var _selectedIndex = 0
    var selectedIndex: Int {
        get {
            return _selectedIndex
        }
        set(newIndex) {
            if viewControllers != nil {
                pageViewController.setViewControllers([viewControllers[newIndex]], direction: (newIndex < _selectedIndex) ? .Reverse : .Forward, animated: _viewDidAppear && (newIndex != _selectedIndex), completion: nil)
                
                _selectedIndex = newIndex
            }
        }
    }
    
    var selectedViewController: UIViewController? {
        get {
            return viewControllers == nil || _selectedIndex >= viewControllers.count ? nil : viewControllers[_selectedIndex]
        }
        set(newController) {
            if let selected = newController {
                if let newIndex = find(viewControllers, selected) {
                    selectedIndex = newIndex
                }
            }
        }
    }
    
    var paginated: Bool = false
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildViewController(pageViewController)
        view.addSubview(pageViewController.view)
        
        // Set the page view controller's bounds using an inset rect so that self's view is visible around the edges of the pages.
        var pageViewRect = self.view.bounds
        self.pageViewController!.view.frame = pageViewRect
        
        pageViewController.didMoveToParentViewController(self)
        
        // Add the page view controller's gesture recognizers to the book view controller's view so that the gestures are started more easily.
        self.view.gestureRecognizers = self.pageViewController.gestureRecognizers
        
        view.setNeedsUpdateConstraints()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        _viewDidAppear = true
    }
    
    // MARK: Constraints
    
    private var didSetupConstraints = false
    
    override func updateViewConstraints() {
        if !didSetupConstraints {
            didSetupConstraints = true
        }
        
        super.updateViewConstraints()
    }
    
    // MARK: UIPageViewControllerDataSource
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return paginated ? viewControllers.count : 0
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
    
    // MARK: UIPageViewControllerDelegate
    
    private var _pendingViewControllers: [UIViewController]!
    
    func pageViewController(pageViewController: UIPageViewController, willTransitionToViewControllers pendingViewControllers: [AnyObject]) {
        _pendingViewControllers = pendingViewControllers as [UIViewController]
        delegate?.slidingViewController?(self, willTransitionToViewControllers: _pendingViewControllers)
    }
    
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [AnyObject], transitionCompleted completed: Bool) {
        _pendingViewControllers = nil
        
        if completed {
            _selectedIndex = find(viewControllers, pageViewController.viewControllers.last! as UIViewController)!
        }
        
        delegate?.slidingViewController?(self, didFinishAnimating: finished, previousViewControllers: previousViewControllers as [UIViewController], transitionCompleted: completed)
    }
    
    // MARK: UIScrollViewDelegate
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let xFromCenter = self.view.frame.size.width - scrollView.contentOffset.x
        let percentComplete = abs(xFromCenter / self.view.frame.size.width)
        
        if let pendingViewControllers = _pendingViewControllers {
            delegate?.slidingViewController?(self, isTransitioningToViewControllers: pendingViewControllers, percentComplete: percentComplete)
        }
    }
    
}


