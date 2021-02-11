//
//  ViewController.swift
//  Calendar
//
//  Created by macintosh on 09/02/2021.
//

import UIKit
import AVKit

class ViewController: UIViewController {

    @IBOutlet weak var signUpButton : UIButton!
    @IBOutlet weak var signInButton : UIButton!
    
    var videoPlayer : AVPlayer!
    var videoPlayerLayer : AVPlayerLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .calendarBackground
        
        signUpButton.backgroundColor = .calendarButton
        signUpButton.setRoundedCorners(style: .highlyRounded)
        signInButton.backgroundColor = .calendarButton
        signInButton.setRoundedCorners(style: .highlyRounded)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Set up Video in The Background
        self.setUpVideo()
    }
    
    func setUpVideo() {
        // Get the path to the resource in the bundle
        let bundlePath =  Bundle.main.path(forResource: "launchScreenVideo", ofType: "mp4")
        // Create a URL from it
        guard let path = bundlePath else {
            return
        }
        let url = URL(fileURLWithPath: path)
         
        // Create the video player item
        let item = AVPlayerItem(url: url)
        // Create the player
        self.videoPlayer = AVPlayer(playerItem: item)
        // Create the layer
        self.videoPlayerLayer = AVPlayerLayer(player: videoPlayer)
        // Adjust the bounds
        self.videoPlayerLayer.frame = CGRect(x: -self.view.frame.size.width * 1.5,
                                              y: 0,
                                              width: self.view.frame.size.width*4,
                                              height: self.view.frame.size.height)
        self.view.layer.insertSublayer(self.videoPlayerLayer, at: 0)
        
        // Add it to the view and play it
        videoPlayer.playImmediately(atRate: 1)
        
    }
}
