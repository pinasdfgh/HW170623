//
//  touchUIV.swift
//  ios tutorial
//
//  Created by pinasd chen on 2017/6/27.
//  Copyright © 2017年 pinasd chen. All rights reserved.
//

import UIKit

class touchUIV: UIView {
    var isinit = true
    var supervc:touchVC?
    
    //法一：抓到Ｍain.strotyboard在找子容器touchvc利用id
    private func initstate(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        supervc = storyboard.instantiateViewController(withIdentifier: "touchvc") as! touchVC
        isinit = false

    }
    
    override func draw(_ rect: CGRect) {
        if isinit{
            initstate()
        }
    }
    
    //將touch事件傳到父容器
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        supervc?.touchesBegan(touches, with: event)
        print("touchUIV touch")
        //法二：直接用super不合邏輯但可以
        super.touchesBegan(touches, with: event)
    }
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
