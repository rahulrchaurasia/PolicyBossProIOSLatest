//
//  FinmartUserDefault.swift
//  MagicFinmart
//
//  Created by Ashwini on 29/12/18.
//  Copyright © 2018 Ashwini. All rights reserved.
//

import UIKit

class FinmartUserDefault: NSObject {
    
    static let USER_CODE = "com.rupeeboss.OutdoorAttendance.userdefaults.userCode"
    static let USER_LOGGEDIN = "com.rupeeboss.OutdoorAttendance.userdefaults.loggedIn"
    static let USER_PASSWORD = "com.rupeeboss.OutdoorAttendance.userdefaults.Password"
    static let USER_DEFAULT_LAT = "19.0176147"
    static let USER_DEFAULT_LNG = "72.8561644"
    static let USER_ID = "12456"
    static let USER_HRMSID = "com.rupeeboss.OutdoorAttendance.userdefaults.hrmsid"
    
    static let SELLER_ID = "com.techwind.beldara.sellerid"
    static let SELLER_KEY = "com.techwind.beldara.sellerkey"
    
    static func getlat() -> String {
        //let defaults = UserDefaults.standard
        var lati = UserDefaults.standard.string(forKey: FinmartUserDefault.USER_DEFAULT_LAT)
        if(lati == nil){
            lati = ""
        }
        // return lati!;
        return lati!
    }
    
    static func getlag() -> String {
        var lag = UserDefaults.standard.string(forKey: FinmartUserDefault.USER_DEFAULT_LNG)
        if(lag == nil){
            lag = ""
        }
        return lag!
    }
    
    static func userid() -> String {
        var userid = UserDefaults.standard.string(forKey: FinmartUserDefault.USER_ID)
        if(userid == nil){
            userid = ""
        }
        return userid!
    }
    
}
