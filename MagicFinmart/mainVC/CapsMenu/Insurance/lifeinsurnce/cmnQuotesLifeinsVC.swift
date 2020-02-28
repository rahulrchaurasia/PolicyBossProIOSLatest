//
//  cmnQuotesLifeinsVC.swift
//  MagicFinmart
//
//  Created by Admin on 04/03/19.
//  Copyright © 2019 Ashwini. All rights reserved.
//

import UIKit

class cmnQuotesLifeinsVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var qtableView: UITableView!
    
    var frstNameArray = [String]()
    var crnArray = [String]()
    var quoteDateArray = [String]()
    var contactMobArray = [String]()
    var insdobArray = [String]()
    var inspolicyTermArr = [String]()
    var insuredGenderArr = [String]()
    var is_TabaccoUserArr = [String]()
    var sumAssuredArr = [String]()
    var pPTArr = [String]()
    var pincodeArr = [String]()
    
    var fromScreen = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    //--<tableView Datasource+Delegates>--
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return frstNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! cmnQuotesLifeinsTVCell
        
        cell.contactNameLbl.text! = frstNameArray[indexPath.row].uppercased()
        cell.crnNoLbl.text! = crnArray[indexPath.row]
        cell.quoteDateLbl.text! = quoteDateArray[indexPath.row]
        
//        qtableView.reloadData()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if(fromScreen == "comparetermInput")
        {
            let MotorInsuranceV : MotorInsuranceVCS = self.storyboard?.instantiateViewController(withIdentifier: "stbMotorInsuranceVCS") as! MotorInsuranceVCS
            MotorInsuranceV.fromScreen = "fromcompgetQuote"
            MotorInsuranceV.contactMob = contactMobArray[indexPath.row]
            MotorInsuranceV.contctName = frstNameArray[indexPath.row]
            MotorInsuranceV.dobtxt = insdobArray[indexPath.row]
            MotorInsuranceV.policytrmtxt = inspolicyTermArr[indexPath.row]
            MotorInsuranceV.gndrtxt = insuredGenderArr[indexPath.row]
            MotorInsuranceV.smkrtxt = is_TabaccoUserArr[indexPath.row]
            MotorInsuranceV.sumasstxt = sumAssuredArr[indexPath.row]
            MotorInsuranceV.pretrmtxt = pPTArr[indexPath.row]
            MotorInsuranceV.policytrmtxt = inspolicyTermArr[indexPath.row]
            MotorInsuranceV.pincdetxt = pincodeArr[indexPath.row]
            self.present(MotorInsuranceV, animated:true, completion: nil)
        }
        else if(fromScreen == "hdfcLifeInput")
        {
            let MotorInsuranceV : MotorInsuranceVCS = self.storyboard?.instantiateViewController(withIdentifier: "stbMotorInsuranceVCS") as! MotorInsuranceVCS
            MotorInsuranceV.fromScreen = "fromhdfcgetQuote"
            MotorInsuranceV.contactMob = contactMobArray[indexPath.row]
            MotorInsuranceV.contctName = frstNameArray[indexPath.row]
            MotorInsuranceV.dobtxt = insdobArray[indexPath.row]
            MotorInsuranceV.policytrmtxt = inspolicyTermArr[indexPath.row]
            MotorInsuranceV.gndrtxt = insuredGenderArr[indexPath.row]
            MotorInsuranceV.smkrtxt = is_TabaccoUserArr[indexPath.row]
            MotorInsuranceV.sumasstxt = sumAssuredArr[indexPath.row]
            MotorInsuranceV.pretrmtxt = pPTArr[indexPath.row]
            MotorInsuranceV.policytrmtxt = inspolicyTermArr[indexPath.row]
            MotorInsuranceV.pincdetxt = pincodeArr[indexPath.row]
            self.present(MotorInsuranceV, animated:true, completion: nil)
        }
        else if(fromScreen == "iciciPrudenInput")
        {
            let MotorInsuranceV : MotorInsuranceVCS = self.storyboard?.instantiateViewController(withIdentifier: "stbMotorInsuranceVCS") as! MotorInsuranceVCS
            MotorInsuranceV.fromScreen = "fromicicigetQuote"
            MotorInsuranceV.contactMob = contactMobArray[indexPath.row]
            MotorInsuranceV.contctName = frstNameArray[indexPath.row]
            MotorInsuranceV.dobtxt = insdobArray[indexPath.row]
            MotorInsuranceV.policytrmtxt = inspolicyTermArr[indexPath.row]
            MotorInsuranceV.gndrtxt = insuredGenderArr[indexPath.row]
            MotorInsuranceV.smkrtxt = is_TabaccoUserArr[indexPath.row]
            MotorInsuranceV.sumasstxt = sumAssuredArr[indexPath.row]
            MotorInsuranceV.pretrmtxt = pPTArr[indexPath.row]
            MotorInsuranceV.policytrmtxt = inspolicyTermArr[indexPath.row]
            MotorInsuranceV.pincdetxt = pincodeArr[indexPath.row]
            self.present(MotorInsuranceV, animated:true, completion: nil)
        }
        

    }
    
    
    @IBAction func addQuoteBtnCliked(_ sender: Any)
    {
        
    }
    
    @IBAction func plusBtnCliked(_ sender: Any)
    {
        let MotorInsurance : MotorInsuranceVCS = self.storyboard?.instantiateViewController(withIdentifier: "stbMotorInsuranceVCS") as! MotorInsuranceVCS
        if(fromScreen == "comparetermInput")
        {
            MotorInsurance.fromScreen = "compare"
        }
        else if(fromScreen == "hdfcLifeInput"){
            
            MotorInsurance.fromScreen = "hdfc"
        }
        else if(fromScreen == "iciciPrudenInput")
        {
            MotorInsurance.fromScreen = "icici"
        }
        present(MotorInsurance, animated: true, completion: nil)
    }
    

}
