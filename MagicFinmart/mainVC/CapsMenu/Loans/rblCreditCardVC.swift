//
//  rblCreditCardVC.swift
//  MagicFinmart
//
//  Created by iOS Developer on 22/08/19.
//  Copyright © 2019 Ashwini. All rights reserved.
//

import UIKit
import CustomIOSAlertView
import TTGSnackbar

class rblCreditCardVC: UIViewController,getPickerDataDelegate,SelectedDateDelegate,UITextFieldDelegate {
   
    @IBOutlet weak var rblView: UIView!
    @IBOutlet weak var prifixLbl: UILabel!
    @IBOutlet weak var frstNameTf: ACFloatingTextfield!
    @IBOutlet weak var lstNameTf: ACFloatingTextfield!
    @IBOutlet weak var fathrNameTf: ACFloatingTextfield!
    @IBOutlet weak var dobtf: ACFloatingTextfield!
    @IBOutlet weak var creditCardAppledTf: ACFloatingTextfield!
    @IBOutlet weak var processingFeeTf: ACFloatingTextfield!
    @IBOutlet weak var resiAd1Tf: ACFloatingTextfield!
    @IBOutlet weak var resiAd2Tf: ACFloatingTextfield!
    @IBOutlet weak var landmrkTf: ACFloatingTextfield!
    @IBOutlet weak var pincdeTf: ACFloatingTextfield!
    @IBOutlet weak var monthlyincmTf: ACFloatingTextfield!
    @IBOutlet weak var mobnoTf: ACFloatingTextfield!
    @IBOutlet weak var pancardnoTf: ACFloatingTextfield!
    @IBOutlet weak var emailTf: ACFloatingTextfield!
    @IBOutlet weak var emplyTypeLbl: UILabel!
    @IBOutlet weak var maleImgView: UIImageView!
    @IBOutlet weak var femaleimgView: UIImageView!
    @IBOutlet weak var creditcrdYesImgView: UIImageView!
    @IBOutlet weak var creditcrdNoImgView: UIImageView!
    @IBOutlet weak var cityTf: ACFloatingTextfield!

    var prefixLblArray = ["Mr","Ms","Mrs","Dr","Other"]
    var prefixLblIdArray = ["1","2","3","4","5"]
    var gender = "1"
    var lnoracrdtCard = "Y"
    var cardtypeStr = ""
    var processingfeeStr = ""
    var creditCardAppliedIdStr = ""
    var creditCardDetailIdStr = Int()
    var salaryType = ""
    var cityNameArray = [String]()
    var cityCodeArray = [String]()
    var cityCode = ""
    var prfixId = "1"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboardWhenTappedAround()
        let borderColr = UIColor.lightGray
        rblView.layer.cornerRadius=2.0;
        rblView.layer.borderWidth=1.0;
        rblView.layer.borderColor=borderColr.cgColor;
        rblView.layer.shadowColor=borderColr.cgColor;
        rblView.layer.shadowRadius=2.0;
        
        creditCardAppledTf.text! = cardtypeStr
        processingFeeTf.text! = processingfeeStr
        if(salaryType == "1"){
            emplyTypeLbl.text! = "Salaried"
            salaryType = "1"
            
        }else{
            emplyTypeLbl.text! = "Self-Employeed"
            salaryType = "2"
        }
        
        pancardnoTf.autocapitalizationType = UITextAutocapitalizationType.allCharacters
//        pancardnoTf.delegate = self
        pancardnoTf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)

        getrblcityAPI()
        
    }
    
    @IBAction func bckBtnCliked(_ sender: Any)
    {
        let stbcreditCard : creditCardVC = self.storyboard?.instantiateViewController(withIdentifier: "stbcreditCardVC") as! creditCardVC
        present(stbcreditCard, animated: true, completion: nil)
    }
    
    //---<textFieldRange>---
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
        if(textField == pancardnoTf)
        {
            if((textField.text?.count)! <= 9)
            {
                let allowedCharacters = CharacterSet.alphanumerics
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
        else if(textField == pincdeTf)
        {
            if((textField.text?.count)! < 6)
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
    
    //--------<keyboard change for PAN text>--------
    @objc func handleTextChange(_ textChange: UITextField) {
        if pancardnoTf.text?.count == 5 || pancardnoTf.text?.count == 6 || pancardnoTf.text?.count == 7 || pancardnoTf.text?.count == 8
        {
            pancardnoTf.keyboardType = .numberPad
            pancardnoTf.reloadInputViews() // need to reload the input view for this work
        } else {
            pancardnoTf.keyboardType = .default
            pancardnoTf.reloadInputViews()
        }
    }
    //--------<end keyboard text change for PAN>--------
    
    
    //----------<ScrollView move up with Keyboard>---------
    func textFieldDidBeginEditing(_ textField: UITextField) {
        moveTextField(textfield: textField, moveDistance: -150, up: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        moveTextField(textfield: textField, moveDistance: -150, up: false)
    }
    
    func moveTextField(textfield: UITextField, moveDistance: Int, up: Bool) {
        let moveDuration = 0.3
        let movement: CGFloat = CGFloat(up ? moveDistance: -moveDistance)
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    //----------<ScrollView move up with Keyboard>---------
    
    @IBAction func prefixBtnCliked(_ sender: Any)
    {
        self.view.endEditing(true)
        let Picker : PickerViewVC! = storyboard?.instantiateViewController(withIdentifier: "stbPickerViewVC") as? PickerViewVC
        Picker.fromScreen = "rblprefixLbl"
        Picker.pickerData = prefixLblArray
        Picker.pickerIdData = prefixLblIdArray
        self.addChild(Picker)
        self.view.addSubview(Picker.view)
        Picker.pickerdelegate = self
    }
    
    @IBAction func citytfBtnCliked(_ sender: Any)
    {
        self.view.endEditing(true)
        let Picker : PickerViewVC! = storyboard?.instantiateViewController(withIdentifier: "stbPickerViewVC") as? PickerViewVC
        Picker.fromScreen = "rblcityName"
        Picker.pickerData = ["Select"]+cityNameArray
        Picker.pickerIdData = [""]+cityCodeArray
        self.addChild(Picker)
        self.view.addSubview(Picker.view)
        Picker.pickerdelegate = self
    }
    
    func getPickerDataValue(pickerSelectedData: String, fromScreen: String, pickerSelectedId: String)
    {
        switch fromScreen
        {
            case "rblprefixLbl":
            self.prifixLbl.text = pickerSelectedData
            self.prfixId = pickerSelectedId
            break
        case "rblcityName":
            self.cityTf.text = pickerSelectedData
            self.cityCode = pickerSelectedId
            break
            default:
            break
        }
    }
    
    @IBAction func dobBtnCliked(_ sender: Any)
    {
        self.view.endEditing(true)
        let DatePicker : DatePickerVC = storyboard?.instantiateViewController(withIdentifier: "stbDatePickerVC") as! DatePickerVC
        DatePicker.fromScreen = "crdtcardrbl"
        self.addChild(DatePicker)
        self.view.addSubview(DatePicker.view)
        DatePicker.dateDelegate = self
    }
    
    func getDateData(currDate: String, fromScreen: String) {
        print(currDate)
        dobtf.text = currDate
        dobtf.textColor = UIColor.black
    }
    
    func getintData(indata: Int) {
        
    }
    
    @IBAction func maleBtnCliked(_ sender: Any)
    {
        maleImgView.image = UIImage(named: "icons8-unchecked-radio-button-24 (1).png")
        femaleimgView.image = UIImage(named: "icons8-round-24.png")
        gender = "1"
    }
    
    @IBAction func femaleBtnCliked(_ sender: Any)
    {
        femaleimgView.image = UIImage(named: "icons8-unchecked-radio-button-24 (1).png")
        maleImgView.image = UIImage(named: "icons8-round-24.png")
        gender = "2"
    }
    
    @IBAction func lnorcreditcrdfrmanyYesBtnCliked(_ sender: Any)
    {
        creditcrdYesImgView.image = UIImage(named: "icons8-unchecked-radio-button-24 (1).png")
        creditcrdNoImgView.image = UIImage(named: "icons8-round-24.png")
        lnoracrdtCard = "Y"
    }
    
    @IBAction func lnorcreditcrdfrmanyNoBtnCliked(_ sender: Any)
    {
        creditcrdNoImgView.image = UIImage(named: "icons8-unchecked-radio-button-24 (1).png")
        creditcrdYesImgView.image = UIImage(named: "icons8-round-24.png")
        lnoracrdtCard = "N"
    }
    
    @IBAction func submitBtnCliked(_ sender: Any)
    {
        if(dobtf.text! != "" && emailTf.text! != "" && fathrNameTf.text! != "" && frstNameTf.text! != "" && landmrkTf.text! != "" && lstNameTf.text! != "" && mobnoTf.text! != "" && monthlyincmTf.text! != "" && pancardnoTf.text! != "" && resiAd1Tf.text! != "" && resiAd2Tf.text! != "" && pincdeTf.text! != "")
        {
            creditcardrblAPI()
        }
        else if(frstNameTf.text! == ""){
            TTGSnackbar.init(message: "Enter first name", duration: .long).show()
        }
        else if(fathrNameTf.text! == ""){
            TTGSnackbar.init(message: "Enter father name", duration: .long).show()
        }
        else if(lstNameTf.text! == ""){
            TTGSnackbar.init(message: "Enter last name", duration: .long).show()
        }
        else if(dobtf.text! == ""){
            TTGSnackbar.init(message: "Enter date of birth", duration: .long).show()
        }
        else if(landmrkTf.text! == ""){
            TTGSnackbar.init(message: "Enter landmark", duration: .long).show()
        }
        else if(mobnoTf.text! == ""){
            TTGSnackbar.init(message: "Enter mobile no", duration: .long).show()
        }
        else if(monthlyincmTf.text! == ""){
            TTGSnackbar.init(message: "Enter fmonthly income", duration: .long).show()
        }
        else if(pancardnoTf.text! == ""){
            TTGSnackbar.init(message: "Enter pan no", duration: .long).show()
        }
        else if(resiAd1Tf.text! == ""){
            TTGSnackbar.init(message: "Enter residence 1", duration: .long).show()
        }
        else if(resiAd2Tf.text! == ""){
            TTGSnackbar.init(message: "Enter residence 2", duration: .long).show()
        }
        else if(pincdeTf.text! == ""){
            TTGSnackbar.init(message: "Enter pincode", duration: .long).show()
        }
        else if(emailTf.text! == ""){
            TTGSnackbar.init(message: "Enter email", duration: .long).show()
        }
    }
    
    //----<APICALL>----
    func getrblcityAPI()
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
        
        let url = "/api/get-rbl-city"
        
        FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
            alertView.close()
            
            self.view.layoutIfNeeded()
            
            let jsonData = userObject as? NSArray
            self.cityNameArray = jsonData?.value(forKey: "CityName") as! [String]
            self.cityCodeArray = jsonData?.value(forKey: "CityCode") as! [String]
            
            
            
        }, onError: { errorData in
            alertView.close()
            let snackbar = TTGSnackbar.init(message: errorData.errorMessage, duration: .long)
            snackbar.show()
        }, onForceUpgrade: {errorData in})
        
    }
    
    func creditcardrblAPI()
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
        
        let params: [String: AnyObject] = ["CardType": creditCardAppledTf.text! as AnyObject,
                                           "ConUniqRefCode": "" as AnyObject,
                                           "CreditCardApplied": creditCardAppliedIdStr as AnyObject,
                                           "CreditCardDetailId": creditCardDetailIdStr as AnyObject,
                                           "DOB": dobtf.text! as AnyObject,
                                           "Email": emailTf.text! as AnyObject,
                                           "EmpType": salaryType as AnyObject,
                                           "FatherName": fathrNameTf.text! as AnyObject,
                                           "FirstName": frstNameTf.text! as AnyObject,
                                           "Gender": gender as AnyObject,
                                           "HadLoanOrCreditCardFromAnyBank": lnoracrdtCard as AnyObject,
                                           "Landmark": landmrkTf.text! as AnyObject,
                                           "LastName": lstNameTf.text! as AnyObject,
                                           "MiddleName": "" as AnyObject,
                                           "Mobile": mobnoTf.text! as AnyObject,
                                           "NMI": monthlyincmTf.text! as AnyObject,
                                           "PAN": pancardnoTf.text! as AnyObject,
                                           "ProcessingFee": processingFeeTf.text! as AnyObject,
                                           "ResAddress1": resiAd1Tf.text! as AnyObject,
                                           "ResAddress2": resiAd2Tf.text! as AnyObject,
                                           "ResCity": cityCode as AnyObject,
                                           "ResPIN": pincdeTf.text! as AnyObject,
                                           "Title": prfixId as AnyObject,
                                           "Version": "6" as AnyObject,
                                           "brokerid": "38054" as AnyObject,
                                           "empid": "null" as AnyObject,
                                           "fba_id": FBAId as AnyObject,
                                           "source": "finmart" as AnyObject]
        
        let url = "/api/credit-card-rbl"
        
        FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
            alertView.close()
            
            self.view.layoutIfNeeded()
            
            let jsonData = userObject as? NSDictionary
//            Message
            let Message = UserDefaults.standard.string(forKey: "messge")
            
            let ReferenceCode = jsonData?.value(forKey: "ReferenceCode") as! String
            let Status = jsonData?.value(forKey: "Status") as! String
            
            let appliedSuccessfuly : appliedSuccessfulyVC = self.storyboard?.instantiateViewController(withIdentifier: "stbappliedSuccessfulyVC") as! appliedSuccessfulyVC
            appliedSuccessfuly.applictntext = ReferenceCode
            appliedSuccessfuly.decisntext = Status
            appliedSuccessfuly.mesgtext = Message!
            self.addChild(appliedSuccessfuly)
            self.view.addSubview(appliedSuccessfuly.view)
            
            
        }, onError: { errorData in
            alertView.close()
            let snackbar = TTGSnackbar.init(message: errorData.errorMessage, duration: .long)
            snackbar.show()
        }, onForceUpgrade: {errorData in})
        
    }

}
