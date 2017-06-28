//
//  threadVC.swift
//  ios tutorial
//
//  Created by pinasd chen on 2017/6/27.
//  Copyright © 2017年 pinasd chen. All rights reserved.
//

import UIKit

class threadVC: UIViewController {
    
    @IBOutlet weak var lb1: UILabel!
    
    @IBOutlet weak var lb2: UILabel!
    
    @IBAction func t1(_ sender: Any) {
        // queue 裡同步（sync）跟非同步(async)
        //已經是作業系統的層級 so task要加self,
        //用main就做完再做下一個等同於sync但不同的事這是在這個物件上若用global＋sync會先做完執行緒ＵＩ不一定=>因此可以處理ＵＩ
        //global 加入優先權所以可以做到多工(這是分時多工)
        //-----------------------------------------------------------
        //    結論：跟ui有關的用main,跟ui沒關的用global() 寫法如t2
        //-----------------------------------------------------------
        DispatchQueue.global().async {
            self.task1()
        }
        DispatchQueue.main.async {
            self.task2()
        }
    }
    
    //將main寫進global的巢狀型態＝>可以實現ＵＩ非同步
    @IBAction func t2(_ sender: Any) {
        DispatchQueue.global().async {
            self.task3()
        }
        DispatchQueue.global().async {
            self.task4()
        }
    }
    //物件寫法
    @IBAction func t3(_ sender: Any) {
        var opq = OperationQueue()
        opq.addOperation {
            for i in 1...10{
                sleep(1)
                DispatchQueue.main.async {
                    self.lb1.text = String(i)
                }
            }
        }
        opq.addOperation {
            for i in 1...10{
                sleep(2)
                DispatchQueue.main.async {
                    self.lb2.text = String(i)
                }
            }
        }
    }
    
    func task1(){
        for i in 1...10{
            print("A\(i)")
            usleep(100*1000)
        }
    }
    func task2(){
        for i in 1...10{
            print("B\(i)")
            usleep(100*1000)
        }
    }
    
    func task3(){
        for i in 1...10{
            print("A\(i)")
            usleep(100*1000)
            DispatchQueue.main.async {
                self.lb1.text = String(i)
            }
        }
    }
    func task4(){
        for i in 1...10{
            print("B\(i)")
            usleep(200*1000)
            DispatchQueue.main.async {
                self.lb2.text = String(i)
            }
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
