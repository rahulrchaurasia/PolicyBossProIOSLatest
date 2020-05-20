//
//  commonQuotesVC.swift
//  MagicFinmart
//
//  Created by Admin on 28/02/19.
//  Copyright © 2019 Ashwini. All rights reserved.
//

import UIKit
import CustomIOSAlertView
import TTGSnackbar

class commonQuotesVC: UIViewController,UITableViewDelegate,UITableViewDataSource,leadHistoryDelegates {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var homeLTV: UITableView!
    var fromScreen = ""
    var titleL = ""
    var loanType = ""
    var leadID = ""
    var hNameArray = [String]()
    var hloanAmountArray = [String]()
    var hleadIdArray = [String]()
    var happDateArray = [String]()
    var happstatusArray = [String]()
    var bankImageArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(titleL == "PERSONAL LOAN")
        {
            titleLbl.text! = "PERSONAL LOAN"
        }
        else if(titleL == "BUSINESS LOAN")
        {
            titleLbl.text! = "BUSINESS LOAN"
        }
        else if(titleL == "HOME LOAN")
        {
            titleLbl.text! = "HOME LOAN"
        }
        else if(titleL == "LAP LOAN")
        {
            titleLbl.text! = "LAP LOAN"
        }
        getloanrequestAPI()
    }
   
    @IBAction func backBtnCliked(_ sender: Any)
    {
        let KYDrawer : KYDrawerController = self.storyboard?.instantiateViewController(withIdentifier: "stbKYDrawerController") as! KYDrawerController
        present(KYDrawer, animated: true, completion: nil)
    }
    @IBAction func homeBtnCliked(_ sender: Any)
    {
        let KYDrawer : KYDrawerController = self.storyboard?.instantiateViewController(withIdentifier: "stbKYDrawerController") as! KYDrawerController
        present(KYDrawer, animated: true, completion: nil)
    }
    
    //---<tableView Datasource + Delegates>---
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hNameArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! commonQuotesTVCell
        
        cell.hNameLbl.text! = hNameArray[indexPath.row].uppercased()
        cell.happNumLbl.text! = hleadIdArray[indexPath.row]
        cell.hloanAmountLbl.text! = hloanAmountArray[indexPath.row]
        cell.happDateLbl.text! = happDateArray[indexPath.row]
        cell.hprogressLbl.text! = happstatusArray[indexPath.row] + "%"
        
        let imgURL = NSURL(string: bankImageArray[indexPath.row])
        if (imgURL != nil){
            let data = NSData(contentsOf: (imgURL as URL?)!)
            cell.haimgView.image = UIImage(data: data! as Data)
        }
        //--<show percentage on progressView>--
        let counter:Int = 0
        let value = happstatusArray[indexPath.row]
        let value1:Float = Float(value)!/100.0
        print("value1",value1)
        let animated = counter != 0
        cell.hprogressView.setProgress(value1, animated: animated)
        
        cell.leadHistdelegate = self
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    //---callleadHistoryView--
    func leadHistoryTapped(cell: commonQuotesTVCell)
    {
        let indexPath = self.homeLTV.indexPath(for: cell)
        leadID = self.hleadIdArray[(indexPath!.row)]
        let loanleadHistory : loanleadHistoryVC = self.storyboard?.instantiateViewController(withIdentifier: "stbloanleadHistoryVC") as! loanleadHistoryVC
        loanleadHistory.leadIDString = leadID
        self.addChild(loanleadHistory)
        self.view.addSubview(loanleadHistory.view)
    }
    @IBAction func addquoteBtnCliked(_ sender: Any)
    {
        gotoCitiesVC()
    }
    @IBAction func addplusBtnCliked(_ sender: Any)
    {
        gotoCitiesVC()
    }
    
    func gotoCitiesVC()
    {
        let cmnloanselectCity : cmnloanselectCityVC = self.storyboard!.instantiateViewController(withIdentifier: "stbcmnloanselectCityVC") as! cmnloanselectCityVC
        if(titleLbl.text! == "PERSONAL LOAN"){
            cmnloanselectCity.titlLbl = "PERSONAL LOAN"
        }
        else if(titleLbl.text! == "BUSINESS LOAN"){
            cmnloanselectCity.titlLbl = "BUSINESS LOAN"
        }
        else if(titleLbl.text! == "HOME LOAN"){
            cmnloanselectCity.titlLbl = "HOME LOAN"
        }
        else if(titleLbl.text! == "LAP LOAN"){
            cmnloanselectCity.titlLbl = "LAP LOAN"
        }
        present(cmnloanselectCity, animated: true, completion: nil)
    }
    
    //---<APICALL>---
    func getloanrequestAPI()
    {
        
        if Connectivity.isConnectedToInternet()
        {
        let alertView:CustomIOSAlertView = FinmartStyler.getLoadingAlertViewWithMessage("Please Wait...")
        if let parentView = self.navigationController?.view
        {
            alertView.parentView = parentView
        }
        else
        {
            alertView.parentView = self.view
        }
        alertView.show()
        
        let FBAId = UserDefaults.standard.string(forKey: "FBAId")

        let params: [String: AnyObject] = ["Type": loanType as AnyObject,
                                           "FBAID": FBAId as AnyObject,
//                                           "FBAID":"35862" as AnyObject,
                                           "Count":"0" as AnyObject]
        
        let url = "/api/getloanrequest"
        
        FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
            alertView.close()
            
            self.view.layoutIfNeeded()
            
            let jsonData = userObject as? NSArray
            
            if jsonData?.count == 0
            {
                TTGSnackbar.init(message: "Data Not Found", duration: .long).show()
                if(self.fromScreen == "NO DATA")
                {
                    let KYDrawer : KYDrawerController = self.storyboard?.instantiateViewController(withIdentifier: "stbKYDrawerController") as! KYDrawerController
                    self.present(KYDrawer, animated: true, completion: nil)
                }
                else{
                     self.gotoCitiesVC()
                }
            }
            else{
                let Name = jsonData?.value(forKey: "Name") as AnyObject
                self.hNameArray = Name as! [String]
                let LoanAmount = jsonData?.value(forKey: "LoanAmount") as AnyObject
                self.hloanAmountArray = LoanAmount as! [String]
                let LeadId = jsonData?.value(forKey: "LeadId") as AnyObject
                self.hleadIdArray = LeadId as! [String]
                let ApplDate = jsonData?.value(forKey: "ApplDate") as AnyObject
                self.happDateArray = ApplDate as! [String]
                let StatusPercent = jsonData?.value(forKey: "StatusPercent") as AnyObject
                self.happstatusArray = StatusPercent as! [String]
                let bank_image = jsonData?.value(forKey: "bank_image") as AnyObject
                self.bankImageArray = bank_image as! [String]
                
                self.homeLTV.reloadData()
            }
            
        }, onError: { errorData in
            alertView.close()
            let snackbar = TTGSnackbar.init(message: errorData.errorMessage, duration: .long)
            snackbar.show()
        }, onForceUpgrade: {errorData in})
            
        }else{
            let snackbar = TTGSnackbar.init(message: Connectivity.message, duration: .middle )
            snackbar.show()
        }
        
    }
    
  
}
