//
//  RelaxViewController.swift
//  Thesis
//
//  Created by WSOL Intern on 1/12/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit

class RelaxViewController: UIViewController, RelaxViewDelegate {
    
    convenience override init() {
        self.init(nibName: nil, bundle: nil)
        
        title = "Relax"
    }
    
    override func loadView() {
        var view = RelaxView()
        view.delegate = self
        
        self.view = view
    }
        
    // MARK: RelaxViewDelegate
    
    func didTapGrowingButton() {
        (view as RelaxView).growButton()
        (UIApplication.sharedApplication().keyWindow?.rootViewController! as RootViewController).selectedIndex = 0
    }
    
}
