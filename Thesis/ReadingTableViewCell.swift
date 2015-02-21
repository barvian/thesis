//
//  ReadingTableViewCell.swift
//  Thesis
//
//  Created by WSOL Intern on 2/9/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit
import SSDynamicText

class ReadingTableViewCell: UITableViewCell {
	
	private(set) lazy var titleLabel: UILabel = {
		let label = SSDynamicLabel(font: "HelveticaNeue", baseSize: 18.0)
		label.setTranslatesAutoresizingMaskIntoConstraints(false)
		label.textColor = UIColor.applicationBaseColor()
		label.lineBreakMode = .ByTruncatingTail
		label.numberOfLines = 0
		label.textAlignment = .Left
		
		return label
	}()
	
	private(set) lazy var descriptionLabel: UILabel = {
		let label = SSDynamicLabel(font: "HelveticaNeue", baseSize: 15.0)
		label.setTranslatesAutoresizingMaskIntoConstraints(false)
		label.textColor = UIColor(r: 149, g: 160, b: 176)
		label.lineBreakMode = .ByTruncatingTail
		label.numberOfLines = 0
		label.textAlignment = .Left
		
		return label
	}()
	
	private(set) lazy var borderView: UIView = {
		let line = UIView()
		line.setTranslatesAutoresizingMaskIntoConstraints(false)
		line.backgroundColor = UIColor.applicationBaseColor().colorWithAlphaComponent(0.25)
		
		return line
	}()
	
	// MARK: Initializers
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		selectionStyle = .None
		
		backgroundColor = UIColor.applicationLightColor()
		
		contentView.addSubview(titleLabel)
		contentView.addSubview(descriptionLabel)
		contentView.addSubview(borderView)
	}
	
	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	// MARK: Constraints
	
	override class func requiresConstraintBasedLayout() -> Bool {
		return true
	}
	
	private var didSetupConstraints = false
	private var descriptionLabelTopConstraint: NSLayoutConstraint!
	
	override func updateConstraints() {
		if !didSetupConstraints {
			let views = [
				"titleLabel": titleLabel,
				"descriptionLabel": descriptionLabel,
				"borderView": borderView
			]
			let metrics = [
				"padding": 18
			]
			
			contentView.bounds = CGRect(x: 0.0, y: 0.0, width: 99999.0, height: 99999.0)
			
			titleLabel.setContentCompressionResistancePriority(1000, forAxis: .Vertical)
			descriptionLabel.setContentCompressionResistancePriority(1000, forAxis: .Vertical)
			contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-(padding)-[titleLabel]", options: nil, metrics: metrics, views: views))
			contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[descriptionLabel]-(padding)-[borderView(0.5)]|", options: nil, metrics: metrics, views: views))
			descriptionLabelTopConstraint = NSLayoutConstraint(item: descriptionLabel, attribute: .Top, relatedBy: .Equal, toItem: titleLabel, attribute: .Bottom, multiplier: 1, constant: 0)
			contentView.addConstraint(descriptionLabelTopConstraint)
			contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(padding)-[titleLabel]-(padding)-|", options: nil, metrics: metrics, views: views))
			contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(padding)-[descriptionLabel]-(padding)-|", options: nil, metrics: metrics, views: views))
			contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[borderView]|", options: nil, metrics: metrics, views: views))
			
			didSetupConstraints = true
		}
		
		descriptionLabelTopConstraint.constant = descriptionLabel.hidden ? 0 : 8
		
		super.updateConstraints()
	}
	
	// MARK: API
	
	override func setHighlighted(highlighted: Bool, animated: Bool) {
		super.setHighlighted(highlighted, animated: animated)
		if (highlighted) {
			titleLabel.textColor = UIColor.whiteColor()
			descriptionLabel.textColor = UIColor.whiteColor().colorWithAlphaComponent(0.75)
			UIView.animateWithDuration(0.05) {
				self.contentView.backgroundColor = UIColor.applicationBaseColor()
			}
		} else {
			titleLabel.textColor = UIColor.applicationBaseColor()
			descriptionLabel.textColor = UIColor.applicationBaseColor().colorWithAlphaComponent(0.6)
			UIView.animateWithDuration(0.05) {
				self.contentView.backgroundColor = UIColor.applicationLightColor()
			}
		}
	}
	
}