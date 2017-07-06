//
//  webviewvc.swift
//  ios tutorial
//
//  Created by pinasd chen on 2017/7/1.
//  Copyright © 2017年 pinasd chen. All rights reserved.
//

import UIKit
import JavaScriptCore

class webviewvc: UIViewController , JSP{
    @IBOutlet weak var webvc: UIWebView!
    //----------------load web on web site--------------------
    @IBAction func btn1(_ sender: Any) {
        let url = URL(string: "https://php-motabliclive.c9users.io/file/filesystemver0.4.php")
        let req = URLRequest(url: url!)
        
        webvc.loadRequest(req)
    }
    
    @IBAction func btn2(_ sender: Any) {
        let url = URL(string: "http://127.0.0.1/pinasd.html")
        let req = URLRequest(url: url!)
        
        webvc.loadRequest(req)
        
    }
    
    //----------------load web on swift--------------------
    @IBAction func btn3(_ sender: Any) {
        let strCont = "<font size = 7 color = 'blue'>Hello.word</font>"
        webvc.loadHTMLString(strCont, baseURL: nil)
    }
    
    @IBAction func btn4(_ sender: Any) {
        let url = Bundle.main.url(forResource: "brad01", withExtension: "html")
        let req = URLRequest(url: url!)
        webvc.loadRequest(req)
    }
    //-----------------swift control webvc--------------------
    @IBAction func btn5(_ sender: Any) {
        webvc.stringByEvaluatingJavaScript(from: "document.body.style.zoom = 3")
        //由swift觸發javascript事件
        //        webvc.stringByEvaluatingJavaScript(from: "alert('OKbtn')")
        
        //        let rand = Int(arc4random() % 49) + 1
        //        let doJS = "document.getElementById('here').innerHTML='\(rand)'"
        //        webvc.stringByEvaluatingJavaScript(from: doJS)
        webvc.stringByEvaluatingJavaScript(from: "test3()")
    }
    //------------swift pass data to webvc---------------
    @IBAction func btn6(_ sender: Any) {
        let url = Bundle.main.url(forResource: "map", withExtension: "html")
        let req = URLRequest(url: url!)
        webvc.loadRequest(req)
    }
    
    @IBAction func btn7(_ sender: Any) {
        let lat = 26.33333
        let lng = 127.80255
        let newpos = "moveToKD(\(lat),\(lng))"
        webvc.stringByEvaluatingJavaScript(from: newpos)
    }
    //----------------webvc control swift-------------------
    //這一段主要是造一個物件讓web控制
    //-------------------------------------------------------
    @IBAction func btn8(_ sender: Any) {
        let url = Bundle.main.url(forResource: "brad01", withExtension: "html")
        let req = URLRequest(url: url!)
        webvc.loadRequest(req)
        
        let jscontext = webvc.value(forKeyPath: "documentView.webView.mainFrame.javaScriptContext") as! JSContext
        
        jscontext.setObject(self, forKeyedSubscript: "brad" as (NSCopying & NSObjectProtocol))
        
    }
    
    func test10(){
        print("test10")
    }
    func test10(value:String){
        print("test10:\(value)")
        
    }
    func test20(){
        print("test20")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}


//自訂呼叫的方法有哪些 ps:JSExport是由JavaScriptCore來的
@objc protocol JSP:JSExport{
    func test10()
    func test10(value:String)
    func test20()
}
