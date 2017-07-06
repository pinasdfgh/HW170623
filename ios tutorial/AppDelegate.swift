//
//  AppDelegate.swift
//  ios tutorial
//
//  Created by pinasd chen on 2017/6/22.
//  Copyright © 2017年 pinasd chen. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var db:OpaquePointer?
    var tutotrial :String?
    
    let fmgr = FileManager.default
    let docDir = NSHomeDirectory() + "/Documents"
    let gamerdata = Bundle.main.path(forResource: "gamer", ofType: "plist")


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
        //記得到google developer https://console.firebase.google.com/註冊domain
        FirebaseApp.configure()
        if !fmgr.fileExists(atPath: docDir + "/gamedata.plist"){
            do{
                //                print(docDir)
                try fmgr.copyItem(atPath: gamerdata!, toPath: docDir + "/gamedata.plist")
            }catch{
                print(error)
            }
        }
        //--------------資料庫-------------------------
        
        let mydb = Bundle.main.path(forResource: "mydb", ofType: "")
        
        let newdb = docDir + "/mydb.sqlite"
        
        if !fmgr.fileExists(atPath: newdb){
            do{
                try fmgr.copyItem(atPath: mydb!, toPath: newdb)
                print("ok")
            }catch{
                print(error)
            }
        }
        //這裡是在將資料庫的table的記憶體地址付給db
        if sqlite3_open(newdb, &db) == SQLITE_OK{
            print("OK")
        }else{
            print("NG")
        }
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        sqlite3_close(db)
    }


}

