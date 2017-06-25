//
//  ViewController.swift
//  ios tutorial
//
//  Created by pinasd chen on 2017/6/22.
//  Copyright © 2017年 pinasd chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBAction func Home(seque:UIStoryboardSegue){
        
    }

    
    private var tbView:UITableView?
    private var titleLabel:UILabel?
    var tutorialtitle = ["button","image","猜數字","隨機數字","自訂tableview","小畫家"]
    var screenSize:CGRect?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        screenSize = UIScreen.main.bounds
        
        print(type(of:screenSize))
        
        let titleCG = CGRect(x: screenSize!.width * 0.15, y: 22, width: screenSize!.width * 0.7, height: screenSize!.height * 0.05)
        titleLabel = UILabel(frame: titleCG)
        titleLabel?.text = "IOS Tutorial"
        titleLabel?.font = UIFont(name: "Arial", size: 20)
        titleLabel?.textAlignment = .center
        view.addSubview(titleLabel!)

        let tbViewCG = CGRect(x: screenSize!.width * 0.1, y: 122, width: screenSize!.width * 0.8 , height: screenSize!.height * 0.8)
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
        
        //        cell?.textLabel?.text = tutorialtitle[indexPath.row]
        let viewSize = cell?.bounds.size
        let cellLabel:UILabel?
        let cellCG = CGRect(x: viewSize!.width * 0.1, y: 0, width: viewSize!.width * 0.7 , height: viewSize!.height)
        cellLabel = UILabel(frame: cellCG)
        cellLabel?.text = tutorialtitle[indexPath.row]
        cellLabel?.font = UIFont(name: "Arial", size: 15)
        cellLabel?.textAlignment = .left
        cell?.contentView.addSubview(cellLabel!)

        
        let img = UIImage(named: "Apple black.png")
        let imgH = UIImage(named: "Apple blue.png")
        let temp = UIImageView(image: img, highlightedImage: imgH)
        temp.contentMode = UIViewContentMode.scaleAspectFit
        temp.frame = CGRect(x: 0, y: 0, width: viewSize!.width * 0.1, height: viewSize!.height)
        cell?.contentView.addSubview(temp as UIView)
    
        return cell!
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goTo(indexPath.row)
    }
    private func goTo(_ target:Int){
        switch target {
        case 5:
            let targetVC = storyboard?.instantiateViewController(withIdentifier: "paint")
            
            let app = UIApplication.shared.delegate as! AppDelegate
            app.tutotrial = String?(tutorialtitle[target])
            show(targetVC!, sender: self)
        default:
            print("no")
        }
        
        
        
    }


}

