//
//  loanleadHistoryVC.swift
//  MagicFinmart
//
//  Created by iOS Developer on 26/07/19.
//  Copyright © 2019 Ashwini. All rights reserved.
//

import UIKit
import CustomIOSAlertView
import TTGSnackbar

class loanleadHistoryVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var historyView: UIView!
    @IBOutlet weak var leadHistoryView: UIView!
    @IBOutlet weak var leadDetailsTV: UITableView!
    @IBOutlet weak var customNameLbl: UILabel!
    @IBOutlet weak var mobileLbl: UILabel!
    @IBOutlet weak var bankNameLbl: UILabel!
    @IBOutlet weak var prodctNameLbl: UILabel!
    var updatedByArray = [String]()
    var statusArray = [String]()
    var followupDateArray = [String]()
    var updateddateArray = [String]()
    var remarkArray = [String]()
    var leadIDString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let borderColr = UIColor.lightGray
        leadHistoryView.layer.cornerRadius=2.0;
        leadHistoryView.layer.borderWidth=1.0;
        leadHistoryView.layer.borderColor=borderColr.cgColor;
        historyView.layer.cornerRadius=2.0;
        historyView.layer.borderWidth=1.0;
        historyView.layer.borderColor=borderColr.cgColor;
        historyView.layer.shadowColor=borderColr.cgColor;
        
        getleadHistoryAPI()
        
    }
    
    //--<tableViewdatasource + Deleagts method>--
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return updatedByArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! loanleadHistoryTVCell
        
        cell.updatedbycellLbl.text! = updatedByArray[indexPath.row]
        cell.statuscellLbl.text! = statusArray[indexPath.row]
        cell.followupDateLbl.text! = followupDateArray[indexPath.row]
        cell.updatedcellLbl.text! = updateddateArray[indexPath.row]
        cell.remarkcellLbl.text! = remarkArray[indexPath.row]
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 162
    }
    
    @IBAction func backtoApplication(_ sender: Any)
    {
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
    
   //----APICALL-----
    func getleadHistoryAPI()
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
        
        let params: [String: AnyObject] = ["LeadId": leadIDString as AnyObject]
        
        let url = "/LoginDtls.svc/XMLService/getleadHistory"
        
        FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
            alertView.close()
            
            self.view.layoutIfNeeded()
            
            let jsonData = userObject as? NSDictionary
            let cust_Name = jsonData?.value(forKey: "cust_Name") as AnyObject
            self.customNameLbl.text! = cust_Name.uppercased as String
            let bank_Name = jsonData?.value(forKey: "bank_Name") as AnyObject
            self.bankNameLbl.text! = bank_Name as! String
            let mobileNo = jsonData?.value(forKey: "mobileNo") as AnyObject
            self.mobileLbl.text! = mobileNo as! String
            let product_Name = jsonData?.value(forKey: "product_Name") as AnyObject
            self.prodctNameLbl.text! = product_Name.uppercased as String
            
            let lstLeadDtls = jsonData?.value(forKey: "lstLeadDtls") as! NSArray
            
            for i in 0..<lstLeadDtls.count {
                
                let dict = lstLeadDtls[i]
                let updatedBy = (dict as AnyObject).value(forKey: "updatedBy") as AnyObject
                self.updatedByArray.append(updatedBy as! String)
                let Status = (dict as AnyObject).value(forKey: "Status") as AnyObject
                self.statusArray.append(Status as! String)
                let followupDate = (dict as AnyObject).value(forKey: "followupDate") as AnyObject
                self.followupDateArray.append(followupDate as! String)
                let updatedDate = (dict as AnyObject).value(forKey: "updatedDate") as AnyObject
                self.updateddateArray.append(updatedDate as! String)
                let Remark = (dict as AnyObject).value(forKey: "Remark") as AnyObject
                self.remarkArray.append(Remark as! String)
            }
           
            self.leadDetailsTV.reloadData()
            
        }, onError: { errorData in
            alertView.close()
            let snackbar = TTGSnackbar.init(message: errorData.errorMessage, duration: .long)
            snackbar.show()
        }, onForceUpgrade: {errorData in},checkLead: true)
        
        }else{
            let snackbar = TTGSnackbar.init(message: Connectivity.message, duration: .middle )
            snackbar.show()
        }
    }
    
    
}
