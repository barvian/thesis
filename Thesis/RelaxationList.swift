//
//  RelaxationList.swift
//  Thesis
//
//  Created by Maxwell Barvian on 3/2/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

struct RelaxationList: SequenceType {

	private let relaxations: [AnyClass]
	
	var count: Int {
		return relaxations.count
	}
	
	var description: String {
		return relaxations.description
	}
	
	init(mood: Mood, duration: Duration) {
		switch(mood, duration) {
		case (.😊, .Long): relaxations = [CalmingScenesViewController.self, GuidedMeditationViewController.self]
		case (.😊, .Moderate): relaxations = [GuidedMeditationViewController.self]
		case (.😊, .Short): relaxations = [CalmingScenesViewController.self]
			
		case (.😐, .Long): relaxations = [DeepBreathingViewController.self, CalmingScenesViewController.self, GuidedMeditationViewController.self]
		case (.😐, .Moderate): relaxations = [DeepBreathingViewController.self, CalmingScenesViewController.self]
		case (.😐, .Short): relaxations = [DeepBreathingViewController.self]
		
		case (.😖, .Long): relaxations = [StatementsViewController.self, DeepBreathingViewController.self, CalmingScenesViewController.self]
		case (.😖, .Moderate): relaxations = [StatementsViewController.self, DeepBreathingViewController.self]
		case (.😖, .Short): relaxations = [StatementsViewController.self]
		}
	}
	
}

extension RelaxationList: SequenceType {
	typealias RelaxationGenerator = GeneratorOf<AnyClass>
	
	func generate() -> RelaxationGenerator {
		return GeneratorOf(relaxations.generate())
	}
}

extension RelaxationList: CollectionType {
	typealias Index = Int
	
	var startIndex: Int {
		return 0
	}
	
	var endIndex: Int {
		return count - 1
	}
	
	subscript(i: Int) -> AnyClass {
		return relaxations[i]
	}
}