//
//  Relaxation.swift
//  Thesis
//
//  Created by Maxwell Barvian on 3/2/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

@objc enum Relaxation: Int {
	case DeepBreathing = 1
	case CalmingScenes = 2
	case GuidedMeditation = 3
	case Statements = 4
	
	static let allValues = [DeepBreathing, CalmingScenes, GuidedMeditation, Statements]
	
	var viewController: RelaxationViewController.Type {
		switch self {
		case .DeepBreathing: return DeepBreathingViewController.self
		case .CalmingScenes: return CalmingScenesViewController.self
		case .GuidedMeditation: return DeepBreathingViewController.self
		case .Statements: return StatementsViewController.self
		}
	}
}
