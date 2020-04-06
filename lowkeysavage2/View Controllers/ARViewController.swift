//
//  ARViewController.swift
//  lowkeysavage2
//
//  Created by User on 3/17/20.
//  Copyright © 2020 User. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import AVKit
import AVFoundation

class ARViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    @IBOutlet weak var playVideoButton: UIButton!
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // 1
        let nav = self.navigationController?.navigationBar
        let tabs = self.tabBarController?.tabBar
        playVideoButton.layer.cornerRadius = 5
        playVideoButton.isHidden = false
    
        
        
        // 2
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

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()
        
        // first see if there is a folder called "ARImages" Resource Group in our Assets Folder
        if let trackedImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: Bundle.main) {
            
            // if there is, set the images to track
            configuration.trackingImages = trackedImages
            // at any point in time, only 1 image will be tracked
            configuration.maximumNumberOfTrackedImages = 1
        }
        
        // Run the view's session
        sceneView!.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Pause the view's session
        sceneView!.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
            
            // if the anchor is not of type ARImageAnchor (which means image is not detected), just return
            guard let imageAnchor = anchor as? ARImageAnchor, let fileUrlString = Bundle.main.path(forResource: "IMG_2932", ofType: "mov") else {return}
            //find our video file
            
            let videoItem = AVPlayerItem(url: URL(fileURLWithPath: fileUrlString))
            
            let player = AVPlayer(playerItem: videoItem)
            //initialize video node with avplayer
            let videoNode = SKVideoNode(avPlayer: player)
            
            player.play()
            playVideoButton.isHidden = false
        
        
        
            // add observer when our player.currentItem finishes player, then start playing from the beginning
            //NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: nil) { (notification) in
                //player.seek(to: CMTime.zero)
                //player.play()
                //print("Looping Video")
            //}
            
            // set the size (just a rough one will do)
            let videoScene = SKScene(size: CGSize(width: 1100, height: 800))
            // center our video to the size of our video scene
            videoNode.position = CGPoint(x: videoScene.size.width / 2, y: videoScene.size.height / 2)
            // invert our video so it does not look upside down
            videoNode.yScale = -1.0
            // add the video to our scene
            videoScene.addChild(videoNode)
            // create a plan that has the same real world height and width as our detected image
            let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
            // set the first materials content to be our video scene
            plane.firstMaterial?.diffuse.contents = videoScene
            // create a node out of the plane
            let planeNode = SCNNode(geometry: plane)
            // since the created node will be vertical, rotate it along the x axis to have it be horizontal or parallel to our detected image
            planeNode.eulerAngles.x = -Float.pi / 2
            // finally add the plane node (which contains the video node) to the added node
            node.addChildNode(planeNode)
        
    }
    
    
    private func playVideo() {
        guard let path = Bundle.main.path(forResource: "IMG_2932", ofType:"mov") else {
            debugPrint("IMG_2932.mov not found")
            return
        }
        let player2 = AVPlayer(url: URL(fileURLWithPath: path))
        let playerController = AVPlayerViewController()
        playerController.player = player2
        present(playerController, animated: true) {
            player2.play()
        }
    }
    @IBAction func playVideoButtonTapped(_ sender: UIButton) {
      
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "videoPlayerViewController") as! videoPlayerViewController
         self.present(newViewController, animated: true, completion: nil)
    //performSegue(withIdentifier: "playVideo", sender: playVideoButton)
        
        
//        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "videoPlayerViewController") as? videoPlayerViewController {
//           let appDelegate = UIApplication.shared.delegate as! AppDelegate
//           appDelegate.window?.rootViewController = vc
//        }
    }
    
    }
