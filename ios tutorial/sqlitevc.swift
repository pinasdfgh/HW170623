//
//  sqlitevc.swift
//  ios tutorial
//
//  Created by pinasd chen on 2017/7/3.
//  Copyright © 2017年 pinasd chen. All rights reserved.
//

import UIKit

class sqlitevc: UIViewController {

    
    let appMain = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var name: UITextField!
    @IBAction func rename(_ sender: Any) {
        guard NSMutableDictionary(contentsOfFile: gamedataFile) != nil else {
            return
        }
        let gamedata = NSMutableDictionary(contentsOfFile: gamedataFile)
        gamedata!["name"] = name.text
        gamedata!["test"] = "Hollo"
        
        gamedata?.write(toFile: gamedataFile, atomically: true)
        
    }
    @IBAction func getsql(_ sender: Any) {
        let sql = "SELECT * FROM cust"
        var point:OpaquePointer? = nil
        if sqlite3_prepare(appMain.db, sql, -1, &point, nil) == SQLITE_OK{
            print("OK")
        }
        
        while sqlite3_step(point) == SQLITE_ROW{
            let cname = sqlite3_column_text(point, 1)
            
            print(String(cString: cname!))
            
        }
        
        
    }
    
    
    let gamedataFile = NSHomeDirectory() + "/Documents/gamedata.plist"
    override func viewDidLoad() {
        super.viewDidLoad()
        let gamedata = NSMutableDictionary(contentsOfFile: gamedataFile)
        print(gamedata)
        
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
