//
//  Constant.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 15/03/23.
//  Copyright © 2023 policyBoss. All rights reserved.
//

import Foundation
import UIKit


/********    Color Code   ******/
let customGrayColor95 = UIColor(red: 248/255, green: 109/255, blue: 26/255, alpha: 1.0)
let customOrangeColor = UIColor(red: 248/255, green: 151/255, blue: 26/255, alpha: 1.0) //F8971A
let customBluecolor =  UIColor(red: 28/255, green: 164/255, blue: 255/255, alpha: 1.0) //1CA4FF
let customBlackTransparent =  UIColor(cgColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.7706815567))
let customPrimaryColor =  UIColor(cgColor: #colorLiteral(red: 0.6908986568, green: 0.3392218351, blue: 0.9942491651, alpha: 0.8238832439))



let serverError  = "Server time out.Please try again"
let serverUnavailbleError  = "Server are not available.Please try again"

/********   key   ******/

struct getMessage {
  
    static let  logoutMessage = "Do you wannt to Logout ?"
}



struct storyBoardName  {
    
    static let  Main   = "Main"
    static let  Home = "Home"
    static let  LaunchScreen = "LaunchScreen"
    static let  SyncContact  = "SyncContact"
    static let  Notification  = "Notification"
    
}


struct Constant  {
    
    static let  contactReq   = "Please Allow Contact Access."
    static let  contactTitle   = "Contact access is need to get your Contact Sync."

}


struct Screen  {
    
    static let  navigateBack   = "NAVGATION"
    static let  navigateRoot   = "NAVGATIONROOT"
  
}
