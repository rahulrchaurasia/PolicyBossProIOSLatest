//
//  creditCardListVC.swift
//  MagicFinmart
//
//  Created by iOS Developer on 13/08/19.
//  Copyright © 2019 Ashwini. All rights reserved.
//

import UIKit
import Foundation
import CustomIOSAlertView
import TTGSnackbar

class creditCardListVC: UIViewController,UITableViewDataSource,UITableViewDelegate,creditcardBtnsDelegates {
    
    @IBOutlet weak var creditcardsTV: UITableView!
    @IBOutlet weak var creditcardDiscriptionView: UIView!
    @IBOutlet weak var creditcardDriscriptnViewBtn: UIButton!
    @IBOutlet weak var discriptionLbl: UILabel!
    
    var cardbankNameArray = [String]()
    var cardTypeArray = [String]()
    var cardImgArray = [String]()
    var descriptionArray = [String]()
    var processingFeesArray = [String]()
    var creditCardAppliedArray = [String]()
    var CreditCardDetailIdArray = [Int]()
    var salarytypeArray = [String]()
    var income = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        creditcardDiscriptionView.isHidden = true
        getcreditcarddataAPI()
        
    }
    
    @IBAction func backBtnCliked(_ sender: Any)
    {
        let KYDrawer : KYDrawerController = self.storyboard?.instantiateViewController(withIdentifier: "stbKYDrawerController") as! KYDrawerController
        present(KYDrawer, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardbankNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! creditcardListTVCell
        
        cell.creditCardNameLbl.text! = cardbankNameArray[indexPath.row]
        cell.creditCardTypeLbl.text! = cardTypeArray[indexPath.row]
        //loadImages
        let imgURL = NSURL(string: cardImgArray[indexPath.row])
        if imgURL != nil {
            let data = NSData(contentsOf: (imgURL as URL?)!)
            cell.creditCardImgView.image = UIImage(data: data! as Data)
        }
        
        cell.creCrdBtnsDelegates = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

    @IBAction func crdtcarddiscripbckBtn(_ sender: Any)
    {
        creditcardDiscriptionView.isHidden = true
    }
    
    @IBAction func filterBtnCliked(_ sender: Any)
    {
        let creditcrdpersnlInfo : creditcrdpersnlInfoVC = self.storyboard?.instantiateViewController(withIdentifier: "stbcreditcrdpersnlInfoVC") as! creditcrdpersnlInfoVC
        self.addChild(creditcrdpersnlInfo)
        self.view.backgroundColor = UIColor.init(red: 30/225.0, green: 30/225.0, blue: 30/225.0, alpha: 1)
        self.view.addSubview(creditcrdpersnlInfo.view)
    }
    
    func infoBtnTapped(cell: creditcardListTVCell)
    {
        creditcardDiscriptionView.isHidden = false
        let indexPath = self.creditcardsTV.indexPath(for: cell)
        let discriptionText = self.descriptionArray[(indexPath!.row)]
        //addBullets
        let splitArray = discriptionText.components(separatedBy: "|")
        discriptionLbl.attributedText = NSAttributedStringHelper.createBulletedList(fromStringArray: splitArray, font: UIFont.systemFont(ofSize: 16))
        
    }
    
    func applyBtnTapped(cell: creditcardListTVCell)
    {
        let indexPath = self.creditcardsTV.indexPath(for: cell)
        let cardName = self.cardbankNameArray[(indexPath!.row)]
        let cardType = self.cardTypeArray[(indexPath?.row)!]
        let processingFees = processingFeesArray[(indexPath?.row)!]
        let CreditCardApplied = creditCardAppliedArray[(indexPath?.row)!]
        let CreditCardDetailId = CreditCardDetailIdArray[(indexPath?.row)!]
        let salaryType = salarytypeArray[(indexPath?.row)!]
        if(cardName.contains("ICICI"))
        {
            let iciciCreditCard : iciciCreditCardVC = self.storyboard?.instantiateViewController(withIdentifier: "stbiciciCreditCardVC") as! iciciCreditCardVC
            present(iciciCreditCard, animated: true, completion: nil)
        }
        else if(cardName.contains("RBL"))
        {
            let rblCreditCard : rblCreditCardVC = self.storyboard?.instantiateViewController(withIdentifier: "stbrblCreditCardVC") as! rblCreditCardVC
            rblCreditCard.cardtypeStr = cardType
            rblCreditCard.processingfeeStr = processingFees
            rblCreditCard.creditCardDetailIdStr = CreditCardDetailId
            rblCreditCard.creditCardAppliedIdStr = CreditCardApplied
            rblCreditCard.salaryType = salaryType
            present(rblCreditCard, animated: true, completion: nil)
        }
    
    }
    
    @IBAction func discriptionVOkBtnCliked(_ sender: Any)
    {
        creditcardDiscriptionView.isHidden = true
    }
    
    //---<APICALL>---
    func getcreditcarddataAPI()
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
        
        let params: [String: AnyObject] = [:]
        
        let url = "/api/get-credit-card-data"
        
        FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
            alertView.close()
            
            self.view.layoutIfNeeded()
            
            let jsonData = userObject as? NSDictionary
            
            let filter = jsonData?.value(forKey: "filter") as! NSArray
            let filterdata = jsonData?.value(forKey: "filterdata") as! NSArray
            
            let CreditCardAmountFilterId = filter.value(forKey: "CreditCardAmountFilterId") as! [Int]
            for i in 0..<filterdata.count {
                
                let dict = filterdata[i]
                
                let CreditCardAmountFilterId = (dict as AnyObject).value(forKey: "CreditCardAmountFilterId") as! Int
                func calldata(){
                    let bankName = (dict as AnyObject).value(forKey: "BankName") as! String
                    self.cardbankNameArray.append(bankName)
                    self.cardTypeArray.append((dict as AnyObject).value(forKey: "CreditCardType") as! String)
                    let cardImgArr = (dict as AnyObject).value(forKey: "ImagePath") as AnyObject
                    let img = (cardImgArr as? String)!
                    self.cardImgArray.append(img)
                    self.descriptionArray.append((dict as AnyObject).value(forKey: "Description") as! String)
                    self.processingFeesArray.append((dict as AnyObject).value(forKey: "ProcessingFees") as! String)
                    self.creditCardAppliedArray.append((dict as AnyObject).value(forKey: "CreditCardApplied") as! String)
                    self.CreditCardDetailIdArray.append((dict as AnyObject).value(forKey: "CreditCardDetailId") as! Int)
                    self.salarytypeArray.append((dict as AnyObject).value(forKey: "salarytype") as! String)
                }
                if(CreditCardAmountFilterId == 6 && self.income == 6){
                    calldata()
                }
                else if(CreditCardAmountFilterId == 3 && self.income == 3){
                    calldata()
                }
                else if(CreditCardAmountFilterId == 7 && self.income == 7){
                    calldata()
                }
                else if(CreditCardAmountFilterId == 4 && self.income == 4){
                    calldata()
                }
                else if(CreditCardAmountFilterId == 5 && self.income == 5){
                    calldata()
                }
                
                
            }
            
//            self.cardbankNameArray = filterdata.value(forKey: "BankName") as! [String]
//            self.cardTypeArray = filterdata.value(forKey: "CreditCardType") as! [String]
//            let cardImgArr = filterdata.value(forKey: "ImagePath") as! [AnyObject]
//            self.cardImgArray = (cardImgArr as? [String])!
//            self.descriptionArray = filterdata.value(forKey: "Description") as! [String]
//            self.processingFeesArray = filterdata.value(forKey: "ProcessingFees") as! [String]
//            self.creditCardAppliedArray = filterdata.value(forKey: "CreditCardApplied") as! [String]
//            self.CreditCardDetailIdArray = filterdata.value(forKey: "CreditCardDetailId") as! [Int]
//            self.salarytypeArray = filterdata.value(forKey: "salarytype") as! [String]
//            print("salarytypeArray=",self.salarytypeArray)
//            print("descriptionArray=",self.descriptionArray)
            
            self.creditcardsTV.reloadData()
            
            
        }, onError: { errorData in
            alertView.close()
            let snackbar = TTGSnackbar.init(message: errorData.errorMessage, duration: .long)
            snackbar.show()
        }, onForceUpgrade: {errorData in})
        
    }
    
    
    
}
