//
//  imagesvc.swift
//  ios tutorial
//
//  Created by pinasd chen on 2017/7/1.
//  Copyright © 2017年 pinasd chen. All rights reserved.
//

import UIKit

class imagesvc: UIViewController ,UIScrollViewDelegate{
    
    
    @IBOutlet weak var scroll: UIScrollView!
    let img = UIImageView(image: UIImage(named: "pepole.jpg"))

    override func viewDidLoad() {
        super.viewDidLoad()

        img.contentMode = .scaleAspectFit
        scroll.addSubview(img)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        img.frame = scroll.bounds
        let size = getImgAfterAsp()
        img.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        scroll.contentSize = img.frame.size
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //guarg 語句
//    guard <condition to meet> else {
//    // 執行假如條件沒有匹配要做的動作
//    }
//    
//    // 繼續執行一般的動作
    func getImgAfterAsp()->CGSize{
        guard img.image != nil else {
            return CGSize(width: 0, height: 0)
        }
        let widthR = img.bounds.size.width/img.image!.size.width
        let hightR = img.bounds.size.height/(img.image?.size.height)!
        let scale = (widthR >= hightR) ? hightR : widthR
        let imgW = scale*img.image!.size.width
        let imgH = scale*img.image!.size.height
        
        return CGSize(width: imgW, height: imgH)

    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return img
    }

  

}
