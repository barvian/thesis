//
//  Mood.swift
//  Thesis
//
//  Created by Maxwell Barvian on 2/10/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

@objc enum Mood: Int {
	case 😊 = 1
	case 😐 = 2
	case 😖 = 3
	
	static let allValues = [😊, 😐, 😖]
	
	var description: String {
		switch self {
		case .😊: return "😊"
		case .😐: return "😐"
		case .😖: return "😖"
		}
	}
}
