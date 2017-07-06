//
//  webvc.swift
//  ios tutorial
//
//  Created by pinasd chen on 2017/6/28.
//  Copyright © 2017年 pinasd chen. All rights reserved.
//

import UIKit

class webvc: UIViewController,UITableViewDataSource,UITabBarDelegate {
    //若web是http通訊協定ios會丟出error要改要到info.plist中增加App Transport Security Settings選項 Allow Arbitrary Loads set yes
    var data:[String] = []
    @IBOutlet weak var TbVC: UITableView!
    @IBOutlet weak var image: UIImageView!
    @IBAction func btn1(_ sender: Any) {
        //法一：此方法要自己寫執行緒
//        do{
//            let url = URL(string: "http://www.comicbus.com/comic/")
//            let scr = try String(contentsOf: url!, encoding: String.Encoding.ascii)
//            print(scr)
//        }catch{
//            print(error)
//        }
        //法二：已加入執行緒的ＡＰＩ
        let url = URL(string: "https://tw.yahoo.com/")
        //configuration:ephemeral儲存在記憶體 configuration:defaule儲存在硬碟
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url!, completionHandler: {(data,rep,error) in
            if error == nil{
                let ret = String(data: data!, encoding: .utf8)
                print(ret ?? "Nothinh")
            }else{
                print(error!)
            }
        })
        task.resume()
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
        DispatchQueue.global().async {
            
            let url = URL(string: "http://data.coa.gov.tw/Service/OpenData/AnimalOpenData.aspx/")
            do{
                let scr = try Data(contentsOf: url!)
                self.parseJSON(scr)
                DispatchQueue.main.async {
                    self.TbVC.reloadData()
                }
                
            }catch{
                print(error)
            }
        }
     
        
    }
    private func parseJSON(_ data:Data){
        
        do{
             let jsonobj = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            let arr = jsonobj as! [[String:AnyObject]]
            
            for row in arr{
                print(row["animal_kind"])
                self.data.append(String(describing: row["animal_kind"]))
            }
        }catch{
            print(error)
        }
        
       
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return data.count
    }
    
    @IBOutlet weak var lb11: UILabel!
    @IBAction func btn10(_ sender: Any) {
        let url = URL(string: "http://127.0.0.1/pinasd.php")
        
        var req = URLRequest(url: url!)
        
        req.httpMethod = "POST"
        req.httpBody = "account=IOS&passwd=IOS".data(using: .utf8)
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: req, completionHandler: {(data,rep,error) in
            //這邊可以知道這裡其實就是DispatchQueue.global().async若有關UIView的要用DispatchQueue.main.async
            if error == nil{
                DispatchQueue.main.async {
                    self.lb11.text = "ok"
                }
                
            }else{
                self.lb11.text = "ng"
                print(error)
            }
        })
        
        task.resume()
    }
    
    @IBAction func btn11(_ sender: Any) {
        let url = URL(string: "http://127.0.0.1/pinasd.php")
        
        var req = URLRequest(url: url!)
        
        req.httpMethod = "POST"
        req.httpBody = "get=17".data(using: .utf8)
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: req, completionHandler: {(data,rep,error) in
            
            if error == nil{
                // 這邊可以知道之前用的String(contentsOf: url!, encoding: String.Encoding.ascii)與data關係是data是最原始的資料再轉換成String
                let rs = String(data: data!, encoding: .utf8)
                DispatchQueue.main.async {
                    self.lb11.text = rs
                }
                
            }else{
                self.lb11.text = "ng"
                print(error)
            }
        })
        
        task.resume()
        
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        TbVC.scrollToNearestSelectedRow(at: .bottom, animated:true)
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = data[indexPath.row]
        
        return cell!
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TbVC.scrollToNearestSelectedRow(at: .bottom, animated:true)

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
