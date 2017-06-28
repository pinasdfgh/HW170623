//
//  paintVC.swift
//  ios tutorial
//
//  Created by pinasd chen on 2017/6/23.
//  Copyright © 2017年 pinasd chen. All rights reserved.
//

import UIKit

class paintVC: UIViewController {
    
    private var btnProp = false
    
    
    @IBOutlet weak var painter: paintUIV!
    
    @IBOutlet weak var drawStroke: UIStackView!
    
    @IBAction func stroke(_ sender: Any) {
        painter.changeType(0)
    }
    
    @IBAction func rectstroke(_ sender: Any) {
        painter.changeType(2)
    }

    @IBAction func tristroke(_ sender: Any) {
        painter.changeType(3)
    }
    
    
    @IBAction func clickstroke(_ sender: Any) {
        drawStroke.isHidden = btnProp
        btnProp = !btnProp
    }
    
    
    
    @IBAction func clear(_ sender: Any) {
        painter.clear()
    }
    
    @IBAction func updo(_ sender: Any) {
        painter.updo()
    }
   
    
    @IBAction func redo(_ sender: Any) {
        painter.redo()
    
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        drawStroke.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
