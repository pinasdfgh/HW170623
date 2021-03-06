//
//  ViewController.swift
//  ios tutorial
//
//  Created by pinasd chen on 2017/6/22.
//  Copyright © 2017年 pinasd chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate {
    
    @IBAction func Home(seque:UIStoryboardSegue){
        
    }
    private var scroll:UIScrollView?
    private var tbView:UITableView?
    private var titleLabel:UILabel?
    private let BGcolor = UIColor(colorLiteralRed: 0.55, green: 0.50, blue: 0.66, alpha: 0.5)
    var tutorialtitle = ["小畫家","touch event","thread","計時器","WebMySQL","WebView google map","webView動態載入","animate & DynamicBehavior","image+scroll","Filesystem","sqlite","Cocoapods","相機&影像播放","音樂播放"]
    var screenSize:CGRect?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        screenSize = UIScreen.main.bounds
        
        print(type(of:screenSize))
        
        let titleCG = CGRect(x: screenSize!.width * 0.15, y: 45, width: screenSize!.width * 0.7, height: screenSize!.height * 0.05)
        titleLabel = UILabel(frame: titleCG)
        titleLabel?.text = "IOS Tutorial"
        titleLabel?.font = UIFont(name: "Arial", size: 25)
        titleLabel?.textColor = UIColor.black
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        titleLabel?.textAlignment = .center
        view.addSubview(titleLabel!)

        let tbViewCG = CGRect(x: screenSize!.width * 0.1, y: 122, width: screenSize!.width * 0.8 , height: screenSize!.height * 0.6)
        //建構式
        tbView = UITableView(frame: tbViewCG, style: UITableViewStyle.plain)
        //自訂cell class
        tbView?.register(homeTbCell.self, forCellReuseIdentifier: "cell")
        
        tbView?.allowsSelection = true
        tbView?.allowsMultipleSelection = false
        //regist data and delegate 
        //Note don't forget add protocol in viewcontroller
        tbView?.delegate = self
        tbView?.dataSource = self
        tbView?.layer.cornerRadius = 10
//        tbView?.layer.masksToBounds = true
        tbView?.backgroundColor = UIColor(colorLiteralRed: 0.55, green: 0.50, blue: 0.66, alpha: 0)
        view.addSubview(tbView!)
    
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return tutorialtitle.count
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tbView?.dequeueReusableCell(withIdentifier: "cell")
        
//        print((cell?.contentView.subviews.count)!)
        
        if (cell?.contentView.subviews.count)! == 0{
            let viewSize = cell?.bounds.size
            let cellLabel:UILabel?
            let cellCG = CGRect(x: viewSize!.width * 0.1, y: 0, width: viewSize!.width * 0.7 , height: viewSize!.height)
            cellLabel = UILabel(frame: cellCG)
            cellLabel?.text = self.tutorialtitle[indexPath.row]
            cellLabel?.font = UIFont(name: "SF Mono", size: 18)
            cellLabel?.textAlignment = .left
            
            //-------bgcolor set----------------------
            cell?.backgroundColor = UIColor(colorLiteralRed: 0.45, green: 0.50, blue: 0.55, alpha: 0.2)
            let bgColorView = UIView()
            bgColorView.backgroundColor = UIColor(colorLiteralRed: 0.45, green: 0.50, blue: 0.55, alpha: 0.2)
            cell?.selectedBackgroundView = bgColorView
            //-------bgcolor set----------------------
            
            let img = UIImage(named: "Apple black.png")
            let imgH = UIImage(named: "Apple blue.png")
            let temp = UIImageView(image: img, highlightedImage: imgH)
            temp.contentMode = UIViewContentMode.scaleAspectFit
            temp.frame = CGRect(x: 0, y: 0, width: viewSize!.width * 0.1, height: viewSize!.height)
            //---------tag : use identify view objects-------------
            cellLabel!.tag = 10
            temp.tag = 20
            //---------tag : use identify view objects-------------
            cell?.contentView.addSubview(cellLabel!)
            cell?.contentView.addSubview(temp as UIView)
          
            return cell!
        }else{
            //-----------解決ＴＢＶＩＥＷ上下拉會錯亂---------------------------
            var lab = cell?.contentView.viewWithTag(10) as! UILabel
            lab.text = self.tutorialtitle[indexPath.row]
            
            return cell!
        }

        
    }
    

    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goTo(indexPath.row)
    }
    private func goTo(_ target:Int){
        switch target {
        case 0:
            let targetVC = storyboard?.instantiateViewController(withIdentifier: "paint")
            
            let app = UIApplication.shared.delegate as! AppDelegate
            app.tutotrial = String?(tutorialtitle[target])
            show(targetVC!, sender: self)
        case 1:
            let targetVC = storyboard?.instantiateViewController(withIdentifier: "touchvc")
            show(targetVC!, sender: self)
        case 2:
            let targetVC = storyboard?.instantiateViewController(withIdentifier: "threadvc")
            show(targetVC!, sender: self)
        case 3:
            let targetVC = storyboard?.instantiateViewController(withIdentifier: "Stopcountvc")
            show(targetVC!, sender: self)
        case 4:
            let targetVC = storyboard?.instantiateViewController(withIdentifier: "webvc")
            show(targetVC!, sender: self)
        case 5:
            let targetVC = storyboard?.instantiateViewController(withIdentifier: "webviewvc")
            show(targetVC!, sender: self)
            
        case 6:
            let targetVC = storyboard?.instantiateViewController(withIdentifier: "webDyVC")
            show(targetVC!, sender: self)
            
        case 7:
            let targetVC = storyboard?.instantiateViewController(withIdentifier: "animatvc")
            show(targetVC!, sender: self)
            
        case 8:
            let targetVC = storyboard?.instantiateViewController(withIdentifier: "imagesvc")
            show(targetVC!, sender: self)
        case 9:
            let targetVC = storyboard?.instantiateViewController(withIdentifier: "FSVC")
            show(targetVC!, sender: self)
        case 10:
            let targetVC = storyboard?.instantiateViewController(withIdentifier: "sql")
            show(targetVC!, sender: self)
        case 11:
            let targetVC = storyboard?.instantiateViewController(withIdentifier: "cocoapodsVC")
            show(targetVC!, sender: self)
        case 12:
            let targetVC = storyboard?.instantiateViewController(withIdentifier: "carmalvc")
            show(targetVC!, sender: self)
        case 13:
            let targetVC = storyboard?.instantiateViewController(withIdentifier: "audiovc")
            show(targetVC!, sender: self)
            
        default:
            print("no")
        }
        
        
        
    }


}

