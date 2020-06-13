//
//  enrolasPOSPVC.swift
//  MagicFinmart
//
//  Created by Ashwini on 27/12/18.
//  Copyright © 2018 Ashwini. All rights reserved.
//

import UIKit
import CustomIOSAlertView
import TTGSnackbar

class enrolasPOSPVC: UIViewController,SelectedDateDelegate,UITextFieldDelegate {
    
    @IBOutlet weak var posparrowImg: UIImageView!
    @IBOutlet weak var addressarrowImg: UIImageView!
    @IBOutlet weak var bankdetailsarrowImg: UIImageView!
    @IBOutlet weak var docuploadarrowImg: UIImageView!
    @IBOutlet weak var docuploadView: UIView!
    @IBOutlet weak var docuploadViewHeight: NSLayoutConstraint!//335
    @IBOutlet weak var bankdetailsView: UIView!
    @IBOutlet weak var bankdetailsViewHeight: NSLayoutConstraint!//310
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var addressViewHeight: NSLayoutConstraint!//310
    @IBOutlet weak var pospinfoView: UIView!
    @IBOutlet weak var pospinfoViewHeight: NSLayoutConstraint!//520
    @IBOutlet weak var enmaleBtn: UIButton!
    @IBOutlet weak var enfemaleBtn: UIButton!
    @IBOutlet weak var encsavingBtn: UIButton!
    @IBOutlet weak var encurrentBtn: UIButton!
    //textfield
    @IBOutlet weak var enfirstNameTf: ACFloatingTextfield!
    @IBOutlet weak var enlastNameTf: ACFloatingTextfield!
    @IBOutlet weak var endobTf: ACFloatingTextfield!
    @IBOutlet weak var enmob1Tf: ACFloatingTextfield!
    @IBOutlet weak var enmob2Tf: ACFloatingTextfield!
    @IBOutlet weak var enemailTf: ACFloatingTextfield!
    @IBOutlet weak var enpanTf: ACFloatingTextfield!
    @IBOutlet weak var enadhrTf: ACFloatingTextfield!
    @IBOutlet weak var engstTf: ACFloatingTextfield!
    @IBOutlet weak var enchnlpartnrTf: ACFloatingTextfield!
    @IBOutlet weak var enaddress1Tf: ACFloatingTextfield!
    @IBOutlet weak var enaddress2Tf: ACFloatingTextfield!
    @IBOutlet weak var enaddress3Tf: ACFloatingTextfield!
    @IBOutlet weak var enpincodeTf: ACFloatingTextfield!
    @IBOutlet weak var encityTf: ACFloatingTextfield!
    @IBOutlet weak var enstateTf: ACFloatingTextfield!
    @IBOutlet weak var enbankaccnoTf: ACFloatingTextfield!
    @IBOutlet weak var enifscCodeTf: ACFloatingTextfield!
    @IBOutlet weak var enmicrCodeTf: ACFloatingTextfield!
    @IBOutlet weak var enbankNameTf: ACFloatingTextfield!
    @IBOutlet weak var enbankBranchTf: ACFloatingTextfield!
    @IBOutlet weak var enbankCityTf: ACFloatingTextfield!
    
    var gender = "M"
    var accType = "SAVING"
    var stateid = String()
    var stateName = String()
    var strPosp_DOB  = ""
    var LINK = ""
    var CUSTOMER_ID  = ""
    var POSPNo = ""
    var PaymStat = ""
    var result = Bool()
    var isPospInfo  = false
     var isAddress = false
     var isBankDetails = false
     var isMale  = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
       
       
        
        enpanTf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        enifscCodeTf.autocapitalizationType = .allCharacters
        
        //--<border>--
        btnColorChangeBlue(Btn:enmaleBtn)
        btnColorChangeGray(Btn: enfemaleBtn)
        btnColorChangeBlue(Btn:encsavingBtn)
        btnColorChangeGray(Btn: encurrentBtn)
        
        //--<borderView>--
        let borderColor = UIColor(red: 0/255, green: 51/255, blue: 91/255, alpha: 1.0)
        pospinfoView.layer.borderWidth=1.0;
        pospinfoView.layer.borderColor=borderColor.cgColor;
        addressView.layer.borderWidth=1.0;
        addressView.layer.borderColor=borderColor.cgColor;
        bankdetailsView.layer.borderWidth=1.0;
        bankdetailsView.layer.borderColor=borderColor.cgColor;
        docuploadView.layer.borderWidth=1.0;
        docuploadView.layer.borderColor=borderColor.cgColor;
        
        //--<viewHidden>--
        pospinfoView.isHidden = false
        pospinfoViewHeight.constant = 520
        addressView.isHidden = true
        addressViewHeight.constant = 0
        bankdetailsView.isHidden = true
        bankdetailsViewHeight.constant = 0
        docuploadView.isHidden = true
        docuploadViewHeight.constant = 0
        
        //--<apiCall>--
        getpospdetailAPI()

    }
    
    @IBAction func backBtnCliked(_ sender: Any)
    {
        let KYDrawer : KYDrawerController = self.storyboard?.instantiateViewController(withIdentifier: "stbKYDrawerController") as! KYDrawerController
        present(KYDrawer, animated: true, completion: nil)
    }
    
    //---<textFieldRange>---
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        
        
        if(textField == enbankaccnoTf  )
        {
           
                let allowedCharacters = CharacterSet.decimalDigits
                let characterSet = NSCharacterSet(charactersIn: string)
                return allowedCharacters.isSuperset(of: characterSet as CharacterSet)
            
            
        }
        if(textField == enmob1Tf  ||  textField == enmob2Tf)
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
        else if(textField == enpincodeTf)
        {
            if((textField.text?.count)! <= 5)
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
        else if(textField == enifscCodeTf)
        {
            if((textField.text?.count)! <= 10)
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
        else if(textField == enpanTf)
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
        else{
            if((textField.text?.count)! <= 60)
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
        if (textField == self.encityTf || textField == self.enstateTf)
        {
            getCityStateAPI()
        }
        if(textField == self.enmicrCodeTf || textField == self.enbankBranchTf || textField == self.enbankCityTf || textField == self.enbankNameTf)
        {
            getifsccodeAPI()
        }
        
    }
    
    
    /******************************************************************/
    // Validation pospInfo
    
    func pospInfoValidate()  -> Bool {
        
        if( enfirstNameTf.text!.isEmpty){
            alertCall(message: "Enter First Name")
            return false
        }
        if( enlastNameTf.text!.trimmingCharacters(in: .whitespaces).isEmpty){
            alertCall(message: "Enter Last Name")
            return false
        }
         if( endobTf.text!.isEmpty){
            alertCall(message: "Enter Dob")
            return false
        }
         if( enmob1Tf.text!.trimmingCharacters(in: .whitespaces).isEmpty){
            alertCall(message: "Enter Mobile1")
            return false
        }
        if(!isValidEmail(testStr: enemailTf.text!))
        {
             alertCall(message: "Invalid Email Id")
             return false
        }
        
        
        if(!validatePanCardNumber(candidate: enpanTf.text!))
        {
            return false
        }
        
      

        
        
//        if(validatePanCardNumber(candidate: enpanTf.text!) && enpanTf.text!.count == 10) == false
//        {
//             return false
//        }
//        else{
//            alertCall(message: "Enter 10 digit PAN")
//        }
        return true
    }
    
     func pospAddressValidate()  -> Bool {
        
        if( enaddress1Tf.text!.trimmingCharacters(in: .whitespaces).isEmpty){
            alertCall(message: "Enter Address 1")
            return false
        }
        if( enaddress2Tf.text!.isEmpty){
            alertCall(message: "Enter Address 2")
            return false
        }
        if( enpincodeTf.text!.trimmingCharacters(in: .whitespaces).isEmpty){
            alertCall(message: "Enter Pincode")
            return false
        }
        if( enpincodeTf.text?.count != 6){
            alertCall(message: "Enter Pincode")
            return false
        }
        if( encityTf.text!.trimmingCharacters(in: .whitespaces).isEmpty){
            alertCall(message: "Enter City")
            return false
        }
        if( enstateTf.text!.trimmingCharacters(in: .whitespaces).isEmpty){
            alertCall(message: "Enter State")
            return false
        }
         return true
        
    }
    func pospBankValidate()  -> Bool {
        
        if( enbankaccnoTf.text!.trimmingCharacters(in: .whitespaces).isEmpty){
            alertCall(message: "Enter Bank Account No.")
            return false
        }
        if( enifscCodeTf.text!.trimmingCharacters(in: .whitespaces).isEmpty){
            alertCall(message: "Enter Bank IFSC")
            return false
        }
        if( enstateTf.text!.trimmingCharacters(in: .whitespaces).isEmpty){
            alertCall(message: "Enter State")
            return false
        }
        if( enmicrCodeTf.text!.trimmingCharacters(in: .whitespaces).isEmpty){
            alertCall(message: "Enter Bank MICR")
            return false
        }
        
        if(enbankNameTf.text!.trimmingCharacters(in: .whitespaces).isEmpty){
            alertCall(message: "Enter Bank Name")
            return false
        }
        if( enbankBranchTf.text!.trimmingCharacters(in: .whitespaces).isEmpty){
            alertCall(message: "Enter Bank Branch")
            return false
        }
        if( enbankCityTf.text!.trimmingCharacters(in: .whitespaces).isEmpty){
            alertCall(message: "Enter Bank City")
            return false
        }
        return true
        
    }
   /******************************************************************/
    
    
    /******************************************************************/
    
    func openValidatePosp(strData : String){
        
        
        if(strData == "INFO")
        {
            pospinfoView.isHidden = false
            pospinfoViewHeight.constant = 520
            posparrowImg.image = UIImage(named: "up_arrow.png")
         
            addressarrowImg.image = UIImage(named: "down_arrow.png")
            bankdetailsarrowImg.image = UIImage(named: "down_arrow.png")
            docuploadarrowImg.image = UIImage(named: "down_arrow.png")
            addressView.isHidden = true
            addressViewHeight.constant = 0
            bankdetailsView.isHidden = true
            bankdetailsViewHeight.constant = 0
            docuploadView.isHidden = true
            docuploadViewHeight.constant = 0
        }
        else if(strData == "ADDR"){
    
            addressView.isHidden = false
            addressViewHeight.constant = 310
            addressarrowImg.image = UIImage(named: "up_arrow.png")
            
            posparrowImg.image = UIImage(named: "down_arrow.png")
            bankdetailsarrowImg.image = UIImage(named: "down_arrow.png")
            docuploadarrowImg.image = UIImage(named: "down_arrow.png")
            pospinfoView.isHidden = true
            pospinfoViewHeight.constant = 0
            bankdetailsView.isHidden = true
            bankdetailsViewHeight.constant = 0
            docuploadView.isHidden = true
            docuploadViewHeight.constant = 0
        } else if(strData == "BANK"){
            
            
            bankdetailsView.isHidden = false
            bankdetailsViewHeight.constant = 310
            bankdetailsarrowImg.image = UIImage(named: "up_arrow.png")
            
            posparrowImg.image = UIImage(named: "down_arrow.png")
            addressarrowImg.image = UIImage(named: "down_arrow.png")
            docuploadarrowImg.image = UIImage(named: "down_arrow.png")
            pospinfoView.isHidden = true
            pospinfoViewHeight.constant = 0
            addressView.isHidden = true
            addressViewHeight.constant = 0
            docuploadView.isHidden = true
            docuploadViewHeight.constant = 0
        }else if(strData == "DOC"){
            
            
            docuploadView.isHidden = false
            docuploadViewHeight.constant = 335
            docuploadarrowImg.image = UIImage(named: "up_arrow.png")
            
            addressarrowImg.image = UIImage(named: "down_arrow.png")
            bankdetailsarrowImg.image = UIImage(named: "down_arrow.png")
            posparrowImg.image = UIImage(named: "down_arrow.png")
            pospinfoView.isHidden = true
            pospinfoViewHeight.constant = 0
            addressView.isHidden = true
            addressViewHeight.constant = 0
            bankdetailsView.isHidden = true
            bankdetailsViewHeight.constant = 0
        }
      
    }
    // Layout Click Method
    func pospInfoClik(){
        
        if(pospinfoView.isHidden)
        {
            pospinfoView.isHidden = false
            pospinfoViewHeight.constant = 520
            posparrowImg.image = UIImage(named: "up_arrow.png")
        }else{
            pospinfoView.isHidden = true
            pospinfoViewHeight.constant = 0
            posparrowImg.image = UIImage(named: "down_arrow.png")
        }
        addressarrowImg.image = UIImage(named: "down_arrow.png")
        bankdetailsarrowImg.image = UIImage(named: "down_arrow.png")
        docuploadarrowImg.image = UIImage(named: "down_arrow.png")
        addressView.isHidden = true
        addressViewHeight.constant = 0
        bankdetailsView.isHidden = true
        bankdetailsViewHeight.constant = 0
        docuploadView.isHidden = true
        docuploadViewHeight.constant = 0
    }
    
    
    func addressCliked(){
        
        //getCityStateAPI()
        
       
        
        if(addressView.isHidden)
        {
            addressView.isHidden = false
            addressViewHeight.constant = 310
            addressarrowImg.image = UIImage(named: "up_arrow.png")
        }else{
            addressView.isHidden = true
            addressViewHeight.constant = 0
            addressarrowImg.image = UIImage(named: "down_arrow.png")
        }
        posparrowImg.image = UIImage(named: "down_arrow.png")
        bankdetailsarrowImg.image = UIImage(named: "down_arrow.png")
        docuploadarrowImg.image = UIImage(named: "down_arrow.png")
        pospinfoView.isHidden = true
        pospinfoViewHeight.constant = 0
        bankdetailsView.isHidden = true
        bankdetailsViewHeight.constant = 0
        docuploadView.isHidden = true
        docuploadViewHeight.constant = 0
    }
    
    func bankdetailsCliked (){
        
        if(bankdetailsView.isHidden)
        {
            bankdetailsView.isHidden = false
            bankdetailsViewHeight.constant = 310
            bankdetailsarrowImg.image = UIImage(named: "up_arrow.png")
        }else{
            bankdetailsView.isHidden = true
            bankdetailsViewHeight.constant = 0
            bankdetailsarrowImg.image = UIImage(named: "down_arrow.png")
        }
        posparrowImg.image = UIImage(named: "down_arrow.png")
        addressarrowImg.image = UIImage(named: "down_arrow.png")
        docuploadarrowImg.image = UIImage(named: "down_arrow.png")
        pospinfoView.isHidden = true
        pospinfoViewHeight.constant = 0
        addressView.isHidden = true
        addressViewHeight.constant = 0
        docuploadView.isHidden = true
        docuploadViewHeight.constant = 0
    }
    
    func docuuploadCliked(){
        
        if(docuploadView.isHidden)
        {
            docuploadView.isHidden = false
            docuploadViewHeight.constant = 335
            docuploadarrowImg.image = UIImage(named: "up_arrow.png")
        }else{
            docuploadView.isHidden = true
            docuploadViewHeight.constant = 0
            docuploadarrowImg.image = UIImage(named: "down_arrow.png")
        }
        addressarrowImg.image = UIImage(named: "down_arrow.png")
        bankdetailsarrowImg.image = UIImage(named: "down_arrow.png")
        posparrowImg.image = UIImage(named: "down_arrow.png")
        pospinfoView.isHidden = true
        pospinfoViewHeight.constant = 0
        addressView.isHidden = true
        addressViewHeight.constant = 0
        bankdetailsView.isHidden = true
        bankdetailsViewHeight.constant = 0
    }
    /******************************************************************/
    
    // Action Button
    
    @IBAction func pospinfoCliked(_ sender: Any)
    {
       
         pospInfoClik()
        
    }
    
    @IBAction func addressCliked(_ sender: Any)
    {
        if( pospInfoValidate() == false){
           
            openValidatePosp(strData: "INFO")
            return
            
        }
        
    
        addressCliked()
        
    }
    
    @IBAction func bankdetailsCliked(_ sender: Any)
    {
       
        if( pospInfoValidate() == false){
           
            openValidatePosp(strData: "INFO")
        }
            
        else  if(pospAddressValidate() == false){
            
            openValidatePosp(strData: "ADDR")
        }
            
        else{
            bankdetailsCliked()
        }
        

    }
    
    @IBAction func docuuploadCliked(_ sender: Any)
    {
        
        if( pospInfoValidate() == false){
            
            openValidatePosp(strData: "INFO")
        }
            
        else  if(pospAddressValidate() == false){
            
            openValidatePosp(strData: "ADDR")
        }
            
        else   if(pospBankValidate() == false){
            
            openValidatePosp(strData: "BANK")
        }
        else{
            docuuploadCliked()
        }
        
    
     
    }
    
    
    @IBAction func dobBtnCliked(_ sender: Any)
    {
        self.view.endEditing(true)
        let DatePicker : DatePickerVC = storyboard?.instantiateViewController(withIdentifier: "stbDatePickerVC") as! DatePickerVC
        DatePicker.fromScreen = "fromEnrolPOSP"
        self.addChild(DatePicker)
        self.view.addSubview(DatePicker.view)
        DatePicker.dateDelegate = self
    }
    
    func getDateData(currDate: String, fromScreen: String) {
        print(currDate)
        endobTf.text = currDate
        endobTf.textColor = UIColor.black
        
        let requiredFormat = currDate.toDateString(inputDateFormat: "dd-MM-yyyy", ouputDateFormat:
            "yyyy-MM-dd")
       
        self.strPosp_DOB = requiredFormat
         print("MyDate",requiredFormat)
    }
    
    func getintData(indata: Int) {
        
    }
    
    @IBAction func maleBtnCliked(_ sender: Any)
    {
        gender = "M"
        btnColorChangeBlue(Btn:enmaleBtn)
        btnColorChangeGray(Btn: enfemaleBtn)
    }
    
    @IBAction func femaleBtnCliked(_ sender: Any)
    {
        gender = "F"
        btnColorChangeBlue(Btn:enfemaleBtn)
        btnColorChangeGray(Btn: enmaleBtn)
    }
    
    @IBAction func ensavingBtnCliked(_ sender: Any)
    {
        accType = "SAVING"
        btnColorChangeBlue(Btn:encsavingBtn)
        btnColorChangeGray(Btn: encurrentBtn)
    }
    
    @IBAction func encurrentBtnCliked(_ sender: Any)
    {
        accType = "CURRENT"
        btnColorChangeBlue(Btn:encurrentBtn)
        btnColorChangeGray(Btn: encsavingBtn)
    }
    
    
    @IBAction func submitBtnCliked(_ sender: Any)
    {
        if(isValidEmail(testStr: enemailTf.text!))
        {
            if(validatePanCardNumber(candidate: enpanTf.text!) && enpanTf.text!.count == 10)
            {
                if(enmob1Tf.text!.count == 10 )
                {
                    pospregistrationAPI()
                }
                else{
                    TTGSnackbar.init(message: "Enter 10 digit Mobile Number", duration: .long).show()
                }
            }
            else{
                alertCall(message: "Enter 10 digit PAN")
            }
        }else{
            alertCall(message: "Invalid Email Id")
        }
    }
    
    //---<keyboard change for PAN text>---
    @objc func handleTextChange(_ textChange: UITextField) {
        if enpanTf.text?.count == 5 || enpanTf.text?.count == 6 || enpanTf.text?.count == 7 || enpanTf.text?.count == 8
        {
            enpanTf.keyboardType = .numberPad
            enpanTf.reloadInputViews() // need to reload the input view for this work
        } else {
            enpanTf.keyboardType = .default
            enpanTf.reloadInputViews()
        }
    }
    //---<end keyboard text change for PAN>---
    
    //---<EmailValidation>---
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    //----<Validation for PAN>----
    func validatePanCardNumber(candidate: String) -> Bool {
        print("validate PanCard: \(candidate)")
       // let emailRegEx = "[A-Z]{3}P[A-Z]{1}[0-9]{4}[A-Z]{1}"
         let emailRegEx = "[A-Z]{5}[0-9]{4}[A-Z]{1}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        result = emailTest.evaluate(with: candidate)
        print("result=",result)
        if(result == false){
            let alert = UIAlertController(title: "Alert", message: "Please enter valid PAN", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        return result
        
    }
    
    
    //---<APICALL>---
    func pospregistrationAPI()
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
            
            let CustID = UserDefaults.standard.string(forKey: "CustID")
            
            if(CustID is NSNull){
                
                CUSTOMER_ID = ""
                
            }else{
                
                CUSTOMER_ID = CustID as! String
            }
        
        let params: [String: AnyObject] = [
                                            "AppSource": "" as AnyObject,
                                            "Bonds": "" as AnyObject,
                                            "Bonds_Comp": "" as AnyObject,
                                            "BrokID": 0 as AnyObject,
                                          
                                            "CustID": CustID as AnyObject,       // logic 05
                                            "DOB": endobTf.text! as AnyObject,
                                            "DisplayDesignation": "" as AnyObject,
                                            "DisplayEmail": "" as AnyObject,
                                            "DisplayPhoneNo": "" as AnyObject,
                                            "EmailId": enemailTf.text! as AnyObject,
                                            "FBAID": FBAId as AnyObject,
                                            "FBALiveID": 0 as AnyObject,
                                            "FBAPan": enpanTf.text! as AnyObject,
                                            "FBAStat": "" as AnyObject,
                                            "FBA_Designation": " " as AnyObject,
                                            "FirstName": enfirstNameTf.text! as AnyObject,
                                            "GIC_Comp": "" as AnyObject,
                                            "GIC_Comp_ID": "" as AnyObject,
                                            "GSTNumb": "" as AnyObject,
                                            "Gender": gender as AnyObject,
                                            "Health_Comp": "" as AnyObject,
                                            "Health_Comp_ID": "" as AnyObject,
                                            "IsFOC": "" as AnyObject,
                                            "IsGic": "" as AnyObject,
                                            "IsHealth": "" as AnyObject,
                                            "IsLic": "" as AnyObject,
                                            "LIC_Comp": "" as AnyObject,
                                            "LIC_Comp_ID": "" as AnyObject,
                                            "LastName": enlastNameTf.text! as AnyObject,
                                            "Link": self.LINK as AnyObject,           // logic 05
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
                                            "MF": "" as AnyObject,
                                            "MF_Comp": "" as AnyObject,
                                            "Mobile_1": enmob1Tf.text! as AnyObject,
                                            "Mobile_2": enmob2Tf.text! as AnyObject,
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
                                            "POSPID": self.POSPNo as AnyObject,         // logic 05
                                            "ParentId": "0" as AnyObject,
                                         
                                          
                                            "Postal": "" as AnyObject,
                                            "Postal_Comp": "" as AnyObject,
                                            "SMID": 0 as AnyObject,
                                            "SM_Name": "" as AnyObject,
                                            "StatActi": "" as AnyObject,
                                            "State":   enstateTf as AnyObject,
                                            "StateID": self.stateid as AnyObject,
                                            "Stock": "" as AnyObject,
                                            "Stock_Comp": "" as AnyObject,
                                            "Type": "" as AnyObject,
                                            "VersionCode": Configuration.appVersion as AnyObject,
                                            "password": "" as AnyObject,
                                           
    
                                            
                                           /********************************************************/
                                           // Info Dtl
                                            "Posp_FirstName": enfirstNameTf.text! as AnyObject,
                                            "Posp_LastName": enlastNameTf.text! as AnyObject,
                                            "Posp_Mobile1": enmob1Tf.text! as AnyObject,
                                            "Posp_Mobile2": enmob2Tf.text! as AnyObject,
                                            "Posp_DOB":   self.strPosp_DOB as AnyObject,
                                            "Posp_Gender": gender as AnyObject,
                                            "Posp_Email": enemailTf.text! as AnyObject,
                                            "Posp_PAN": enpanTf.text! as AnyObject,
                                            "Posp_Aadhaar": enadhrTf.text! as AnyObject,
                
                                            "Posp_ServiceTaxNo": engstTf.text! as AnyObject,
                                            "Posp_ChanPartCode": enchnlpartnrTf.text! as AnyObject,
                                            
                                            //end OF Info
            
                                            /********************************************************/
                                            // Address Dtl
                                            "Posp_Address1": enaddress1Tf.text! as AnyObject,
                                            "Posp_Address2": enaddress2Tf.text! as AnyObject,
                                            "Posp_Address3": enaddress3Tf.text! as AnyObject,
                                            "Posp_PinCode": enpincodeTf.text! as AnyObject,
                                            "Posp_City": encityTf.text! as AnyObject,
                                            "Posp_StatID": enstateTf.text! as AnyObject,
                                            // non posp Address Dtl
                                            "Address_1": enaddress1Tf.text! as AnyObject,
                                            "Address_2": enaddress2Tf.text! as AnyObject,
                                            "Address_3": enaddress3Tf.text! as AnyObject,
                                            "PinCode":   enpincodeTf.text! as AnyObject,
                                            "City":      encityTf.text! as AnyObject,
                                            
                                            //end OF Adress
            
                                            /********************************************************/
                                            // Bank  Dtl
            
                                            "Posp_BankAcNo": enbankaccnoTf.text! as AnyObject,
                                            "Posp_IFSC": enifscCodeTf.text! as AnyObject,
                                            "Posp_MICR": enmicrCodeTf.text! as AnyObject,
                                            "Posp_Account_Type": accType as AnyObject,
                                            "Posp_BankBranch": enbankBranchTf.text! as AnyObject,
                                            "Posp_BankCity": enbankCityTf.text! as AnyObject,
                                            "Posp_BankID": 0 as AnyObject,
                                            "Posp_BankName": enbankNameTf.text! as AnyObject,
                                            
                                            "referedby_code": "" as AnyObject]
        
        let url = "/api/posp-registration"
        
        FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
            alertView.close()
            
            self.view.layoutIfNeeded()
            
            let jsonData = userObject as? NSDictionary
            TTGSnackbar.init(message: "Posp registered successfully.", duration: .long).show()
            
            
//            let razorController : RazorPayementController = self.storyboard?.instantiateViewController(withIdentifier: "stbRazorPayementController") as! RazorPayementController
//
//            self.present(razorController, animated:true, completion: nil)
//
            
//            let razorController : PaymentController = self.storyboard?.instantiateViewController(withIdentifier: "stbPaymentController") as! PaymentController
//
//            self.present(razorController, animated:true, completion: nil)
            
            
          
            
            
            let storyboard = UIStoryboard(name: "payment", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "stbPaymentMainController") as UIViewController

            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            //show window
            appDelegate.window?.rootViewController = vc
            
            
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
    
  
    
    func getpospdetailAPI()
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
        
        let url = "/api/get-posp-detail"
        
        FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
            alertView.close()
            
            self.view.layoutIfNeeded()
            
            let jsonData = userObject as? NSArray
            let Posp_First_Name = (jsonData![0] as AnyObject).value(forKey: "Posp_First_Name") as AnyObject
            let Posp_Last_Name = (jsonData![0] as AnyObject).value(forKey: "Posp_Last_Name") as AnyObject
            self.enfirstNameTf.text! = Posp_First_Name as! String
            self.enlastNameTf.text! = Posp_Last_Name as! String
            let Posp_Account_Type = (jsonData![0] as AnyObject).value(forKey: "Posp_Account_Type") as AnyObject
            if(Posp_Account_Type as! String == "SAVING"){
                self.btnColorChangeBlue(Btn:self.encsavingBtn)
                self.btnColorChangeGray(Btn:self.encurrentBtn)
            }
            else{
                self.btnColorChangeBlue(Btn:self.encurrentBtn)
                self.btnColorChangeGray(Btn:self.encsavingBtn)
            }
            let Posp_Address1 = (jsonData![0] as AnyObject).value(forKey: "Posp_Address1") as AnyObject
            self.enaddress1Tf.text! = Posp_Address1 as! String
            let Posp_Address2 = (jsonData![0] as AnyObject).value(forKey: "Posp_Address2") as AnyObject
            self.enaddress2Tf.text! = Posp_Address2 as! String
            let Posp_Address3 = (jsonData![0] as AnyObject).value(forKey: "Posp_Address3") as AnyObject
            self.enaddress3Tf.text! = Posp_Address3 as! String
            let Posp_BankAcNo = (jsonData![0] as AnyObject).value(forKey: "Posp_BankAcNo") as AnyObject
            self.enbankaccnoTf.text! = Posp_BankAcNo as! String
            let Posp_BankBranch = (jsonData![0] as AnyObject).value(forKey: "Posp_BankBranch") as AnyObject
            self.enbankBranchTf.text! = Posp_BankBranch as! String
            let Posp_BankName = (jsonData![0] as AnyObject).value(forKey: "Posp_BankName") as AnyObject
            self.enbankNameTf.text! = Posp_BankName as! String
            let Posp_City = (jsonData![0] as AnyObject).value(forKey: "Posp_City") as AnyObject
            self.encityTf.text! = Posp_City as! String
            let Posp_DOB = (jsonData![0] as AnyObject).value(forKey: "Posp_DOB") as AnyObject
            self.endobTf.text! = Posp_DOB as! String
            let Posp_Email = (jsonData![0] as AnyObject).value(forKey: "Posp_Email") as AnyObject
            self.enemailTf.text! = Posp_Email as! String
            let Posp_IFSC = (jsonData![0] as AnyObject).value(forKey: "Posp_IFSC") as AnyObject
            self.enifscCodeTf.text! = Posp_IFSC as! String
            let Posp_Gender = (jsonData![0] as AnyObject).value(forKey: "Posp_Gender") as AnyObject
            if(Posp_Gender as! String == "M"){
                self.btnColorChangeBlue(Btn:self.enmaleBtn)
                self.btnColorChangeGray(Btn:self.enfemaleBtn)
            }
            else{
                self.btnColorChangeBlue(Btn:self.enfemaleBtn)
                self.btnColorChangeGray(Btn:self.enmaleBtn)
            }
            let Posp_MICR = (jsonData![0] as AnyObject).value(forKey: "Posp_MICR") as AnyObject
            self.enmicrCodeTf.text! = Posp_MICR as! String
            let Posp_Mobile1 = (jsonData![0] as AnyObject).value(forKey: "Posp_Mobile1") as AnyObject
            self.enmob1Tf.text! = Posp_Mobile1 as! String
            let Posp_Mobile2 = (jsonData![0] as AnyObject).value(forKey: "Posp_Mobile2") as AnyObject
            self.enmob2Tf.text! = Posp_Mobile2 as! String
            let Posp_PAN = (jsonData![0] as AnyObject).value(forKey: "Posp_PAN") as AnyObject
            self.enpanTf.text! = Posp_PAN as! String
            let Posp_PinCode = (jsonData![0] as AnyObject).value(forKey: "Posp_PinCode") as AnyObject
            self.enpincodeTf.text! = Posp_PinCode as! String
//            let POSPStat = (jsonData![0] as AnyObject).value(forKey: "POSPStat") as AnyObject
//            self.enstateTf.text! = POSPStat as! String
            let Posp_Aadhaar = (jsonData![0] as AnyObject).value(forKey: "Posp_Aadhaar") as AnyObject
            self.enadhrTf.text! = Posp_Aadhaar as! String
            let POSPBankCity = (jsonData![0] as AnyObject).value(forKey: "POSPBankCity") as AnyObject
            if(POSPBankCity is NSNull)
            {
                self.enbankCityTf.text? = ""
            }
            else{
                self.enbankCityTf.text? = POSPBankCity as! String
            }
             let POSPLink = (jsonData![0] as AnyObject).value(forKey: "Link") as AnyObject
            
            if(POSPLink is NSNull)
            {
                self.LINK = ""
            }
            else{
                self.LINK = POSPLink as! String
            }
            
            let POSPNomber = (jsonData![0] as AnyObject).value(forKey: "POSPNo") as AnyObject
            
            if(POSPNomber is NSNull)
            {
                self.POSPNo = ""
            }
            else{
                self.POSPNo = POSPNomber as! String
            }
          
            let PaymStatus = (jsonData![0] as AnyObject).value(forKey: "PaymStat") as AnyObject
            
            if(PaymStatus is NSNull)
            {
                self.PaymStat = ""
            }
            else{
                self.PaymStat = PaymStatus as! String
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
        let params: [String: AnyObject] = ["PinCode": enpincodeTf.text as AnyObject]
        
        let url = "/api/get-city-and-state"
        
        FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
            alertView.close()
            
            self.view.layoutIfNeeded()
            
            let jsonData = userObject as? NSDictionary
            let state_name = jsonData?.value(forKey: "state_name") as? String
            self.stateid = (jsonData?.value(forKey: "stateid") as? String ?? "")
            self.stateName = state_name ?? ""
            let cityname = jsonData?.value(forKey: "cityname") as? String
            self.enstateTf.text! = state_name!
            self.encityTf.text! = cityname!

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
    
    func getifsccodeAPI()
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
        let params: [String: AnyObject] = ["IFSCCode": enifscCodeTf.text! as AnyObject]
        
        let url = "/api/get-ifsc-code"
        
        FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
            alertView.close()
            
            self.view.layoutIfNeeded()
            
            let jsonData = userObject as? NSArray
         
             
                let MICRCode = (jsonData![0] as AnyObject).value(forKey: "MICRCode") as AnyObject
                let BankBran = (jsonData![0] as AnyObject).value(forKey: "BankBran") as AnyObject
                let CityName = (jsonData![0] as AnyObject).value(forKey: "CityName") as AnyObject
                let BankName = (jsonData![0] as AnyObject).value(forKey: "BankName") as AnyObject
                self.enmicrCodeTf.text! = MICRCode as! String
                self.enbankBranchTf.text! = BankBran as! String
                self.enbankCityTf.text! = CityName as! String
                self.enbankNameTf.text! = BankName as! String
                
            
           
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
        Btn.layer.borderWidth=2.0;
        Btn.layer.borderColor=borderColr.cgColor;
        Btn.setTitleColor(UIColor.init(red: 0/225.0, green: 125/225.0, blue: 213/225.0, alpha: 1), for: UIControl.State.normal)
    }
    
    func btnColorChangeGray(Btn:UIButton)
    {
        let borderColr = UIColor.gray
        Btn.layer.cornerRadius=2.0;
        Btn.layer.borderWidth=2.0;
        Btn.layer.borderColor=borderColr.cgColor;
        Btn.setTitleColor(UIColor.gray, for: .normal)
    }
    
    //--<showalertView>--
    func alertCall(message:String)
    {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
   
    
}

extension String
{
    func toDateString( inputDateFormat inputFormat  : String,  ouputDateFormat outputFormat  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputFormat
        let date = dateFormatter.date(from: self)
        dateFormatter.dateFormat = outputFormat
        return dateFormatter.string(from: date!)
    }
}
