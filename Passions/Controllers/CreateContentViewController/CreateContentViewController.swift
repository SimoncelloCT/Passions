//
//  CreateContentViewController.swift
//  Passions
//
//  Created by Simone Scionti on 06/04/2020.
//  Copyright © 2020 SSCode. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class CreateContentViewController: UIViewController {

    @IBOutlet weak var videoView: UIVideoView!
    override func viewDidLoad() {
        super.viewDidLoad()
           /* videoView.configure(url: "https://www.youtube.com/watch?v=8EJ3zbKTWQ8")
                   videoView.isLoop = true
                   videoView.play()*/
        
        guard let url = URL(string: "https://devstreaming-cdn.apple.com/videos/streaming/examples/bipbop_adv_example_hevc/master.m3u8") else {
            return
        }
        // Create an AVPlayer, passing it the HTTP Live Streaming URL.
        let player = AVPlayer(url: url)

        // Create a new AVPlayerViewController and pass it a reference to the player.
        let controller = AVPlayerViewController()
        controller.player = player

        // Modally present the player and call the player's play() method when complete.
        present(controller, animated: true) {
            player.play()
        // Do any additional setup after loading the view.
    }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
