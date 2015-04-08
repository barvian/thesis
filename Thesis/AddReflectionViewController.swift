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

class AddReflectionViewController: UIViewController, FullScreenViewController, UITextViewDelegate {
	
	weak var delegate: AddReflectionViewControllerDelegate?
	
	let backgroundColor = UIColor.whiteColor()
	let tintColor = UIColor.applicationGreenColor()
	let tabColor = UIColor(r: 178, g: 186, b: 196)
	let selectedTabColor = UIColor.applicationBaseColor()
	
	let navigationBarHidden = false
	let navigationBarTranslucent = true
	
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
	
	convenience init() {
		self.init(nibName: nil, bundle: nil)
		
		NSNotificationCenter.defaultCenter().addObserver(self, selector:"keyboardWillChangeFrame:", name: UIKeyboardWillChangeFrameNotification, object: nil)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: "didTapCancel")
		
		view.addSubview(eventPage)
		view.addSubview(reasonPage)
		
		setupFullScreenControllerView(self)
		
		view.setNeedsUpdateConstraints() // bootstrap AutoLayout
	}
	
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		
		eventPage.textView.becomeFirstResponder()
	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		
		updateFullScreenControllerColors(self, animated: animated)
		hideFullScreenControllerNavigationBar(self, animated: false)
	}
	
	override func viewDidDisappear(animated: Bool) {
		super.viewDidDisappear(animated)
		
		unhideFullScreenControllerNavigationBar(self, animated: false)
	}
	
	// MARK: Constraints
	
	private var _didSetupConstraints = false
	private var _keyboardDelta: CGFloat?
	private var _keyboardDuration: CGFloat?
	
	private var _bottomLayoutConstraint: NSLayoutConstraint!
	
	override func updateViewConstraints() {
		if !_didSetupConstraints {
			setupFullScreenControllerViewConstraints(self)
			
			let views: [NSObject: AnyObject] = [
				"topLayoutGuide": topLayoutGuide,
				"eventPage": eventPage,
				"reasonPage": reasonPage
			]
			
			view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[topLayoutGuide][eventPage][reasonPage(==eventPage)]", options: nil, metrics: nil, views: views))
			view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[eventPage]|", options: nil, metrics: nil, views: views))
			view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[reasonPage]|", options: nil, metrics: nil, views: views))
			_bottomLayoutConstraint = NSLayoutConstraint(item: reasonPage, attribute: .Bottom, relatedBy: .Equal, toItem: bottomLayoutGuide, attribute: .Top, multiplier: 1, constant: 0)
			view.addConstraint(_bottomLayoutConstraint)
			
			_didSetupConstraints = true
		}
		
		if let keyboardDelta = _keyboardDelta {
			_bottomLayoutConstraint.constant = keyboardDelta
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
		_keyboardDelta = keyboardEndFrame.origin.y - keyboardBeginFrame.origin.y
		
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
