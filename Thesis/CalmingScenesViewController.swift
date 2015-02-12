//
//  CalmingScenesViewController.swift
//  Thesis
//
//  Created by Maxwell Barvian on 2/11/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit
import AVFoundation
import CoreMotion

public let scenesPath = NSBundle.mainBundle().resourcePath!.stringByAppendingPathComponent("Scenes")
public let scenes: [String]? = {
    var error: NSError? = nil
    let files = NSFileManager.defaultManager().contentsOfDirectoryAtPath(scenesPath, error: &error) as? [String]
    
    return files
}()

class CalmingSceneViewController: UIViewController {
    
    let scene: String
    // let motionManager: CMMotionManager
    
    let playerItem: AVPlayerItem!
    let naturalSize: CGSize
    
    private(set) lazy var playerLayer: AVPlayerLayer! = {
        let player = AVPlayer(playerItem: self.playerItem)
        player.actionAtItemEnd = .None
        let layer = AVPlayerLayer(player: player)
        layer.videoGravity = AVLayerVideoGravityResizeAspectFill
        
        return layer
    }()
    
    /*let movementSmoothing = 0.3
    let animationDuration = 0.3
    let rotationMultiplier = 5.0*/
    
    init(scene: String/*, motionManager: CMMotionManager*/) {
        self.scene = scene
        // self.motionManager = motionManager
        
        let path = scenesPath.stringByAppendingPathComponent(scene)
        self.playerItem = AVPlayerItem(URL: NSURL(fileURLWithPath: path)!)
        let track = playerItem.asset.tracksWithMediaType(AVMediaTypeVideo).first as AVAssetTrack
        naturalSize = CGSizeApplyAffineTransform(track.naturalSize, track.preferredTransform)
        
        super.init(nibName: nil, bundle: nil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "playerItemDidReachEnd:", name: AVPlayerItemDidPlayToEndTimeNotification, object: playerItem)
        
        view.layer.addSublayer(playerLayer)
    }
    
    override func viewDidAppear(animated: Bool) {
        playerLayer.player.play()
        
        /*motionManager.startDeviceMotionUpdatesToQueue(NSOperationQueue.mainQueue(), withHandler: { println($0); return   })
        motionManager.startDeviceMotionUpdatesToQueue(NSOperationQueue.mainQueue()) {
            [unowned self] (data: CMDeviceMotion!, error: NSError!) in
            
            self.calculateRotationBasedOnDeviceMotionRotationRate(data)
        }*/
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        // let bounds = CGSizeMake(view.bounds.height / naturalSize.height * naturalSize.width, view.bounds.height)
        playerLayer.bounds = view.bounds
        playerLayer.position = view.center
    }
    
    /*func calculateRotationBasedOnDeviceMotionRotationRate(motion: CMDeviceMotion!) {
        let xRotationRate = motion.rotationRate.x
        let yRotationRate = motion.rotationRate.y
        let zRotationRate = motion.rotationRate.z
        
        if fabs(yRotationRate) > (fabs(xRotationRate) + fabs(zRotationRate)) {
            let contentOffset = CGFloat(yRotationRate * rotationMultiplier)
            
            UIView.animateWithDuration(movementSmoothing, delay: 0, options: .BeginFromCurrentState | .AllowUserInteraction | .CurveEaseOut, animations: {
                var frame = self.playerLayer.frame
                let clampedX = max(0.0, min(self.view.frame.width - frame.width, frame.origin.x + contentOffset))
                self.playerLayer.frame = CGRectMake(frame.origin.x + contentOffset, frame.origin.y, frame.width, frame.height)
            }, completion: nil)
        }
    }*/
    
    // MARK: Handlers
    
    func playerItemDidReachEnd(notification: NSNotification) {
        let p = notification.object as AVPlayerItem
        p.seekToTime(kCMTimeZero)
    }
    
    // MARK: Deinitializer
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: AVPlayerItemDidPlayToEndTimeNotification, object: nil)
        // motionManager.stopDeviceMotionUpdates()
    }
    
}

class CalmingScenesViewController: SlidingViewController {
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    convenience override init() {
        self.init(nibName: nil, bundle: nil)
        
        title = "Calming Scenes"
        // let motionManager = CMMotionManager()
        viewControllers = scenes?.map { CalmingSceneViewController(scene: $0/*, motionManager: motionManager*/) }
        selectedIndex = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}