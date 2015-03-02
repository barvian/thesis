//
//  OnboardingSlide+ConfigureForDictionary.swift
//  Thesis
//
//  Created by Maxwell Barvian on 3/1/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

extension OnboardingSlide {
	
	func configureForSlide(slide: NSDictionary) {
		headerLabel.text = slide["Header"] as? String
		subheaderLabel.text = slide["Subheader"] as? String
	}
	
}
