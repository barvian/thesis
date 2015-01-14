//
//  RelaxViewController.swift
//  Thesis
//
//  Created by WSOL Intern on 1/12/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit
import Snap

class RelaxViewController: UIViewController {
    
    convenience override init() {
        self.init(nibName: nil, bundle: nil)
        title = "Relax"
    }
    
    override func loadView() {
        self.view = RelaxView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
}
