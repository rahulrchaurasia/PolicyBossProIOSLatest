//
//  loans(shareData)VC.swift
//  MagicFinmart
//
//  Created by Ashwini on 27/12/18.
//  Copyright © 2018 Ashwini. All rights reserved.
//

import UIKit
import CustomIOSAlertView
import TTGSnackbar

class loans_shareData_VC: UIViewController,UITableViewDelegate,UITableViewDataSource,shareBtnDelegate {
    
    @IBOutlet var loanLeadTV: UITableView!
    var titleArray = [String]()
    var msgBodyArray = [String]()
    var linkArray = [String]()
    var shareLinkText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //apiCall
        generateloanLeadAPI()
        
    }

    @IBAction func backBtnCliked(_ sender: Any)
    {
        let KYDrawer : KYDrawerController = self.storyboard?.instantiateViewController(withIdentifier: "stbKYDrawerController") as! KYDrawerController
        present(KYDrawer, animated: true, completion: nil)
    }
    
    //<tableViewDatasource+Delegates>
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! loansshareDataTVCell
        
        cell.titleLbl.text! = titleArray[indexPath.row]
        cell.msgbodyLbl.text! = msgBodyArray[indexPath.row]
        cell.linkLbl.text! = linkArray[indexPath.row]
        
        //--shareRowtext--
        cell.sharedelegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func shareBtnTapped(cell: loansshareDataTVCell) {
        //Get the indexpath of cell where button was tapped
        let indexPath = self.loanLeadTV.indexPath(for: cell)
        shareLinkText = linkArray[indexPath!.row]
        
        let vc = UIActivityViewController(activityItems: [shareLinkText], applicationActivities: [])
        present(vc, animated: true)
        
    }
    
    //<endtableViewDatasource+Delegates>
    
    
    
    //---<APICALL>---
    func generateloanLeadAPI()
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
       
        let loansendid = UserDefaults.standard.string(forKey: "loansendid")
        
        let params: [String: AnyObject] = ["brokerid": loansendid as AnyObject,
                                           "EmpCode": "0" as AnyObject]
        
        let url = "/LoginDtls.svc/XMLService/dsplyMsgLnkDtlsForFinmart"
        
        FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params as [String : AnyObject], onSuccess: { (userObject, metadata) in
            alertView.close()
            
            self.view.layoutIfNeeded()
            
            let jsonData = userObject as? NSDictionary
            let lstMsgLnkDtls = jsonData!.value(forKey: "lstMsgLnkDtls") as AnyObject
            let title = lstMsgLnkDtls.value(forKey: "title") as AnyObject
            self.titleArray = title as! [String]
            let MsgBody = lstMsgLnkDtls.value(forKey: "MsgBody") as AnyObject
            self.msgBodyArray = MsgBody as! [String]
            let link = lstMsgLnkDtls.value(forKey: "link") as AnyObject
            self.linkArray = link as! [String]
                
            self.loanLeadTV.reloadData()
            
        }, onError: { errorData in
            alertView.close()
            let snackbar = TTGSnackbar.init(message: errorData.errorMessage, duration: .long)
            snackbar.show()
        }, onForceUpgrade: {errorData in},checkLead: true)
        
    }
    
    
    
    
}
