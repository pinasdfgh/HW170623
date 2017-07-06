//
//  carmalVC.swift
//  ios tutorial
//
//  Created by pinasd chen on 2017/7/4.
//  Copyright © 2017年 pinasd chen. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class carmalVC: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate {

    @IBOutlet weak var img: UIImageView!
    
    @IBAction func takepic(_ sender: Any) {
        //確認相機(UIImagePickerController)是否可用,可能被其他程式占用
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let imgPC = UIImagePickerController()
            imgPC.sourceType = .camera
            imgPC.delegate = self
            show(imgPC,sender:self)
        }else{
            print("cramer no avaliable")
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let imga = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        img.image = imga
        
        dismiss(animated: true, completion: {() in
            print("OK")
        })
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: {() in
            print("Canel")
        })
    }
    //用ＡＰＩ中AVPlayerLayer需要做按鍵
    @IBAction func palyvideo(_ sender: Any) {
        let videoURL = URL(string: "http://distribution.bbb3d.renderfarming.net/video/mp4/bbb_sunflower_1080p_30fps_stereo_abl.mp4")
        
        let player = AVPlayer(url: videoURL!)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.bounds
        view.layer.addSublayer(playerLayer)
        player.play()
    }
    //另外叫出player
    @IBAction func palyvideo2(_ sender: Any) {
        let videoURL = URL(string: "http://distribution.bbb3d.renderfarming.net/video/mp4/bbb_sunflower_1080p_30fps_stereo_abl.mp4")
        
        let player = AVPlayer(url: videoURL!)
        let playerVC = AVPlayerViewController()
        playerVC.player = player
        
        self.present(playerVC, animated: true)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
