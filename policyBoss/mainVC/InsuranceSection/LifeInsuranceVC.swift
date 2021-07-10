//
//  LifeInsuranceVC.swift
//  MagicFinmart
//
//  Created by Admin on 04/03/19.
//  Copyright © 2019 Ashwini. All rights reserved.
//

import UIKit

class LifeInsuranceVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var lifeinsuranceLblArray = ["COMPARE TERM INSURANCE","HDFC LIFE INSURANCE","ICICI PRUDENTIAL LIFE INSURANCE"/*,"ULTRA LAKSHYA INSURANCE"*/]
    var lifeinsuranceImgArray = ["compare_term_insurance_icon.png","ezgif.com-webp-to-png (2).png","ezgif.com-webp-to-png (1)"/*,"compare_term_insurance_icon.png"*/]
    
    var addType = ""
    
   override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backBtnCliked(_ sender: Any)
    {
        
//        let KYDrawer : KYDrawerController = self.storyboard?.instantiateViewController(withIdentifier: "stbKYDrawerController") as! KYDrawerController
//        KYDrawer.modalPresentationStyle = .fullScreen
//        present(KYDrawer, animated: true, completion: nil)
        
          self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func homeBtnCliked(_ sender: Any)
    {
        if(addType == "CHILD"){
            
            self.remove()
        }else{
//            let KYDrawer : KYDrawerController = self.storyboard?.instantiateViewController(withIdentifier: "stbKYDrawerController") as! KYDrawerController
//            KYDrawer.modalPresentationStyle = .fullScreen
//            present(KYDrawer, animated: true, completion: nil)
            
             self.dismiss(animated: false, completion: nil)
        }
        
    }
    
    
    //<tableView Datasource+Delegates>
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lifeinsuranceLblArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! lifeInsuranceTVCell
        tableView.backgroundColor = UIColor.init(red: 234/255, green: 234/255, blue: 234/255, alpha: 1)

        cell.lifeIncellLbl.text = lifeinsuranceLblArray[indexPath.row]
        cell.lifeInImgView.image = UIImage(named: lifeinsuranceImgArray[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.row == 0)
        {
            let MotorInsuranceV : MotorInsuranceVCS = self.storyboard?.instantiateViewController(withIdentifier: "stbMotorInsuranceVCS") as! MotorInsuranceVCS
            MotorInsuranceV.modalPresentationStyle = .fullScreen
            MotorInsuranceV.fromScreen = "compareTerm"
            MotorInsuranceV.InsurerID = "0"
            present(MotorInsuranceV, animated:true, completion: nil)
        }
        if(indexPath.row == 1)
        {
            let MotorInsuranceV : MotorInsuranceVCS = self.storyboard?.instantiateViewController(withIdentifier: "stbMotorInsuranceVCS") as! MotorInsuranceVCS
            MotorInsuranceV.modalPresentationStyle = .fullScreen
            MotorInsuranceV.fromScreen = "hdfcLife"
            MotorInsuranceV.InsurerID = "28"
            present(MotorInsuranceV, animated:true, completion: nil)
        }
        if(indexPath.row == 2)
        {
            let MotorInsuranceV : MotorInsuranceVCS = self.storyboard?.instantiateViewController(withIdentifier: "stbMotorInsuranceVCS") as! MotorInsuranceVCS
            MotorInsuranceV.modalPresentationStyle = .fullScreen
            MotorInsuranceV.fromScreen = "iciciPruden"
            MotorInsuranceV.InsurerID = "39"
            present(MotorInsuranceV, animated:true, completion: nil)
        }
        if(indexPath.row == 3)
        {
            
        }
        
    }
    
    
}
