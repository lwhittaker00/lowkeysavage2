//
//  videoPlayerViewController.swift
//  lowkeysavage2
//
//  Created by User on 4/5/20.
//  Copyright © 2020 User. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class videoPlayerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let nav = self.navigationController?.navigationBar
        let tabs = self.tabBarController?.tabBar
        
        nav?.barStyle = UIBarStyle.black
        nav?.tintColor = UIColor.red
        tabs?.barStyle = UIBarStyle.black
        tabs?.tintColor = UIColor.red
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 5, height: 5))
        imageView.contentMode = .scaleAspectFit
              
        // 4
        let image = UIImage(named: "headerlogotransparent")
        imageView.image = image
              
        // 5
        navigationItem.titleView = imageView
    }
    
    @IBAction func playVideoButtonPressed(_ sender: Any) {
        playVideo()
    }
    

    private func playVideo() {
        guard let path = Bundle.main.path(forResource: "updatedpromovideol$", ofType:"mov") else {
            debugPrint("updatedpromovideol$.mov not found")
            return
        }
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerController = AVPlayerViewController()
        playerController.player = player
        present(playerController, animated: true) {
            player.play()
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
