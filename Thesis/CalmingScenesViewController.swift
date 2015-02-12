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
import SSDynamicText
import Async

public let scenesPath = NSBundle.mainBundle().resourcePath!.stringByAppendingPathComponent("Scenes")
public let scenes: [String]? = {
    var error: NSError? = nil
    let files = NSFileManager.defaultManager().contentsOfDirectoryAtPath(scenesPath, error: &error) as? [String]
    
    return files
}()

@objc protocol CalmingSceneViewControllerDelegate {
    optional func calmingSceneViewController(calmingSceneViewController: CalmingSceneViewController, didEndTouches touches: NSSet, withEvent event: UIEvent)
}

class CalmingSceneViewController: UIViewController {
    
    weak var delegate: CalmingSceneViewControllerDelegate?
    
    let scene: String
    let motionManager: CMMotionManager
    
    let playerItem: AVPlayerItem!
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
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
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
        let p = notification.object as AVPlayerItem
        p.seekToTime(kCMTimeZero)
    }
    
    // MARK: Deinitializer
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: AVPlayerItemDidPlayToEndTimeNotification, object: nil)
    }
    
}

class CalmingScenesViewController: SlidingViewController, CalmingSceneViewControllerDelegate, RelaxationController {
    
    weak var relaxationDelegate: RelaxationControllerDelegate?
    
    private(set) var showingInstructions = true
    
    private(set) lazy var vignetteView: UIImageView = {
        let vignette = UIImageView(image: UIImage(named: "Vignette"))
        vignette.contentMode = .ScaleToFill
        vignette.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        return vignette
    }()
    
    private(set) lazy var titleLabel: UILabel = {
        let label = SSDynamicLabel(font: "HelveticaNeue", baseSize: 23.0)
        label.text = "Calming Scene Meditation"
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        label.textColor = UIColor.whiteColor()
        label.numberOfLines = 0
        label.textAlignment = .Center
        
        label.layer.shadowOffset = CGSize(width: 0, height: 3)
        label.layer.shadowRadius = 4
        label.layer.shadowColor = UIColor.blackColor().CGColor
        label.layer.shadowOpacity = 0.1
        label.layer.shouldRasterize = true
        label.layer.rasterizationScale = UIScreen.mainScreen().scale
        
        return label
    }()
    
    private(set) lazy var instructionsLabel: UILabel = {
        let label = SSDynamicLabel(font: "HelveticaNeue", baseSize: 17.0)
        label.text = "Gently place your attention in the scene, allowing other thoughts to come and go with little effort."
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        label.textColor = UIColor.whiteColor().colorWithAlphaComponent(0.85)
        label.numberOfLines = 0
        label.textAlignment = .Center
        
        label.layer.shadowOffset = CGSize(width: 0, height: 2)
        label.layer.shadowRadius = 3
        label.layer.shadowColor = UIColor.blackColor().CGColor
        label.layer.shadowOpacity = 0.1
        label.layer.shouldRasterize = true
        label.layer.rasterizationScale = UIScreen.mainScreen().scale
        
        return label
    }()
    
    private(set) lazy var doneButton: UIButton = {
        let button = UIButton.buttonWithType(.System) as UIButton
        button.setTranslatesAutoresizingMaskIntoConstraints(false)
        button.setTitle("Done", forState: .Normal)
        button.tintColor = UIColor.whiteColor()
        
         button.addTarget(self, action: "didTapDoneButton:", forControlEvents: .TouchUpInside)
        
        return button
    }()
    
    override func prefersStatusBarHidden() -> Bool {
        return !showingInstructions
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    init() {
        super.init(spacing: 46.0)
        
        title = "Calming Scenes"
        let motionManager = CMMotionManager()
        viewControllers = scenes?.map {
            let sceneController = CalmingSceneViewController(scene: $0, motionManager: motionManager)
            sceneController.delegate = self
            
            return sceneController
        }
        selectedIndex = 0
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.blackColor()
        view.addSubview(vignetteView)
        view.addSubview(titleLabel)
        view.addSubview(instructionsLabel)
        view.addSubview(doneButton)
        
        view.setNeedsUpdateConstraints() // bootstrap AutoLayout
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBarHidden = true
    }
    
    override func viewDidAppear(animated: Bool) {
        self.toggleInstructions(true, timer: 3.5)
    }
    
    // MARK: API
    
    var hideBlock: Async?
    
    func toggleInstructions(_ state: Bool? = nil, timer: Double? = nil) {
        showingInstructions = state != nil ? state! : !showingInstructions
        let alpha: CGFloat = showingInstructions ? 1.0 : 0.0
        
        UIView.animateWithDuration(0.33) {
            self.vignetteView.alpha = alpha
            self.titleLabel.alpha = alpha
            self.instructionsLabel.alpha = alpha
            self.doneButton.alpha = alpha
            self.setNeedsStatusBarAppearanceUpdate()
        }
        
        hideBlock?.cancel()
        if showingInstructions && timer != nil {
            hideBlock = Async.main(after: timer!) {
                self.toggleInstructions(false)
            }
        }
    }
    
    // MARK: Constraints
    
    private var didSetupConstraints = false
    
    override func updateViewConstraints() {
        if !didSetupConstraints {
            let views = [
                "vignetteView": vignetteView,
                "titleLabel": titleLabel,
                "instructionsLabel": instructionsLabel,
                "doneButton": doneButton
            ]
            let metrics = [
                "margin": 26
            ]
            
            view.addConstraint(NSLayoutConstraint(item: doneButton, attribute: .Bottom, relatedBy: .Equal, toItem: bottomLayoutGuide, attribute: .Top, multiplier: 1, constant: -34))
            view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[vignetteView]|", options: nil, metrics: metrics, views: views))
            view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[vignetteView]|", options: nil, metrics: metrics, views: views))
            view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-(42)-[titleLabel]-[instructionsLabel]", options: nil, metrics: metrics, views: views))
            view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(margin)-[titleLabel]-(margin)-|", options: nil, metrics: metrics, views: views))
            view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(margin)-[instructionsLabel]-(margin)-|", options: nil, metrics: metrics, views: views))
            for (_, subview) in views {
                view.addConstraint(NSLayoutConstraint(item: subview, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0))
            }
            
            didSetupConstraints = true
        }
        
        super.updateViewConstraints()
    }
    
    // MARK: CalmingSceneViewControllerDelegate
    
    func calmingSceneViewController(calmingSceneViewController: CalmingSceneViewController, didEndTouches touches: NSSet, withEvent event: UIEvent) {
        toggleInstructions(timer: 5)
    }
    
    func didTapDoneButton(button: UIButton!) {
        relaxationDelegate?.relaxationControllerShouldDismiss?(self)
    }
    
}