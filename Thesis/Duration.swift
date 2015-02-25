//
//  Duration.swift
//  Thesis
//
//  Created by Maxwell Barvian on 2/23/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

@objc enum Duration: Int {
	case Short = 5
	case Moderate = 10
	case Long = 20
	
	static let allValues = [Short, Moderate, Long]
	
	var description: String {
		switch self {
		case .Short: return "Short"
		case .Moderate: return "Moderate"
		case .Long: return "Long"
		}
	}
}
