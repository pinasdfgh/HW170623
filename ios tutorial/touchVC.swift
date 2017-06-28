//
//  touchVC.swift
//  ios tutorial
//
//  Created by pinasd chen on 2017/6/27.
//  Copyright © 2017年 pinasd chen. All rights reserved.
//

import UIKit

class touchVC: UIViewController {

    @IBOutlet weak var touchUIV: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        touchUIV.backgroundColor = UIColor(colorLiteralRed: 0.4, green: 0.45, blue: 0.5, alpha: 0.5)
        //雙點或多點touch
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapTest))
        tapGesture.numberOfTouchesRequired = 2
        tapGesture.numberOfTapsRequired = 1
        touchUIV.addGestureRecognizer(tapGesture)
        //雙touch拉大或縮小：<1縮小 >1放大
        let pinGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinerTest(_:)))
        touchUIV.addGestureRecognizer(pinGesture)
        
        
    }
    @objc private func tapTest(_ sender:UITapGestureRecognizer){
        print("two finger touch")
        let point0 = sender.location(ofTouch: 0, in: sender.view)
        print("0.\(point0)")
        let point1 = sender.location(ofTouch: 0, in: sender.view)
        print("1.\(point1)")
    }
    
    @objc private func pinerTest(_ sender:UIPinchGestureRecognizer){
        if sender.state == UIGestureRecognizerState.changed{
            print(sender.scale)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchVC touch")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
