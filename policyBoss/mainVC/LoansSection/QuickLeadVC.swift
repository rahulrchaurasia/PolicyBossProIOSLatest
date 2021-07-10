//
//  QuickLeadVC.swift
//  MagicFinmart
//
//  Created by Admin on 01/02/19.
//  Copyright © 2019 Ashwini. All rights reserved.
//

import UIKit
import WebKit
import CustomIOSAlertView
import TTGSnackbar

class QuickLeadVC: UIViewController,WKNavigationDelegate,getPickerDataDelegate,SelectedDateDelegate,UITextFieldDelegate {
 
    @IBOutlet weak var nameTf: ACFloatingTextfield!
    @IBOutlet weak var emailTf: ACFloatingTextfield!
    @IBOutlet weak var mobnoTf: ACFloatingTextfield!
    @IBOutlet weak var statusTf: ACFloatingTextfield!
    @IBOutlet weak var followDateTf: ACFloatingTextfield!
    @IBOutlet weak var monthlyIncomeTf: ACFloatingTextfield!
    @IBOutlet weak var productLbl: UILabel!
    @IBOutlet weak var loanAmountTf: ACFloatingTextfield!
    @IBOutlet weak var remarkTf: ACFloatingTextfield!
    
    @IBOutlet weak var leadTfView: UIView!
    @IBOutlet weak var quickLeadWebView: WKWebView!
    
    var productID = ""
    var productNameArray = ["Business Loan","Car Loan","Car Refinance","Home Loan BT","Lap BT","LRD","Merchant Business"," Used car Loan","Working Capital"]
    var productNameIDArray = ["1","2","3","4","5","6","7","8","9"]
    
    let alertView:CustomIOSAlertView = FinmartStyler.getLoadingAlertViewWithMessage("Please Wait...")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let borderColor = UIColor.lightGray
        leadTfView.layer.cornerRadius=2.0;
        leadTfView.layer.borderWidth=1.0;
        leadTfView.layer.borderColor=borderColor.cgColor;
        
        alertView.show();
        quickLeadWebView.navigationDelegate = self
        quickLeadWebView.load(URLRequest(url: URL(string: "http://erp.rupeeboss.com/loansrepository/Loans-repository.html")!))
        quickLeadWebView.allowsBackForwardNavigationGestures = true
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!)
    {
        alertView.close()
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
        
//        let KYDrawer : KYDrawerController = self.storyboard?.instantiateViewController(withIdentifier: "stbKYDrawerController") as! KYDrawerController
//         KYDrawer.modalPresentationStyle = .fullScreen
//        present(KYDrawer, animated: true, completion: nil)
        
           self.dismiss(animated: false, completion: nil)
        
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if(textField == mobnoTf)
        {
            if((textField.text?.count)! <= 9)
            {
                let allowedCharacters = CharacterSet.decimalDigits
                let characterSet = NSCharacterSet(charactersIn: string)
                return allowedCharacters.isSuperset(of: characterSet as CharacterSet)
            }
            else{
                //            let characterCountLimit = 30
                // We need to figure out how many characters would be in the string after the change happens
                let startingLength = textField.text?.count ?? 0
                let lengthToAdd = string.count
                let lengthToReplace = range.length
                let newLength = startingLength + lengthToAdd - lengthToReplace
                
                return newLength <= (textField.text?.count)!
            }
        }
        return true
    }
    
    @IBAction func follwupDateBtnCliked(_ sender: Any)
    {
        self.view.endEditing(true)
        let DatePicker : DatePickerVC = storyboard?.instantiateViewController(withIdentifier: "stbDatePickerVC") as! DatePickerVC
        DatePicker.fromScreen = "QuickLead"
        self.addChild(DatePicker)
        self.view.addSubview(DatePicker.view)
        DatePicker.dateDelegate = self
    }
    
    func getDateData(currDate: String, fromScreen: String) {
        print(currDate)
        followDateTf.text = currDate
        followDateTf.textColor = UIColor.black
    }
   
    func getintData(indata: Int) {
        
    }
    
    @IBAction func productdropBtnCliked(_ sender: Any)
    {
        self.view.endEditing(true)
        let Picker : PickerViewVC! = storyboard?.instantiateViewController(withIdentifier: "stbPickerViewVC") as? PickerViewVC
        Picker.fromScreen = "product"
        Picker.pickerData = ["Select"]+productNameArray
        Picker.pickerIdData = [""]+productNameIDArray
        self.addChild(Picker)
        self.view.addSubview(Picker.view)
        Picker.pickerdelegate = self
    }
    
    func getPickerDataValue(pickerSelectedData: String, fromScreen: String, pickerSelectedId: String) {
        switch fromScreen
        {
        case "product":
            self.productLbl.text = pickerSelectedData
            self.productID = pickerSelectedId
            break
        default:
            break
        }
        
    }
    
    @IBAction func submitBtnCliked(_ sender: Any)
    {
        if(nameTf.text! != "" && mobnoTf.text! != "" && mobnoTf.text!.count == 10 && statusTf.text! != "" && followDateTf.text! != "" && monthlyIncomeTf.text! != "" && loanAmountTf.text! != "" && remarkTf.text! != "")
        {
            if(isValidEmail(testStr:emailTf.text!))
            {
                quickleadAPI()
            }
            else{
                TTGSnackbar.init(message: "Invalid Email ID", duration: .long).show()
            }
        }
        else if(nameTf.text! == ""){
            TTGSnackbar.init(message: "Please enter Name", duration: .long).show()
        }
        else if(mobnoTf.text! == ""){
            TTGSnackbar.init(message: "Please enter mobile number", duration: .long).show()
        }
        else if(mobnoTf.text!.count != 10){
            TTGSnackbar.init(message: "Please enter 10 digit mobile number", duration: .long).show()
        }
        else if(statusTf.text! == ""){
            TTGSnackbar.init(message: "Please enter Status", duration: .long).show()
        }
        else if(followDateTf.text! == ""){
            TTGSnackbar.init(message: "Please enter follow up date", duration: .long).show()
        }
        else if(monthlyIncomeTf.text! == ""){
            TTGSnackbar.init(message: "Please enter Monthly Income", duration: .long).show()
        }
        else if(loanAmountTf.text! == ""){
            TTGSnackbar.init(message: "Please enter Loan Amount", duration: .long).show()
        }
        else if(remarkTf.text! == ""){
            TTGSnackbar.init(message: "Please enter Remark", duration: .long).show()
        }
    }
    
    //---<EmailValidation>---
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    

    //---<APICALL>---
    func quickleadAPI()
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
        let loanselfid = UserDefaults.standard.string(forKey: "loanselfid")
        let params: [String: AnyObject] = [ "EMail": emailTf.text! as AnyObject,
                                            "FBA_Id": FBAId as AnyObject,
                                            "Loan_amt": loanAmountTf.text! as AnyObject,
                                            "Mobile": mobnoTf.text! as AnyObject,
                                            "Monthly_income": monthlyIncomeTf.text! as AnyObject,
                                            "Name": nameTf.text! as AnyObject,
                                            "ProductId": productID as AnyObject,
                                            "Remark": remarkTf.text! as AnyObject,
                                            "brokerId": loanselfid as AnyObject,
                                            "followupDate": followDateTf.text! as AnyObject]
        
        let url = "/api/quick-lead"
        
        FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
            alertView.close()
            
            self.view.layoutIfNeeded()
            
            let jsonData = userObject as? NSDictionary
            
            TTGSnackbar.init(message: "Lead Submitted Successfully", duration: .long).show()
            
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
