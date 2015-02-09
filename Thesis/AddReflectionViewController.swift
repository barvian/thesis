//
//  AddReflectionViewController.swift
//  Thesis
//
//  Created by Maxwell Barvian on 2/5/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit

@objc protocol AddReflectionViewControllerDelegate {
    optional func addReflectionViewController(addReflectionViewController: AddReflectionViewController, didFinishTyping typedText: String!)
    optional func addReflectionViewControllerShouldCancel(addReflectionViewController: AddReflectionViewController)
}

class AddReflectionViewController: UIViewController, UITextViewDelegate {
    
    weak var delegate: AddReflectionViewControllerDelegate?
    
    private(set) lazy var scrollViewContainer: UIView = {
        let container = UIView()
        container.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        return container
    }()
    
    private(set) lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.setTranslatesAutoresizingMaskIntoConstraints(false)
        scrollView.pagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        
        return scrollView
    }()
    
    private(set) lazy var scrollContentView: UIView = {
        let content = UIView()
        content.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        return content
    }()
    
    private(set) lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.setTranslatesAutoresizingMaskIntoConstraints(false)
        pageControl.numberOfPages = 2
        pageControl.currentPage = 0
        
        return pageControl
    }()
    
    private(set) lazy var eventPage: AddReflectionPageView = {
        let eventPage = AddReflectionPageView()
        eventPage.setTranslatesAutoresizingMaskIntoConstraints(false)
        eventPage.headlineLabel.text = "What went well?"
        eventPage.textView.returnKeyType = .Next
        
        return eventPage
    }()
    
    private(set) lazy var reasonPage: AddReflectionPageView = {
        let reasonPage = AddReflectionPageView()
        reasonPage.setTranslatesAutoresizingMaskIntoConstraints(false)
        reasonPage.headlineLabel.text = "Why did it go well?"
        reasonPage.textView.returnKeyType = .Done
        
        return reasonPage
    }()
    
    convenience override init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.translucent = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: "didTapCancel")
        
        view.backgroundColor = UIColor.whiteColor()
        scrollView.addSubview(scrollContentView)
        scrollViewContainer.addSubview(scrollView)
        view.addSubview(scrollViewContainer)
        view.addSubview(pageControl)
        
        scrollContentView.addSubview(eventPage)
        scrollContentView.addSubview(reasonPage)
        
        view.setNeedsUpdateConstraints() // bootstrap AutoLayout
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
//        textView.becomeFirstResponder()
    }
    
    // MARK: Constraints
    
    private var didSetupConstraints = false
    
    override func updateViewConstraints() {
        if !didSetupConstraints {
            let views = [
                "scrollViewContainer": scrollViewContainer,
                "scrollView": scrollView,
                "scrollContentView": scrollContentView,
                "eventPage": eventPage,
                "reasonPage": reasonPage,
                "pageControl": pageControl
            ]
            let metrics = [
                "margin": 26
            ]
            
            view.addConstraint(NSLayoutConstraint(item: scrollViewContainer, attribute: .Top, relatedBy: .Equal, toItem: topLayoutGuide, attribute: .Bottom, multiplier: 1, constant: 0))
            view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[scrollViewContainer][pageControl(52)]", options: nil, metrics: metrics, views: views))
            view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[scrollViewContainer]|", options: nil, metrics: metrics, views: views))
            view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[pageControl]|", options: nil, metrics: metrics, views: views))
            view.addConstraint(NSLayoutConstraint(item: pageControl, attribute: .Bottom, relatedBy: .Equal, toItem: bottomLayoutGuide, attribute: .Top, multiplier: 1, constant: 0))
            
            scrollViewContainer.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[scrollView]|", options: nil, metrics: metrics, views: views))
            scrollViewContainer.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[scrollView]|", options: nil, metrics: metrics, views: views))
            
            scrollView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[scrollContentView]|", options: nil, metrics: metrics, views: views))
            scrollView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[scrollContentView]|", options: nil, metrics: metrics, views: views))
            scrollViewContainer.addConstraint(NSLayoutConstraint(item: scrollContentView, attribute: .Height, relatedBy: .Equal, toItem: scrollViewContainer, attribute: .Height, multiplier: 1, constant: 0))
            scrollViewContainer.addConstraint(NSLayoutConstraint(item: scrollContentView, attribute: .Width, relatedBy: .Equal, toItem: scrollViewContainer, attribute: .Width, multiplier: CGFloat(pageControl.numberOfPages), constant: 0))
            
            scrollViewContainer.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[eventPage(==scrollViewContainer)]", options: nil, metrics: metrics, views: views))
            scrollContentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[reasonPage(==eventPage)]", options: nil, metrics: metrics, views: views))
            scrollViewContainer.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[eventPage(==scrollViewContainer)]", options: nil, metrics: metrics, views: views))
            scrollContentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[reasonPage(==eventPage)]", options: nil, metrics: metrics, views: views))
            scrollContentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[eventPage]", options: nil, metrics: metrics, views: views))
            scrollContentView.addConstraint(NSLayoutConstraint(item: reasonPage, attribute: .Top, relatedBy: .Equal, toItem: eventPage, attribute: .Top, multiplier: 1, constant: 0))
            scrollContentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[eventPage][reasonPage]", options: nil, metrics: metrics, views: views))
            
            didSetupConstraints = true
        }
        
        super.updateViewConstraints()
    }
    
    // MARK: Handlers
    
    func didTapCancel() {
        delegate?.addReflectionViewControllerShouldCancel?(self)
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        delegate?.addReflectionViewController?(self, didFinishTyping: textField.text)
        textField.resignFirstResponder()
        
        return true
    }
    
}
