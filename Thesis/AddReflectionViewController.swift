//
//  AddReflectionViewController.swift
//  Thesis
//
//  Created by Maxwell Barvian on 2/5/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit

@objc protocol AddReflectionViewControllerDelegate {
	optional func addReflectionViewController(addReflectionViewController: AddReflectionViewController, didFinishTypingEvent eventText: String!, reason reasonText: String!)
	optional func addReflectionViewControllerShouldCancel(addReflectionViewController: AddReflectionViewController)
}

class AddReflectionViewController: FullScreenViewController, UITextViewDelegate {
	
	weak var delegate: AddReflectionViewControllerDelegate?
	
	private(set) lazy var eventPage: AddReflectionPageView = {
		let eventPage = AddReflectionPageView()
		eventPage.setTranslatesAutoresizingMaskIntoConstraints(false)
		eventPage.headlineLabel.text = "What went well today?"
		eventPage.textView.returnKeyType = .Next
		eventPage.textView.delegate = self
		
		return eventPage
	}()
	
	private(set) lazy var reasonPage: AddReflectionPageView = {
		let reasonPage = AddReflectionPageView()
		reasonPage.setTranslatesAutoresizingMaskIntoConstraints(false)
		reasonPage.headlineLabel.text = "Why did it go well?"
		reasonPage.textView.returnKeyType = .Done
		reasonPage.textView.delegate = self
		
		return reasonPage
	}()
	
	convenience override init() {
		self.init(nibName: nil, bundle: nil)
		
		backgroundColor = UIColor.whiteColor()
		tintColor = UIColor.applicationGreenColor()
		navigationBarHidden = false
		navigationBarTranslucent = true
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		NSNotificationCenter.defaultCenter().addObserver(self, selector:"keyboardWillChangeFrame:", name: UIKeyboardWillChangeFrameNotification, object: nil)
		
		navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: "didTapCancel")
		
		view.addSubview(eventPage)
		view.addSubview(reasonPage)
		
		view.setNeedsUpdateConstraints() // bootstrap AutoLayout
	}
	
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		
		eventPage.textView.becomeFirstResponder()
	}
	
	// MARK: Constraints
	
	private var didSetupConstraints = false
	private var keyboardDelta: CGFloat?
	private var keyboardDuration: CGFloat?
	
	private var bottomLayoutConstraint: NSLayoutConstraint!
	
	override func updateViewConstraints() {
		if !didSetupConstraints {
			let views = [
				"eventPage": eventPage,
				"reasonPage": reasonPage
			]
			
			view.addConstraint(NSLayoutConstraint(item: eventPage, attribute: .Top, relatedBy: .Equal, toItem: topLayoutGuide, attribute: .Bottom, multiplier: 1, constant: 0))
			view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[eventPage][reasonPage(==eventPage)]", options: nil, metrics: nil, views: views))
			view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[eventPage]|", options: nil, metrics: nil, views: views))
			view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[reasonPage]|", options: nil, metrics: nil, views: views))
			bottomLayoutConstraint = NSLayoutConstraint(item: reasonPage, attribute: .Bottom, relatedBy: .Equal, toItem: bottomLayoutGuide, attribute: .Top, multiplier: 1, constant: 0)
			view.addConstraint(bottomLayoutConstraint)
			
			didSetupConstraints = true
		}
		
		if let keyboardDelta = keyboardDelta {
			bottomLayoutConstraint.constant = keyboardDelta
		}
		
		super.updateViewConstraints()
	}
	
	// MARK: Handlers
	
	func didTapCancel() {
		delegate?.addReflectionViewControllerShouldCancel?(self)
	}
	
	func keyboardWillChangeFrame(notification: NSNotification) {
		let userInfo = notification.userInfo!
		var animationCurve = UIViewAnimationOptions.CurveEaseOut
		(userInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).getValue(&animationCurve)
		let duration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSValue) as! Double
		let keyboardEndFrame = view.convertRect((userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue(), fromView: view.window)
		let keyboardBeginFrame = view.convertRect((userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue(), fromView: view.window)
		keyboardDelta = keyboardEndFrame.origin.y - keyboardBeginFrame.origin.y
		
		view.setNeedsUpdateConstraints()
		view.updateConstraintsIfNeeded()
		
		UIView.animateWithDuration(duration, delay: 0, options: animationCurve, animations: {
			self.view.layoutIfNeeded()
			}, completion: nil)
	}
	
	// MARK: UITextFieldDelegate
	
	func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
		switch (text, textView.returnKeyType) {
		case ("\n", .Next):
			reasonPage.textView.becomeFirstResponder()
			return false
		case ("\n", .Done):
			delegate?.addReflectionViewController?(self, didFinishTypingEvent: eventPage.textView.text, reason: reasonPage.textView.text)
			return false
		default:
			return true
		}
	}
	
	func textFieldShouldReturn(textField: UITextField) -> Bool {
		
		textField.resignFirstResponder()
		
		return true
	}
	
	// MARK: Deinitializer
	
	deinit {
		NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillChangeFrameNotification, object: nil)
	}
	
}
