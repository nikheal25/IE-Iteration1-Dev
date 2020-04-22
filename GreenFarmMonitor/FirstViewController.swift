//
//  FirstViewController.swift
//  GreenFarmMonitor
//
//  Created by Nikhil Gholap on 13/4/20.
//  Copyright © 2020 Nikhil Gholap. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class FirstViewController: UIViewController {

    @IBOutlet var videoLayer: UIView!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var mainButton: UIButton!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var subtitle: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        mainButton.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)
        mainButton.layer.cornerRadius = 20
//        mainButton.layer.borderWidth = 1
        mainButton.layer.borderColor = UIColor.black.cgColor
        playVideo()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "onBoardingSegue", sender: self)
    }
    func playVideo() {
           guard let path = Bundle.main.path(forResource: "intro2", ofType: "mp4") else {
                print("no video found")
               return
           }
           
           let player = AVPlayer(url: URL(fileURLWithPath: path))
           let playerLayer = AVPlayerLayer(player: player)
           //player.seek(to: CMTime.zero)
           playerLayer.frame = self.view.bounds
           playerLayer.videoGravity = .resizeAspectFill
           self.videoLayer.layer.addSublayer(playerLayer)
           player.play()
        
        videoLayer.bringSubviewToFront(mainLabel)
           videoLayer.bringSubviewToFront(mainButton)
        videoLayer.bringSubviewToFront(subtitle)
        videoLayer.bringSubviewToFront(mainImage)
        
        player.actionAtItemEnd = .none
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: nil)
          
       }
    
    @objc func playerDidFinishPlaying(_ notification: Notification){
        let player: AVPlayerItem = notification.object as! AVPlayerItem
        player.seek(to: CMTime.zero)
    }
    

}
