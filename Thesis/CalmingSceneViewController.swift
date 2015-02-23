//
//  CalmingSceneViewController.swift
//  Thesis
//
//  Created by Maxwell Barvian on 2/23/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit
import CoreMotion
import AVFoundation

@objc protocol CalmingSceneViewControllerDelegate {
	optional func calmingSceneViewController(calmingSceneViewController: CalmingSceneViewController, didEndTouches touches: Set<NSObject>, withEvent event: UIEvent)
}

class CalmingSceneViewController: UIViewController {
	
	weak var delegate: CalmingSceneViewControllerDelegate?
	
	let scene: String
	let motionManager: CMMotionManager
	
	var playerItem: AVPlayerItem!
	let naturalSize: CGSize
	
	private(set) lazy var playerLayer: AVPlayerLayer! = {
		let player = AVPlayer(playerItem: self.playerItem)
		player.actionAtItemEnd = .None
		let layer = AVPlayerLayer(player: player)
		layer.videoGravity = AVLayerVideoGravityResize
		
		return layer
		}()
	
	let movementSmoothing = 0.3
	let animationDuration = 0.3
	let rotationMultiplier = 5.0
	
	init(scene: String, motionManager: CMMotionManager) {
		self.scene = scene
		self.motionManager = motionManager
		
		let path = scenesPath.stringByAppendingPathComponent(scene)
		self.playerItem = AVPlayerItem(URL: NSURL(fileURLWithPath: path)!)
		let track = playerItem.asset.tracksWithMediaType(AVMediaTypeVideo).first as! AVAssetTrack
		naturalSize = CGSizeApplyAffineTransform(track.naturalSize, track.preferredTransform)
		
		super.init(nibName: nil, bundle: nil)
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "playerItemDidReachEnd:", name: AVPlayerItemDidPlayToEndTimeNotification, object: playerItem)
		
		view.layer.addSublayer(playerLayer)
		view.layer.masksToBounds = true
	}
	
	override func viewDidAppear(animated: Bool) {
		playerLayer.player.play()
		
		motionManager.startDeviceMotionUpdatesToQueue(NSOperationQueue.mainQueue()) {
			[unowned self] (data: CMDeviceMotion!, error: NSError!) in
			
			self.calculateRotationBasedOnDeviceMotionRotationRate(data)
		}
	}
	
	override func viewWillDisappear(animated: Bool) {
		playerLayer.player.pause()
		
		motionManager.stopDeviceMotionUpdates()
	}
	
	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
		
		let bounds = CGRectMake(0, 0, (view.bounds.height / naturalSize.height) * naturalSize.width, view.bounds.height)
		playerLayer.bounds = bounds
		playerLayer.position = view.center
	}
	
	override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
		super.touchesEnded(touches, withEvent: event)
		
		delegate?.calmingSceneViewController?(self, didEndTouches: touches, withEvent: event)
	}
	
	func calculateRotationBasedOnDeviceMotionRotationRate(motion: CMDeviceMotion!) {
		let xRotationRate = motion.rotationRate.x
		let yRotationRate = motion.rotationRate.y
		let zRotationRate = motion.rotationRate.z
		
		if fabs(yRotationRate) > (fabs(xRotationRate) + fabs(zRotationRate)) {
			let contentOffset = CGFloat(yRotationRate * rotationMultiplier)
			
			UIView.animateWithDuration(movementSmoothing, delay: 0, options: .BeginFromCurrentState | .AllowUserInteraction | .CurveEaseOut, animations: {
				var frame = self.playerLayer.frame
				let clampedX = max(self.view.frame.width - frame.width, min(0, frame.origin.x + contentOffset))
				self.playerLayer.frame = CGRectMake(clampedX, frame.origin.y, frame.width, frame.height)
				}, completion: nil)
		}
	}
	
	// MARK: Handlers
	
	func playerItemDidReachEnd(notification: NSNotification) {
		let p = notification.object as! AVPlayerItem
		p.seekToTime(kCMTimeZero)
	}
	
	// MARK: Deinitializer
	
	deinit {
		NSNotificationCenter.defaultCenter().removeObserver(self, name: AVPlayerItemDidPlayToEndTimeNotification, object: nil)
	}
	
}
