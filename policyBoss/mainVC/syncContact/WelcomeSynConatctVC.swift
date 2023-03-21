//
//  WelcomeSynConatctVC.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 14/03/23.
//  Copyright © 2023 policyBoss. All rights reserved.
//

import UIKit

class WelcomeSynConatctVC: UIViewController {

    @IBOutlet weak var btnGetStarted: UIButton!
    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var imgchkTerm1: UIImageView!
    @IBOutlet weak var imgchkTerm2: UIImageView!
    @IBOutlet weak var imgchkTerm3: UIImageView!
    
    @IBOutlet weak var ClickHere: UIStackView!
    
    var isTerm1 = false
    var  isTerm2 = false
    var isTerm3 = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ScrollView.layoutIfNeeded()
       
        self.ScrollView.scrollToBottom(animated: true)
        btnGetStarted.alpha = 0.40
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.clickAction(sender:)))


        self.ClickHere.addGestureRecognizer(gesture)

        
        // Do any additional setup after loading the view.
    }
    
    @objc func clickAction(sender : UITapGestureRecognizer) {

        let objVC = SyncMoreDetailsVC.shareInstance()

        self.present(objVC, animated: true)
       
        btnGetStarted.alpha = 1
     }

    
    func verifyAllCondition() -> Bool{
        
        if(self.isTerm1 && self.isTerm2 && self.isTerm3 ){
            
            btnGetStarted.alpha = 1
            return true
        }else{
            btnGetStarted.alpha = 0.4
            return false
        }
       
    }
    @IBAction func btnBack(_ sender: Any) {
        
        navigationController?.popViewController(animated: false)
    }
    
    
    @IBAction func btnTermsCondition(_ sender: Any) {
        

        moveToWeb(screeName: "SYNC_TERMS", screenTitle: "Terms & Conditions")
    }
    @IBAction func btnPrivacyPolicy(_ sender: Any) {
        

        moveToWeb(screeName: "SYNC_PRIVACY", screenTitle: "Privacy-Policy")
      
    }
    
    @IBAction func btnTerms1(_ sender: Any) {
        
        self.isTerm1.toggle()
        
       
        if(self.isTerm1){
            imgchkTerm1.image = UIImage(named: "black-check-box-with-white-check (2).png")
           
        }else{
            imgchkTerm1.image = UIImage(named: "check-box-empty.png")
           
        }
        
        
        verifyAllCondition()
    }
    
    @IBAction func btnTerms2(_ sender: Any) {
        self.isTerm2.toggle()
        if(self.isTerm2){
            imgchkTerm2.image = UIImage(named: "black-check-box-with-white-check (2).png")
           
        }else{
            imgchkTerm2.image = UIImage(named: "check-box-empty.png")
           
        }
        
        verifyAllCondition()
    }
    
    @IBAction func btnTerms3(_ sender: Any) {
        
        self.isTerm3.toggle()
        if(self.isTerm3){
            imgchkTerm3.image = UIImage(named: "black-check-box-with-white-check (2).png")
           
        }else{
            imgchkTerm3.image = UIImage(named: "check-box-empty.png")
           
        }
        
      verifyAllCondition()
        
    }
    
    @IBAction func btnStarted(_ sender: Any) {
        
        
        if( verifyAllCondition()){
            navigationController?.pushViewController( SyncContactVC.shareInstance(), animated: false)
            
          }
    }
    
    
    
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

  
  
//    func alertConnection() -> AlertConnectionVC {
//
//        let storyboard = UIStoryboard(name: "AlertStoryboard", bundle: .main)
//
//        let alertConnVC = storyboard.instantiateViewController(withIdentifier: "AlertConnectionVC") as! AlertConnectionVC
//
//
//        return alertConnVC
//    }
    
    
    func moveToWeb(screeName : String, screenTitle : String ){
        
        let storyboard = UIStoryboard(name: storyBoardName.Main, bundle: .main)
    let commonWeb : commonWebVC = storyboard.instantiateViewController(withIdentifier: "stbcommonWebVC") as! commonWebVC
        commonWeb.modalPresentationStyle = .fullScreen
        commonWeb.addType = "NAVGATION"
        commonWeb.webTitle = "Terms & Conditions"
        commonWeb.webfromScreen = screeName
        navigationController?.pushViewController( commonWeb, animated: false)
    }
   
}
extension WelcomeSynConatctVC {
    
    static func shareInstance() -> WelcomeSynConatctVC
    {
        return WelcomeSynConatctVC.initiateFromStoryboard(name: storyBoardName.SyncContact)
    }
}
