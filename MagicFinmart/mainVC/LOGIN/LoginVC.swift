//
//  LoginVC.swift
//  MagicFinmart
//
//  Created by Ashwini on 11/12/18.
//  Copyright © 2018 Ashwini. All rights reserved.
//

import UIKit
import CustomIOSAlertView
import TTGSnackbar
import CobrowseIO

class LoginVC: UIViewController,UITextFieldDelegate {

    
    
    @IBOutlet weak var emailTf: ACFloatingTextfield!
    @IBOutlet weak var passwordTf: ACFloatingTextfield!
    @IBOutlet weak var eyeBtn: UIButton!
    let aTextField = ACFloatingTextfield()
    var iconClick = true
    var emailId = ""
    var userId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        //--<textField>--
        aTextField.delegate = self
    }
    
    func getRandomColor() -> UIColor{
        return UIColor.init(red: 0/255.0, green: 125/255.0, blue: 213/255.0, alpha: 1)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func eyeBtnCliked(_ sender: Any)
    {
        if(iconClick == true) {
            passwordTf.isSecureTextEntry = false
            let img = UIImage(named: "baseline_visibility_white_18pt_3x.png")
            eyeBtn.setImage(img , for: .normal)

        } else {
            passwordTf.isSecureTextEntry = true
            let img = UIImage(named: "baseline_visibility_off_white_18pt_3x.png")
            eyeBtn.setImage(img , for: .normal)
        }
        
        iconClick = !iconClick
    }
    
    @IBAction func loginSubmitBtnCliked(_ sender: Any)
    {
        if(emailTf.text != "" && passwordTf.text! != "")
        {
//            if(isValidEmail(testStr: emailTf.text!))
//            {
//                loginAPI()
//            }
//            else{
//                let alert = UIAlertController(title: "Alert", message: "Invalid Email ID or Password", preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
//                self.present(alert, animated: true, completion: nil)
//            }
//        }else{
//            let alert = UIAlertController(title: "Alert", message: "Please enter Email ID or Password", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
        }
        
        if((emailTf.text?.contains("@"))!){
            self.view.endEditing(true)
            emailId = emailTf.text!
            loginAPI()
        }else{
            self.view.endEditing(true)
            userId = emailTf.text!
            loginAPI()
        }
    }
    
    //---<EmailValidation>---
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    
    @IBAction func signupBtnCliked(_ sender: Any)
    {
        let ViewC : ViewController = self.storyboard?.instantiateViewController(withIdentifier: "stbViewController") as! ViewController
        self.addChild(ViewC)
        self.view.addSubview(ViewC.view)
        
    }
    @IBAction func forgetpassBtnCliked(_ sender: Any)
    {
        let forgtPass : forgtPassVC = self.storyboard?.instantiateViewController(withIdentifier: "stbforgtPassVC") as! forgtPassVC
        self.addChild(forgtPass)
        self.view.addSubview(forgtPass.view)
        
        
        
    }
    
    
    //---<APICALL>---
    func loginAPI()
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
        
        let deviceID = UIDevice.current.identifierForVendor?.uuidString
        print("deviceID=",deviceID!)
        
        let params: [String: AnyObject] = ["AppID": "" as AnyObject,
                                             "AppPASSWORD": "" as AnyObject,
                                             "AppUSERID": "" as AnyObject,
                                             "DeviceId": deviceID as AnyObject,
                                             "DeviceName": ""as AnyObject,
                                             "DeviceOS": "" as AnyObject,
                                             "EmailId": emailId as AnyObject,
                                             "FBAId": 0 as AnyObject,
                                             "IpAdd": "" as AnyObject,
                                             "LastLog": "" as AnyObject,
                                             "MobileNo": "" as AnyObject,
                                             "OldPassword": "" as AnyObject,
                                             "Password": passwordTf.text! as AnyObject,
                                             "TokenId": "" as AnyObject,
                                             "UserId": userId as AnyObject,
                                             "UserName": emailTf.text! as AnyObject,
                                             "UserType": "" as AnyObject,
                                             "VersionNo": "" as AnyObject]
        
        let url = "/api/login"
        
        FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
            alertView.close()
            
            self.view.layoutIfNeeded()
            
            let jsonData = userObject as? NSDictionary
            print("jsonData=",jsonData!)
            let FBAId = jsonData?.value(forKey: "FBAId") as AnyObject
            let referer_code = jsonData?.value(forKey: "referer_code") as AnyObject
            let POSPNo = jsonData?.value(forKey: "POSPNo") as AnyObject
            let CustID = jsonData?.value(forKey: "CustID") as AnyObject
            let EmailID = jsonData?.value(forKey: "EmailID") as AnyObject
            let MobiNumb1 = jsonData?.value(forKey: "MobiNumb1") as AnyObject
            let FullName = jsonData?.value(forKey: "FullName") as AnyObject
            let LoanId   = jsonData?.value(forKey: "LoanId") as AnyObject
            
            UserDefaults.standard.set(String(describing: FBAId), forKey: "FBAId")
            UserDefaults.standard.set(String(describing: referer_code), forKey: "referer_code")
            UserDefaults.standard.set(String(describing: POSPNo), forKey: "POSPNo")
            UserDefaults.standard.set(String(describing: CustID), forKey: "CustID")
            
            UserDefaults.standard.set(String(describing: POSPNo), forKey: "MobiNumb1")
            UserDefaults.standard.set(String(describing: CustID), forKey: "EmailID")
            UserDefaults.standard.set(String(describing: LoanId), forKey: "LoanId")
        
           
//            let IsFirstLogin = jsonData?.value(forKey: "IsFirstLogin") as AnyObject
            UserDefaults.standard.set(String(describing: "1"), forKey: "IsFirstLogin")
            
           //--DemoUsingCoBrowserIO--
            
                /*****************  Commented **************************
                CobrowseIO.instance().license = "-6ym5GFRbN0OdQ"
                // print("Cobrowse device id:  \(CobrowseIO.instance().deviceId)")
                CobrowseIO.instance().customData = [
                    kCBIOUserIdKey: FBAId as! NSObject, //FBAID
                    kCBIOUserNameKey: FullName as! NSObject, //USerName
                    kCBIOUserEmailKey: EmailID as! NSObject, //Emailid
                    kCBIODeviceIdKey: CobrowseIO.instance().deviceId as NSObject, //
                    kCBIODeviceNameKey: "iOS" as NSObject
                ]
            
                ******************************************************/
             //--DemoUsingCoBrowserIO--
            
                let KYDrawer : KYDrawerController = self.storyboard?.instantiateViewController(withIdentifier: "stbKYDrawerController") as! KYDrawerController
                self.present(KYDrawer, animated: true, completion: nil)
                TTGSnackbar.init(message: "Login successfully.", duration: .long).show()
           
            
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
    
    




//-------< For Hide Keyboard >--------
// Put this piece of code anywhere you like
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
