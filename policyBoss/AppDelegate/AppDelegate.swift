//
//  AppDelegate.swift
//  MagicFinmart
//
//  Created by Ashwini on 10/12/18.
//  Copyright © 2018 Ashwini. All rights reserved.
//

import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //Note :  Used For Keyboard Handling When its hiding the textfield
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        
        //---Statusbar Customization
        //005
//        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
//        statusBar.backgroundColor = UIColor(red: 1/255, green: 88/255, blue: 155/255, alpha: 1.0)
        
        //---
        
        let IsFirstLogin = UserDefaults.standard.string(forKey: "IsFirstLogin")
        if(IsFirstLogin == "1")
        {
//            let KYDrawer : KYDrawerController = UIStoryboard?.instantiateViewController(withIdentifier: "stbKYDrawerController") as! KYDrawerController
//            self.present(KYDrawer, animated: true, completion: nil)
            
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let homeController =  mainStoryboard.instantiateViewController(withIdentifier: "stbKYDrawerController") as! KYDrawerController
            appDelegate?.window?.rootViewController = homeController
            window?.makeKeyAndVisible()
            
            
            
            
//            let storyboard = UIStoryboard(name: "Home", bundle: nil)
//            let mainTabBarController = storyboard.instantiateViewController(withIdentifier: "HomeTabBar") as! UITabBarController
//            mainTabBarController.modalTransitionStyle = .coverVertical
//            mainTabBarController.modalPresentationStyle = .fullScreen
//
//
//            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//            appDelegate.window?.rootViewController = mainTabBarController
//            appDelegate.window?.makeKeyAndVisible()
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
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    
    // for orientation
//    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
//        return deviceOrientation
//    }

}

