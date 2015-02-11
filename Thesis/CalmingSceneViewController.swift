//
//  CalmingSceneViewController.swift
//  Thesis
//
//  Created by Maxwell Barvian on 2/11/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

import UIKit
import AVFoundation

class CalmingSceneViewController: UIViewController {
    
    var playerLayer: AVPlayerLayer!
    
    var naturalSize: CGSize {
        let track: AVAssetTrack! = playerLayer.player.currentItem.asset.tracksWithMediaType(AVMediaTypeVideo).first as? AVAssetTrack
        let dimensions = CGSizeApplyAffineTransform(track.naturalSize, track.preferredTransform)
        
        return dimensions
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        let path = NSBundle.mainBundle().pathForResource("Cornfield", ofType: "mov", inDirectory: "Scenes")
        let playerItem = AVPlayerItem(URL: NSURL(fileURLWithPath: path!)!)
        let player = AVPlayer(playerItem: playerItem)
        player.actionAtItemEnd = .None
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = AVLayerVideoGravityResize
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "playerItemDidReachEnd:", name: AVPlayerItemDidPlayToEndTimeNotification, object: player.currentItem)
        
        view.layer.addSublayer(playerLayer)
    }
    
    override func viewDidAppear(animated: Bool) {
        playerLayer.player.play()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let naturalSize = self.naturalSize
        playerLayer.frame = CGRectMake(100, 0, view.bounds.height / naturalSize.height * naturalSize.width, view.bounds.height)
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
