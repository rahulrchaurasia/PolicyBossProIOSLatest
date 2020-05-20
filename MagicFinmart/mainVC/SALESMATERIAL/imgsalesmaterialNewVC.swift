//
//  imgsalesmaterialNewVC.swift
//  MagicFinmart
//
//  Created by iOS Developer on 20/05/20.
//  Copyright © 2020 Ashwini. All rights reserved.
//

import UIKit

class imgsalesmaterialNewVC: UIViewController {
    
    
    var detailImg = ""
    var productID = ""
    
    var  empName = ""
    var  empEmail = ""
    var  empDesignation = ""
    var  empMobileNo = ""
    var  PhotoUrl  = ""
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var imgProduct: UIImageView!
    
    @IBOutlet weak var imgUser: UIImageView!
    
    
    @IBOutlet weak var lblEmpName: UILabel!
    
    @IBOutlet weak var lblDesignation: UILabel!
    
    @IBOutlet weak var lblMobile: UILabel!
    
    @IBOutlet weak var lblEmail: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("detailImg=",detailImg)
       let url = URL(string: detailImg)
        
        
        imgProduct.sd_setImage(with: url)
        
        if(productID == "4" ||  productID == "5" || productID == "6" || productID == "7" ){
            
            loanDetails()
        }else{
            pospDetails()
        }

    }
    
    
    func pospDetails(){
        
        empName = UserDefaults.standard.string(forKey: "pospsendname") ?? ""
        empEmail = UserDefaults.standard.string(forKey: "pospsendemail") ?? ""
        empMobileNo = UserDefaults.standard.string(forKey: "pospsendmobile") ?? ""
        empDesignation = UserDefaults.standard.string(forKey: "pospsenddesignation") ?? ""
        PhotoUrl = UserDefaults.standard.string(forKey: "pospsendphoto") ?? ""
        
        
        let url = URL(string: PhotoUrl)
        imgUser.sd_setImage(with: url)
        
    }
    
    func loanDetails(){
        
        empName = UserDefaults.standard.string(forKey: "loansendname") ?? ""
        empEmail = UserDefaults.standard.string(forKey: "loansendemail") ?? ""
        empMobileNo = UserDefaults.standard.string(forKey: "loansendmobile") ?? ""
        empDesignation = UserDefaults.standard.string(forKey: "loansenddesignation") ?? ""
        PhotoUrl = UserDefaults.standard.string(forKey: "loansendphoto") ?? ""
        
        
        let url = URL(string: PhotoUrl)
        imgUser.sd_setImage(with: url)
        
    }
    
    
    
    @IBAction func backBtnClick(_ sender: Any) {
    }
    

    @IBAction func shareBtnClick(_ sender: Any) {
    }
    
    @IBAction func homeBtnClick(_ sender: Any) {
    }
    
}
