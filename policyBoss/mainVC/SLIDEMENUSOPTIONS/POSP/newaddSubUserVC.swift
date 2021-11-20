//
//  newaddSubUserVC.swift
//  MagicFinmart
//
//  Created by iOS Developer on 16/07/19.
//  Copyright © 2019 Ashwini. All rights reserved.
//

import UIKit
import CustomIOSAlertView
import TTGSnackbar

class newaddSubUserVC: UIViewController,UITextFieldDelegate,SelectedDateDelegate {

    @IBOutlet weak var addsubUserView: UIView!
    @IBOutlet weak var ufirstNameTf: ACFloatingTextfield!
    @IBOutlet weak var ulastNameTf: ACFloatingTextfield!
    @IBOutlet weak var udobTf: ACFloatingTextfield!
    @IBOutlet weak var umaleBtn: UIButton!
    @IBOutlet weak var ufemaleBtn: UIButton!
    @IBOutlet weak var umobNoTf: ACFloatingTextfield!
    @IBOutlet weak var umobNo2Tf: ACFloatingTextfield!
    @IBOutlet weak var uemailTf: ACFloatingTextfield!
    @IBOutlet weak var upincodeTf: ACFloatingTextfield!
    @IBOutlet weak var ucityTf: ACFloatingTextfield!
    @IBOutlet weak var ustateTf: ACFloatingTextfield!
    
    var Gender = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboardWhenTappedAround()
        
        let borderColor = UIColor.lightGray
        addsubUserView.layer.cornerRadius=5.0;
        addsubUserView.layer.borderWidth=1.0;
        addsubUserView.layer.shadowColor=borderColor.cgColor;
        addsubUserView.layer.borderColor=borderColor.cgColor;
        
        //--<border>--
        btnColorChangeBlue(Btn: umaleBtn)
        btnColorChangeGray(Btn: ufemaleBtn)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func backBtnCliked(_ sender: Any)
    {
        let KYDrawer : KYDrawerController = self.storyboard?.instantiateViewController(withIdentifier: "stbKYDrawerController") as! KYDrawerController
         KYDrawer.modalPresentationStyle = .fullScreen
        present(KYDrawer, animated: true, completion: nil)
        
    }
    
    @IBAction func homeBtnCliked(_ sender: Any)
    {
        let KYDrawer : KYDrawerController = self.storyboard?.instantiateViewController(withIdentifier: "stbKYDrawerController") as! KYDrawerController
         KYDrawer.modalPresentationStyle = .fullScreen
        present(KYDrawer, animated: true, completion: nil)
        
    }
    
    @IBAction func udobBtnCliked(_ sender: Any)
    {
        self.view.endEditing(true)
        let DatePicker : DatePickerVC = storyboard?.instantiateViewController(withIdentifier: "stbDatePickerVC") as! DatePickerVC
        self.addChild(DatePicker)
        self.view.addSubview(DatePicker.view)
        DatePicker.dateDelegate = self
    }
    
    func getDateData(currDate: String, fromScreen: String) {
        print(currDate)
        udobTf.text = currDate
        udobTf.textColor = UIColor.black
    }
    
    func getintData(indata: Int) {
        
    }
    
    //---<textFieldRange>---
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if(textField == umobNoTf  ||  textField == umobNo2Tf)
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
        else if(textField == upincodeTf)
        {
            if((textField.text?.count)! < 6)
            {
                
                let allowedCharacters = CharacterSet.decimalDigits
                let characterSet = NSCharacterSet(charactersIn: string)
                return allowedCharacters.isSuperset(of: characterSet as CharacterSet)
                
            }
                //            else if(pincodeTf.text!.count == 6)
                //            {
                //                print("pincodeTf.text?=",pincodeTf.text!)
                ////                pincodeTf.text? = textField.text!
                //                getCityStateAPI()
                //
                //                return false
                //            }
                //            else if(referrCodeTf.text!.count == 6)
                //            {
                //                print("referrCodeTf.text?=",referrCodeTf.text!)
                //                //                pincodeTf.text? = textField.text!
                //                validaterefercodeAPI()
                //
                //                return false
                //            }
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
        else{
            if((textField.text?.count)! <= 30)
            {
                var allowedCharacters = CharacterSet.letters
                allowedCharacters.formUnion(CharacterSet.whitespaces)
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
        
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        if (textField == self.ucityTf || textField == self.ustateTf)
        {
            getCityStateAPI()
        }
        
    }
    
    @IBAction func umaleBtnCliked(_ sender: Any)
    {
        btnColorChangeBlue(Btn: umaleBtn)
        btnColorChangeGray(Btn: ufemaleBtn)
        
        self.Gender = "M"
        
    }
    
    @IBAction func ufemaleBtnCliked(_ sender: Any)
    {
        btnColorChangeBlue(Btn: ufemaleBtn)
        btnColorChangeGray(Btn: umaleBtn)
        
        self.Gender = "F"
    }
    
    
    @IBAction func useraddBtnCliked(_ sender: Any)
    {
        if(ufirstNameTf.text! != "" && ulastNameTf.text! != "" && udobTf.text! != "" && umobNoTf.text! != "" && uemailTf.text! != "" && upincodeTf.text! != "" && ucityTf.text! != "" && ustateTf.text! != "")
        {
            if(isValidEmail(testStr: uemailTf.text!))
            {
                addChildPospAPI()
            }
            else{
               TTGSnackbar.init(message: "Please enter valid Email ID", duration: .long).show()
            }
        }
        else if(ufirstNameTf.text! == ""){
            TTGSnackbar.init(message: "Please enter First Name", duration: .long).show()
        }
        else if(ulastNameTf.text! == ""){
            TTGSnackbar.init(message: "Please enter Last Name", duration: .long).show()
        }
        else if(udobTf.text! == ""){
            TTGSnackbar.init(message: "Please select date of birth", duration: .long).show()
        }
        else if(umobNoTf.text! == ""){
            TTGSnackbar.init(message: "Please enter Mobile No", duration: .long).show()
        }
        else if(uemailTf.text! == ""){
            TTGSnackbar.init(message: "Please enter Email ID", duration: .long).show()
        }
        else if(upincodeTf.text! == ""){
            TTGSnackbar.init(message: "Please enter Pincode", duration: .long).show()
        }
        else if(ucityTf.text! == ""){
            TTGSnackbar.init(message: "Please enter City", duration: .long).show()
        }
        else if(ustateTf.text! == ""){
            TTGSnackbar.init(message: "Please enter State", duration: .long).show()
        }
        
    }
    
    //---<EmailValidation>---
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    //---<APICALL>---
    func getCityStateAPI()
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
        let params: [String: AnyObject] = ["PinCode": upincodeTf.text! as AnyObject]
        
        let url = "get-city-and-state"
        
        FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
            alertView.close()
            
            self.view.layoutIfNeeded()
            
            let jsonData = userObject as? NSDictionary
            let state_name = jsonData?.value(forKey: "state_name") as? String
            let cityname = jsonData?.value(forKey: "cityname") as? String
            self.ustateTf.text! = state_name!
            self.ucityTf.text! = cityname!
            
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
    
    func addChildPospAPI()
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
        
        let params: [String: AnyObject] = ["Address_1": "" as AnyObject,
                                            "Address_2": "" as AnyObject,
                                            "Address_3": "" as AnyObject,
                                            "Bonds": "0" as AnyObject,
                                            "Bonds_Comp": "" as AnyObject,
                                            "BrokID": 0 as AnyObject,
                                            "City": ucityTf.text! as AnyObject,
                                            "CustID": 0 as AnyObject,
                                            "DOB": udobTf.text! as AnyObject,
                                            "DisplayDesignation": "" as AnyObject,
                                            "DisplayEmail": "" as AnyObject,
                                            "DisplayPhoneNo": "" as AnyObject,
                                            "EmailId": uemailTf.text! as AnyObject,
                                            "FBAID": 0 as AnyObject,
                                            "FBALiveID": 0 as AnyObject,
                                            "FBAPan": "" as AnyObject,
                                            "FBAStat": "" as AnyObject,
                                            "FBA_Designation": "" as AnyObject,
                                            "FirstName": ufirstNameTf.text! as AnyObject,
                                            "GIC_Comp": "16" as AnyObject,
                                            "GIC_Comp_ID": "" as AnyObject,
                                            "GSTNumb": "" as AnyObject,
                                            "Gender": Gender as AnyObject,
                                            "Health_Comp": "16" as AnyObject,
                                            "Health_Comp_ID": "" as AnyObject,
                                            "IsFOC": "" as AnyObject,
                                            "IsGic": "1" as AnyObject,
                                            "IsHealth": "1" as AnyObject,
                                            "IsLic": "1" as AnyObject,
                                            "LIC_Comp": "20" as AnyObject,
                                            "LIC_Comp_ID": "" as AnyObject,
                                            "LastName": ulastNameTf.text! as AnyObject,
                                            "Link": "null" as AnyObject,
                                            "Loan_Aadhaar": "" as AnyObject,
                                            "Loan_Account_Type": "" as AnyObject,
                                            "Loan_BankAcNo": "" as AnyObject,
                                            "Loan_BankBranch": "" as AnyObject,
                                            "Loan_BankCity": "" as AnyObject,
                                            "Loan_BankID": 0 as AnyObject,
                                            "Loan_BankName": "" as AnyObject,
                                            "Loan_FirstName": "" as AnyObject,
                                            "Loan_IFSC": "" as AnyObject,
                                            "Loan_LastName": "" as AnyObject,
                                            "Loan_MICR": "" as AnyObject,
                                            "Loan_PAN": "" as AnyObject,
                                            "MF": "0" as AnyObject,
                                            "MF_Comp": "" as AnyObject,
                                            "Mobile_1": umobNoTf.text! as AnyObject,
                                            "Mobile_2": umobNo2Tf.text! as AnyObject,
                                            "Other_Aadhaar": "" as AnyObject,
                                            "Other_Account_Type": "" as AnyObject,
                                            "Other_BankAcNo": "" as AnyObject,
                                            "Other_BankBranch": "" as AnyObject,
                                            "Other_BankCity": "" as AnyObject,
                                            "Other_BankID": 0 as AnyObject,
                                            "Other_BankName": "" as AnyObject,
                                            "Other_FirstName": "" as AnyObject,
                                            "Other_IFSC": "" as AnyObject,
                                            "Other_LastName": "" as AnyObject,
                                            "Other_MICR": "" as AnyObject,
                                            "Other_PAN": "" as AnyObject,
                                            "POSPID": 0 as AnyObject,
                                            "PinCode": upincodeTf.text! as AnyObject,
                                            "Posp_Aadhaar": "" as AnyObject,
                                            "Posp_Account_Type": "" as AnyObject,
                                            "Posp_Address1": "" as AnyObject,
                                            "Posp_Address2": "" as AnyObject,
                                            "Posp_Address3": "" as AnyObject,
                                            "Posp_BankAcNo": "" as AnyObject,
                                            "Posp_BankBranch": "" as AnyObject,
                                            "Posp_BankCity": "" as AnyObject,
                                            "Posp_BankID": 0 as AnyObject,
                                            "Posp_BankName": "" as AnyObject,
                                            "Posp_ChanPartCode": "" as AnyObject,
                                            "Posp_City": "" as AnyObject,
                                            "Posp_DOB": "" as AnyObject,
                                            "Posp_Email": ""as AnyObject,
                                            "Posp_FirstName": "" as AnyObject,
                                            "Posp_Gender": "" as AnyObject,
                                            "Posp_IFSC": "" as AnyObject,
                                            "Posp_LastName": "" as AnyObject,
                                            "Posp_MICR": "" as AnyObject,
                                            "Posp_Mobile1": "" as AnyObject,
                                            "Posp_Mobile2": "" as AnyObject,
                                            "Posp_PAN": "" as AnyObject,
                                            "Posp_PinCode": "" as AnyObject,
                                            "Posp_ServiceTaxNo": "" as AnyObject,
                                            "Posp_StatID": "" as AnyObject,
                                            "Postal": "0" as AnyObject,
                                            "Postal_Comp": "" as AnyObject,
                                            "SMID": 0 as AnyObject,
                                            "SM_Name": "" as AnyObject,
                                            "StatActi": "" as AnyObject,
                                            "State": ustateTf.text! as AnyObject,
                                            "StateID": "2" as AnyObject,
                                            "Stock": "0" as AnyObject,
                                            "Stock_Comp": "" as AnyObject,
                                            "Type": "" as AnyObject,
                                            "password": "01011980" as AnyObject,
                                            "referedby_code": "" as AnyObject,
                                            "VersionCode": Configuration.appVersion as AnyObject,
                                            "AppSource": "2" as AnyObject,
                                            "ParentId": FBAId as AnyObject]
        
        let url = "AddChildPosp"
        
        FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
            alertView.close()
            
            self.view.layoutIfNeeded()
            
            let jsonData = userObject as? NSDictionary
            let Message = jsonData?.value(forKey: "Message") as? String
            if(Message == "FBA registered successfully."){
                TTGSnackbar.init(message: "FBA registered successfully.", duration: .long).show()
                let addSubUser : addSubUserVC = self.storyboard?.instantiateViewController(withIdentifier: "stbaddSubUserVC") as! addSubUserVC
                addSubUser.modalPresentationStyle = .fullScreen
                self.present(addSubUser, animated:true, completion: nil)
            }
            else{
                TTGSnackbar.init(message: "Error", duration: .long).show()
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
    
    
    //----<buttonColor>----
    func btnColorChangeBlue(Btn:UIButton)
    {
        let borderColr = UIColor.init(red: 0/225.0, green: 125/225.0, blue: 213/225.0, alpha: 1)
        Btn.layer.cornerRadius=2.0;
        Btn.layer.borderWidth=1.0;
        Btn.layer.borderColor=borderColr.cgColor;
        Btn.setTitleColor(UIColor.init(red: 0/225.0, green: 125/225.0, blue: 213/225.0, alpha: 1), for: UIControl.State.normal)
    }
    
    func btnColorChangeGray(Btn:UIButton)
    {
        let borderColr = UIColor.gray
        Btn.layer.cornerRadius=2.0;
        Btn.layer.borderWidth=1.0;
        Btn.layer.borderColor=borderColr.cgColor;
        Btn.setTitleColor(UIColor.gray, for: .normal)
    }
    
    func viewColorGray(view:UIView)
    {
        let borderColr = UIColor.lightGray
        view.layer.cornerRadius=2.0;
        view.layer.borderWidth=0.5;
        view.layer.borderColor=borderColr.cgColor;
        //        Btn.setTitleColor(UIColor.gray, for: .normal)
    }
    
    
}
