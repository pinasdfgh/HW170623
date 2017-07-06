//
//  cocoapodsvc.swift
//  ios tutorial
//
//  Created by pinasd chen on 2017/7/4.
//  Copyright © 2017年 pinasd chen. All rights reserved.
//

import UIKit
import Firebase

class cocoapodsvc: UIViewController {
    
    
    
    var ref: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()
        ref.observe(DataEventType.value, with: { (snapshot) in
            let postDict = snapshot.value as? [String : AnyObject] ?? [:]
            // 在firebase裏data形式是dirtionary
            print(postDict["value"] ?? "ddd")
        })
        
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
