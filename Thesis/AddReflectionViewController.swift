//
//  AddReflectionViewController.swift
//  Thesis
//
//  Created by Maxwell Barvian on 2/5/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit

@objc protocol AddReflectionViewControllerDelegate {
    optional func didFinishTypingEvent(typedText: String!)
}

class AddReflectionViewController: UIViewController, UITextFieldDelegate {
    
    weak var delegate: AddReflectionViewControllerDelegate?
    
    private(set) lazy var textField: UITextField = {
        let textField = UITextField()
        textField.setTranslatesAutoresizingMaskIntoConstraints(false)
        textField.returnKeyType = .Done
        textField.placeholder = "What went well today?"
        textField.delegate = self
        
        return textField
    }()
    
    convenience override init() {
        self.init(nibName: nil, bundle: nil)
        
        title = "New Reflection"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.whiteColor()
        view.addSubview(textField)
        
        view.setNeedsUpdateConstraints() // bootstrap AutoLayout
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        textField.becomeFirstResponder()
    }
    
    // MARK: Constraints
    
    private var didSetupConstraints = false
    
    override func updateViewConstraints() {
        if !didSetupConstraints {
            let views = [
                "textField": textField
            ]
            let metrics = [
                "margin": 12
            ]
            
            view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[textField]|", options: nil, metrics: metrics, views: views))
            view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|-(margin)-[textField]-(margin)-|", options: nil, metrics: metrics, views: views))
            
            didSetupConstraints = true
        }
        
        super.updateViewConstraints()
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        delegate?.didFinishTypingEvent?(textField.text)
        dismissViewControllerAnimated(true, completion: nil)
        textField.resignFirstResponder()
        
        return true
    }
    
}
