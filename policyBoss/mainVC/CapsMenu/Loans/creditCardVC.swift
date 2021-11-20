//
//  creditCardVC.swift
//  MagicFinmart
//
//  Created by iOS Developer on 13/08/19.
//  Copyright © 2019 Ashwini. All rights reserved.
//

import UIKit
import CustomIOSAlertView
import TTGSnackbar

class creditCardVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var credittableView: UITableView!
    var fullNameArray = [String]()
    var mobNoArray = [String]()
    var emailIdArray = [String]()
    var cardTypeArray = [String]()
    var crditcardNameArray = [String]()
    var appNoArray = [String]()
    var statusArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboardWhenTappedAround()
        savedcreditcardinfoAPI()
    }
   
    @IBAction func backBtnCliked(_ sender: Any)
    {
        let KYDrawer : KYDrawerController = self.storyboard?.instantiateViewController(withIdentifier: "stbKYDrawerController") as! KYDrawerController
         KYDrawer.modalPresentationStyle = .fullScreen
        present(KYDrawer, animated: true, completion: nil)
    }
    
    @IBAction func addQuotesBtnCliked(_ sender: Any)
    {
        let creditcrdpersnlInfo : creditcrdpersnlInfoVC = self.storyboard?.instantiateViewController(withIdentifier: "stbcreditcrdpersnlInfoVC") as! creditcrdpersnlInfoVC
//        self.addChild(creditcrdpersnlInfo)
//        self.view.addSubview(creditcrdpersnlInfo.view)
         creditcrdpersnlInfo.modalPresentationStyle = .fullScreen
        present(creditcrdpersnlInfo, animated: true, completion: nil)
    }
    
    @IBAction func addplusBtnCliked(_ sender: Any)
    {
        let creditcrdpersnlInfo : creditcrdpersnlInfoVC = self.storyboard?.instantiateViewController(withIdentifier: "stbcreditcrdpersnlInfoVC") as! creditcrdpersnlInfoVC
//        self.addChild(creditcrdpersnlInfo)
//        self.view.addSubview(creditcrdpersnlInfo.view)
         creditcrdpersnlInfo.modalPresentationStyle = .fullScreen
        present(creditcrdpersnlInfo, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fullNameArray.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! creditCardTVCell
        
        cell.fullNameLbl.text! = fullNameArray[indexPath.row]
        cell.emailIdLbl.text! = emailIdArray[indexPath.row]
        cell.mobNoLbl.text! = mobNoArray[indexPath.row]
        cell.cardTypeLbl.text! = cardTypeArray[indexPath.row]
        cell.creditcardnameLbl.text! = crditcardNameArray[indexPath.row]
        cell.appNoLbl.text! = appNoArray[indexPath.row]
        cell.statusLbl.text! = statusArray[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 148
    }
    
    
    //---<APICALL>---
    func savedcreditcardinfoAPI()
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
        
        let params: [String: AnyObject] = ["fba_id":FBAId as AnyObject,
                                           "CardType":"0" as AnyObject,]
        
        let url = "get-saved-creditcard-info"
        
        FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
            alertView.close()
            
            self.view.layoutIfNeeded()
            
            let jsonData = userObject as? NSArray
            print("jsonData=",jsonData!)
            
            self.fullNameArray = jsonData?.value(forKey: "FullName") as! [String]
            self.emailIdArray = jsonData?.value(forKey: "Email") as! [String]
            self.mobNoArray = jsonData?.value(forKey: "MobileNo") as! [String]
            self.cardTypeArray = jsonData?.value(forKey: "CardType") as! [String]
            self.crditcardNameArray = jsonData?.value(forKey: "CreditCardName") as! [String]
            self.appNoArray = jsonData?.value(forKey: "ApplicationNo") as! [String]
            self.statusArray = jsonData?.value(forKey: "Status") as! [String]
            
            self.credittableView.reloadData()
            
            
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
