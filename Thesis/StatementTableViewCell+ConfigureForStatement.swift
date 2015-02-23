//
//  StatementTableViewCell+ConfigureForStatement.swift
//  Thesis
//
//  Created by Maxwell Barvian on 2/23/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit

extension StatementTableViewCell {
	
	func configureForStatement(statement: String, row: Int) {
		statementLabel.text = statement
		lineView.hidden = row == 0
	}
	
}
