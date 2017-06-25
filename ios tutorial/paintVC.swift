//
//  paintVC.swift
//  ios tutorial
//
//  Created by pinasd chen on 2017/6/23.
//  Copyright © 2017年 pinasd chen. All rights reserved.
//

import UIKit

class paintVC: UIViewController {
    
    @IBOutlet weak var painter: paintUIV!
    
    @IBOutlet weak var typech: UITextField!
    
    @IBAction func ffff(_ sender: Any) {
        
    }
    

    @IBAction func jjjjj(_ sender: Any) {
        if let typenum = typech.text{
            painter.changeType(Int(typenum)!)
        }
//        print(typeCh.text ?? "0")
//        painter.changeType(typenum!)
        
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

        // Do any additional setup after loading the view.
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
