//
//  VideoView.swift
//  Passions
//
//  Created by Simone Scionti on 05/04/2020.
//  Copyright © 2020 SSCode. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class UIVideoView: UIView  {
    
    var playerLayer: AVPlayerLayer?
    var player: AVPlayer?
    var isLoop: Bool = false
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    init() {
        super.init(frame: CGRect(x:0,y:0,width:0,height:0))
    }
    
    func configure(url: String) {
        print("configure")
        if let videoURL = URL(string: url) {
            print("url ok")
            player = AVPlayer(url: videoURL)
            playerLayer = AVPlayerLayer(player: player)
            playerLayer?.frame = bounds
            playerLayer?.videoGravity = .resizeAspectFill
            
            if let playerLayer = self.playerLayer {
                layer.addSublayer(playerLayer)
            }
            NotificationCenter.default.addObserver(self, selector: #selector(reachTheEndOfTheVideo(_:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.player?.currentItem)
        }
    }
    
    override func removeFromSuperview() {
        print("remove")
        self.player = nil
        self.playerLayer = nil
    }
    
    func play() {
        print("play")
        if player?.timeControlStatus != AVPlayer.TimeControlStatus.playing {
            player?.play()
        }
    }
    
    func pause() {
        player?.pause()
    }
    
    func stop() {
        player?.pause()
        player?.seek(to: CMTime.zero)
    }
    
    @objc func reachTheEndOfTheVideo(_ notification: Notification) {
        if isLoop {
            player?.pause()
            player?.seek(to: CMTime.zero)
            player?.play()
        }
    }
    
    deinit {
        print("videoView deinit")
    }
}
