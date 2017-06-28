//
//  webvc.swift
//  ios tutorial
//
//  Created by pinasd chen on 2017/6/28.
//  Copyright © 2017年 pinasd chen. All rights reserved.
//

import UIKit

class webvc: UIViewController {
    //若web是http通訊協定ios會丟出error要改要到info.plist中增加App Transport Security Settings選項 Allow Arbitrary Loads set yes
    
    @IBOutlet weak var image: UIImageView!
    @IBAction func btn1(_ sender: Any) {
        
        do{
            let url = URL(string: "http://www.comicbus.com/comic/")
            let scr = try String(contentsOf: url!, encoding: String.Encoding.ascii)
            print(scr)
        }catch{
            print(error)
        }
        
    }
    //-------------------------------------------------------------------------------------
    //如果只有字串就用String,檔案的話使用Data
    //
    //-------------------------------------------------------------------------------------
    
    @IBAction func btn2(_ sender: Any) {
        let url = URL(string: "https://us.123rf.com/450wm/maxborovkov/maxborovkov1510/maxborovkov151000105/46284934-2016.jpg?ver=6")
        do{
            let data = try Data(contentsOf: url!)
            let img = UIImage(data: data)
            DispatchQueue.main.async {
                self.image.image = img
            }
        }catch{
            let img = UIImage(named: "Apple blue.png")
            DispatchQueue.main.async {
                self.image.image = img
            }
        }
    }
  

        
    @IBAction func getJSON(_ sender: Any) {
        
        let url = URL(string: "http://data.coa.gov.tw/Service/OpenData/AnimalOpenData.aspx/")
        do{
            let scr = try Data(contentsOf: url!)
            parseJSON(scr)
            
            
        }catch{
            print(error)
        }
        
    }
    
    private func parseJSON(_ data:Data){
        
        do{
             let jsonobj = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            let arr = jsonobj as! [[String:AnyObject]]
            for row in arr{
                print(row["animal_kind"])
            }
        }catch{
            print(error)
        }
        
       
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
