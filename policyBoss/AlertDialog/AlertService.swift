//
//  AlertService.swift
//  MagicFinmart
//
//  Created by iOS Developer on 08/04/20.
//  Copyright © 2020 Rahul. All rights reserved.
//

import Foundation
import UIKit
class AlertService {


    
    func alert(title: String , body: String, buttonTitle: String) -> AlertViewController {
        
        let storyboard = UIStoryboard(name: "AlertStoryboard", bundle: .main)
        let alertVC =  storyboard.instantiateViewController(withIdentifier: "AlertVC") as! AlertViewController
        
        alertVC.alertTitle = title
        alertVC.alertBody = body
        alertVC.alertButtonTitle = buttonTitle
       
        
        return alertVC
    }
    func alertWebView(webURL: String) -> AlertWebViewController {
        
        let storyboard = UIStoryboard(name: "AlertWebViewStoryboard", bundle: .main)
        
        let alertWebVC = storyboard.instantiateViewController(withIdentifier: "AlertWebVC") as! AlertWebViewController
        
        alertWebVC.strURL = webURL
        return alertWebVC
    }
    
    func alertShareHealthAssure(title: String , body: String, buttonTitle: String) -> AlertHealthAssureVC {
           
           let storyboard = UIStoryboard(name: "AlertStoryboard", bundle: .main)
           let alertVC =  storyboard.instantiateViewController(withIdentifier: "AlertHealthAssureVC") as! AlertHealthAssureVC
           
           alertVC.alertTitle = title
           alertVC.alertBody = body
           alertVC.alertButtonTitle = buttonTitle
          
           
           return alertVC
       }
    
    
    
    func alertDocView(strURL: String,strTitle: String) -> AlertDocVC {
        
        let storyboard = UIStoryboard(name: "AlertStoryboard", bundle: .main)
        
        let alertDocVC = storyboard.instantiateViewController(withIdentifier: "AlertDocVC") as! AlertDocVC
        
        alertDocVC.strURL = strURL
        alertDocVC.alertTitle = strTitle
        return alertDocVC
    }
    
    
    //AlertConnectionVC
    
    func alertConnection() -> AlertConnectionVC {
        
        let storyboard = UIStoryboard(name: "AlertStoryboard", bundle: .main)
        
        let alertConnVC = storyboard.instantiateViewController(withIdentifier: "AlertConnectionVC") as! AlertConnectionVC
        
       
        return alertConnVC
    }
}
