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
        
        lblEmpName.text = empName
        lblDesignation.text = empDesignation
        lblMobile.text = empMobileNo
        lblEmail.text = empEmail
    }
    
    func loanDetails(){
        
        empName = UserDefaults.standard.string(forKey: "loansendname") ?? ""
        empEmail = UserDefaults.standard.string(forKey: "loansendemail") ?? ""
        empMobileNo = UserDefaults.standard.string(forKey: "loansendmobile") ?? ""
        empDesignation = UserDefaults.standard.string(forKey: "loansenddesignation") ?? ""
        PhotoUrl = UserDefaults.standard.string(forKey: "loansendphoto") ?? ""
        
        
        let url = URL(string: PhotoUrl)
        imgUser.sd_setImage(with: url)
        
        lblEmpName.text = empName
        lblDesignation.text = empDesignation
        lblMobile.text = empMobileNo
        lblEmail.text = empEmail
        
    }
    
    
    
    @IBAction func backBtnClick(_ sender: Any) {
        
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()

    }
    

    @IBAction func shareBtnClick(_ sender: Any) {
        
       var  shareImage =  image(with: mainView)
        
        
        // let title = "Finmart"
        let shareAll: [Any] = [ shareImage ]
        
        let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
      //  activityViewController.setValue(title, forKey: "Subject")
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func homeBtnClick(_ sender: Any) {
        
        let KYDrawer : KYDrawerController = self.storyboard?.instantiateViewController(withIdentifier: "stbKYDrawerController") as! KYDrawerController
        self.present(KYDrawer, animated: true, completion: nil)
    }
    
    
    
    func image(with view: UIView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        defer { UIGraphicsEndImageContext() }
        if let context = UIGraphicsGetCurrentContext() {
            view.layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            return image
        }
        return nil
    }
}
