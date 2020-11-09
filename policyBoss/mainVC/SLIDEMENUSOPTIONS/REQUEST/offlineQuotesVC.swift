//
//  offlineQuotesVC.swift
//  MagicFinmart
//
//  Created by Ashwini on 27/12/18.
//  Copyright © 2018 Ashwini. All rights reserved.
//

import UIKit
import CustomIOSAlertView
import TTGSnackbar

class offlineQuotesVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet var healthChckupTV: UITableView!
    
    var firstNameArray = [String]()
    var mobNoArray = [String]()
    var packNameArray = [String]()
    var mrpArray = [String]()
    var statusArray = [String]()
    
    var firstName = ""
    var mobNumb = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //<apiCall>
        healthassureconfigureAPI()
    }
    
    @IBAction func backBtnCliked(_ sender: Any)
    {
        let KYDrawer : KYDrawerController = self.storyboard?.instantiateViewController(withIdentifier: "stbKYDrawerController") as! KYDrawerController
        KYDrawer.modalPresentationStyle = .fullScreen
        present(KYDrawer, animated: true, completion: nil)
       //  dismiss(animated: true)
    }
    
    @IBAction func homeBtnCliked(_ sender: Any)
    {
        let KYDrawer : KYDrawerController = self.storyboard?.instantiateViewController(withIdentifier: "stbKYDrawerController") as! KYDrawerController
        KYDrawer.modalPresentationStyle = .fullScreen
        present(KYDrawer, animated: true, completion: nil)
        
         //dismiss(animated: true)
    }
    
    //<tableViewDatasource+Delegates>
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return firstNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! offlineQuotesTVCell
        
        cell.firstNameLbl.text! = firstNameArray[indexPath.row]
        cell.mobNoLbl.text! = mobNoArray[indexPath.row]
        cell.pckNameLbl.text! = packNameArray[indexPath.row]
        cell.mrpLbl.text! = mrpArray[indexPath.row]
        cell.statusLbl.text! = statusArray[indexPath.row]
        
        self.mobNumb = mobNoArray[indexPath.row]
        self.firstName = firstNameArray[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    
    @IBAction func plusBtnCliked(_ sender: Any)
    {
        let healthAssure : healthAssureVC = self.storyboard?.instantiateViewController(withIdentifier: "stbhealthAssureVC") as! healthAssureVC
        healthAssure.hmobNo = self.mobNumb
        healthAssure.hfirstNme = self.firstName
        healthAssure.modalPresentationStyle = .fullScreen
        present(healthAssure, animated: true, completion: nil)
    }
    
    
    //--<APICALL>--
    func healthassureconfigureAPI()
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
        
        let params: [String: AnyObject] = ["FBAID":FBAId as AnyObject]
        
        let url = "/api/health-assure-configure"
        
        FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
            alertView.close()
            
            self.view.layoutIfNeeded()
            
            let jsonData = userObject as? NSArray
            let FirstName = jsonData?.value(forKey: "FirstName") as AnyObject
            self.firstNameArray = FirstName as! [String]
            let Mobile = jsonData?.value(forKey: "Mobile") as AnyObject
            self.mobNoArray = Mobile as! [String]
            let PackName = jsonData?.value(forKey: "PackName") as AnyObject
            self.packNameArray = PackName as! [String]
            let MRP = jsonData?.value(forKey: "MRP") as AnyObject
            let mrpArrayS = MRP as! [Int]
            self.mrpArray = mrpArrayS.map { String($0) }
            let Status = jsonData?.value(forKey: "Status") as AnyObject
            self.statusArray = Status as! [String]
            
            self.healthChckupTV.reloadData()
            
            
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
