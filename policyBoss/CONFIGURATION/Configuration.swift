//
//  Configuration.swift
//  beldara
//
//  Created by Daniyal Shaikh on 18/08/18.
//  Copyright © 2018 Daniyal Shaikh. All rights reserved.
//

import UIKit

class Configuration: NSObject {

  // static let baseURLString = "http://qa.mgfm.in"               //testing

   static let baseURLString = "http://api.magicfinmart.com"     //live
    static let baseServiceURLString = "http://49.50.95.141:191"     // for attendance  (Not in used)
    static let baseEncryptedErpIdURL = "http://202.131.96.101:3333"
  
    static let basegenerateloanLeadURL = "http://services.rupeeboss.com"   //ERP URL {Android}  for loan (currently used in pending case only)
    static let basehealthassureURL = "http://www.healthassure.in"
    
   // static let appVersion = "2.0"
     // static let baseEncryptedErpIdURL = "http://49.50.95.141:2001"
    //    static let baseURLString = "http://preprodapiqa.mgfm.in"
    
    static let appVersion =  Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
    
    static let buildVersion =  Bundle.main.infoDictionary?["CFBundleVersion"] as! String
}
