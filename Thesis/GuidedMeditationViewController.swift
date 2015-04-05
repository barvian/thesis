//
//  GuidedMeditationViewController.swift
//  Thesis
//
//  Created by Maxwell Barvian on 3/2/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit
import Async
import AVFoundation
import MediaPlayer

public let 🎧 = NSBundle.mainBundle().pathForResource("Meditation", ofType: "mp3")!

class GuidedMeditationViewController: UIViewController, FullScreenViewController, RelaxationViewController, AVAudioPlayerDelegate {
	
	weak var relaxationDelegate: RelaxationViewControllerDelegate?
	
	let tintColor = UIColor.whiteColor()
	let backgroundColor = UIColor.applicationDarkColor()
	let tabColor = UIColor.clearColor()
	let selectedTabColor = UIColor.clearColor()
	
	let navigationBarHidden = true
	let navigationBarTranslucent = true
	
	private(set) lazy var player: AVAudioPlayer = {
		let fileURL = NSURL(fileURLWithPath: 🎧)
		let player = AVAudioPlayer(contentsOfURL: fileURL, error: nil)
		player.delegate = self
		player.numberOfLoops = -1
		
		return player
	}()
	
	private(set) var showingInstructions = true
	
	private(set) lazy var titleLabel: UILabel = {
		let label = UILabel.applicationHeaderLabel()
		label.text = "Guided Meditation"
		label.setTranslatesAutoresizingMaskIntoConstraints(false)
		label.textColor = UIColor.whiteColor()
		
		return label
	}()
	
	private(set) lazy var instructionsLabel: UILabel = {
		let label = UILabel.applicationSubheaderLabel()
		label.text = "Tap the play button below and follow the instructions.  Headphones may work best with this exercise."
		label.setTranslatesAutoresizingMaskIntoConstraints(false)
		label.textColor = UIColor.whiteColor().colorWithAlphaComponent(0.85)
		
		return label
	}()
	
	private(set) lazy var audioButton: ChunkyButton = {
		let button = ChunkyButton()
		button.setTranslatesAutoresizingMaskIntoConstraints(false)
		button.tintColor = UIColor.applicationBaseColor()
		button.setImage(UIImage(named: "Play")?.imageWithRenderingMode(.AlwaysTemplate), forState: .Normal)
		button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -6)
		button.zIndex = 2
		
		button.addTarget(self, action: "didTapAudioButton:", forControlEvents: .TouchUpInside)
		
		return button
	}()
	
	private(set) lazy var progressButton: UIButton = {
		let button = UIButton.buttonWithType(.System) as! UIButton
		button.setTranslatesAutoresizingMaskIntoConstraints(false)
		button.tintColor = UIColor.whiteColor()
		
		button.addTarget(self, action: "didTapProgressButton:", forControlEvents: .TouchUpInside)
		
		return button
	}()
	
	private(set) lazy var spacerViews: [UIView] = {
		let spacers = [UIView(), UIView()]
		for spacer in spacers {
			spacer.setTranslatesAutoresizingMaskIntoConstraints(false)
			spacer.hidden = true
		}
		
		return spacers
	}()
	
	override func prefersStatusBarHidden() -> Bool {
		return !showingInstructions
	}
	
	override func preferredStatusBarStyle() -> UIStatusBarStyle {
		return .LightContent
	}
	
	convenience override init() {
		self.init(nibName: nil, bundle: nil)
		
		title = "Guided Meditation"
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.addSubview(titleLabel)
		view.addSubview(instructionsLabel)
		view.addSubview(spacerViews[0])
		view.addSubview(audioButton)
		view.addSubview(spacerViews[1])
		view.addSubview(progressButton)
		
		AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, error: nil)
		AVAudioSession.sharedInstance().setActive(true, error: nil)
		
		player.prepareToPlay()
		
		setupFullScreenControllerView(self)
	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		
		shouldUpdateProgressButton()
		
		updateFullScreenControllerColors(self, animated: false)
		hideFullScreenControllerNavigationBar(self, animated: false)
	}
	
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		
		becomeFirstResponder()
		UIApplication.sharedApplication().beginReceivingRemoteControlEvents()
	}
	
	override func remoteControlReceivedWithEvent(event: UIEvent) {
		super.remoteControlReceivedWithEvent(event)
		
		switch event.subtype {
		case .RemoteControlTogglePlayPause:
			togglePlayback()
		case .RemoteControlPlay:
			togglePlayback(true)
		case .RemoteControlPause:
			togglePlayback(false)
		default:
			break
		}
	}
	
	override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
		super.touchesEnded(touches, withEvent: event)
		
		if player.playing {
			toggleInstructions(timer: 5)
		}
	}
	
	// MARK: API
	
	private var _hideBlock: Async?
	
	func toggleInstructions(_ state: Bool? = nil, timer: Double? = nil) {
		showingInstructions = state != nil ? state! : !showingInstructions
		let alpha: CGFloat = showingInstructions ? 1.0 : 0.0
		
		UIView.animateWithDuration(0.33) {
			self.titleLabel.alpha = alpha
			self.instructionsLabel.alpha = alpha
			self.progressButton.alpha = alpha
			self.setNeedsStatusBarAppearanceUpdate()
		}
		
		_hideBlock?.cancel()
		if showingInstructions && timer != nil {
			_hideBlock = Async.main(after: timer!) {
				self.toggleInstructions(false)
			}
		}
	}
	
	func togglePlayback(_ state: Bool? = nil) {
		if (state != nil && state! == false) || player.playing {
			player.pause()
			audioButton.setImage(UIImage(named: "Play")?.imageWithRenderingMode(.AlwaysTemplate), forState: .Normal)
		} else {
			player.play()
			audioButton.setImage(UIImage(named: "Pause")?.imageWithRenderingMode(.AlwaysTemplate), forState: .Normal)
			let mpic = MPNowPlayingInfoCenter.defaultCenter()
			mpic.nowPlayingInfo = [
				MPMediaItemPropertyTitle: "Guided Meditation",
				MPMediaItemPropertyArtist: "Sam Harris"
			]
		}
		
		toggleInstructions(!player.playing)
	}
	
	// MARK: Constraints
	
	private var _didSetupConstraints = false
	
	override func updateViewConstraints() {
		if !_didSetupConstraints {
			setupFullScreenControllerViewConstraints(self)
			
			let views: [NSObject: AnyObject] = [
				"titleLabel": titleLabel,
				"instructionsLabel": instructionsLabel,
				"spacer1": spacerViews[0],
				"audioButton": audioButton,
				"spacer2": spacerViews[1],
				"progressButton": progressButton
			]
			
			let vMargin: CGFloat = 34, hMargin: CGFloat = 26
			let metrics = [
				"vMargin": vMargin,
				"hMargin": hMargin
			]
			
			view.addConstraint(NSLayoutConstraint(item: progressButton, attribute: .Bottom, relatedBy: .Equal, toItem: bottomLayoutGuide, attribute: .Top, multiplier: 1, constant: -vMargin))
			view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-(54)-[titleLabel]-[instructionsLabel][spacer1(>=0)][audioButton(120)][spacer2(==spacer1)][progressButton]", options: nil, metrics: metrics, views: views))
			view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(hMargin)-[titleLabel]-(hMargin)-|", options: nil, metrics: metrics, views: views))
			view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(hMargin)-[instructionsLabel]-(hMargin)-|", options: nil, metrics: metrics, views: views))
			view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[spacer1(0,==spacer2)]", options: nil, metrics: metrics, views: views))
			view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[audioButton(120)]", options: nil, metrics: metrics, views: views))
			for (_, subview) in views {
				view.addConstraint(NSLayoutConstraint(item: subview, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0))
			}
			
			_didSetupConstraints = true
		}
		
		super.updateViewConstraints()
	}
	
	// MARK: Handlers
	
	func didTapAudioButton(button: UIButton!) {
		togglePlayback()
	}
	
	func didTapProgressButton(button: UIButton!) {
		togglePlayback(false)
		relaxationDelegate?.relaxationViewControllerDidTapProgressButton?(self)
	}
	
	// MARK: RelaxationViewControllerDelegate
	
	func shouldUpdateProgressButton() {
		relaxationViewController(self, shouldUpdateProgressButton: progressButton)
	}
	
	// MARK: AVAudioPlayerDelegate
	
	func audioPlayerDidFinishPlaying(player: AVAudioPlayer!, successfully flag: Bool) {
		if flag {
			player.stop()
			player.prepareToPlay()
			player.currentTime = 0
		}
	}
	
	func audioPlayerBeginInterruption(player: AVAudioPlayer!) {
		togglePlayback(false)
	}
	
	func audioPlayerEndInterruption(player: AVAudioPlayer!) {
		togglePlayback(true)
	}
	
	// MARK: Deinitializers
	
	deinit {
		_hideBlock?.cancel()
	}
	
}