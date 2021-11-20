//
//  lyfinshdfcInputPageVC.swift
//  MagicFinmart
//
//  Created by Admin on 27/03/19.
//  Copyright © 2019 Ashwini. All rights reserved.
//

import UIKit
import CustomIOSAlertView
import TTGSnackbar

class lyfinshdfcInputPageVC: UIViewController,SelectedDateDelegate,getPickerDataDelegate,UITextFieldDelegate {
    
    @IBOutlet weak var hdfcADBView: UIView!
    @IBOutlet weak var hdfcADBViewHeight: NSLayoutConstraint!//50
    @IBOutlet weak var hdfcADBViewTop: NSLayoutConstraint!
    @IBOutlet weak var hdfcmothlyIncomeVIew: UIView!
    @IBOutlet weak var hdfcmonthIcomeViewHeight: NSLayoutConstraint!
    @IBOutlet weak var hdfcIncomePeriodView: UIView!
    @IBOutlet weak var hdfcIncomePeriViewHeight: NSLayoutConstraint!
    @IBOutlet weak var hdfcincreView: UIView!
    @IBOutlet weak var hdfcIncreViewHeight: NSLayoutConstraint!
    @IBOutlet weak var hdfcincreViewTop: NSLayoutConstraint!
    @IBOutlet weak var maleBtn: UIButton!
    @IBOutlet weak var femaleBtn: UIButton!
    @IBOutlet weak var sYesBtn: UIButton!
    @IBOutlet weak var sNoBtn: UIButton!
    @IBOutlet weak var hdfcOptionLbl: UILabel!
    @IBOutlet weak var premFrqLbl: UILabel!
    
    @IBOutlet weak var firstNameTf: ACFloatingTextfield!
    @IBOutlet weak var lastNameTf: ACFloatingTextfield!
    @IBOutlet weak var mobNoTf: ACFloatingTextfield!
    @IBOutlet weak var dobTf: ACFloatingTextfield!
    @IBOutlet weak var hdfcPincodeTf: ACFloatingTextfield!
    @IBOutlet weak var hdfcsumAssuredTf: ACFloatingTextfield!
    @IBOutlet weak var hdfcpolicyTermTf: ACFloatingTextfield!
    @IBOutlet weak var hdfcpreTermAssuredTf: ACFloatingTextfield!
    @IBOutlet weak var hdfcsaIncreTf: ACFloatingTextfield!
    @IBOutlet weak var hdfcADBLbl: ACFloatingTextfield!
    @IBOutlet weak var hdfcmonthincomLbl: ACFloatingTextfield!
    @IBOutlet weak var hdfcincomperiLbl: ACFloatingTextfield!
    @IBOutlet weak var hdfcincresLbl: ACFloatingTextfield!
    
    var policyTermArray = ["SELECT","5 YEARS","6 YEARS","7 YEARS","8 YEARS","9 YEARS","10 YEARS","11 YEARS","12 YEARS","13 YEARS","14 YEARS","15 YEARS","16 YEARS","17 YEARS","18 YEARS","19 YEARS","20 YEARS","21 YEARS","23 YEARS","24 YEARS","25 YEARS","26 YEARS","27 YEARS","28 YEARS","29 YEARS","30 YEARS","31 YEARS","32 YEARS","33 YEARS","34 YEARS","35 YEARS","36 YEARS","37 YEARS","38 YEARS","39 YEARS","40 YEARS","Max Policy Term"]
    var premiumTermArray = ["SELECT","YEARLY","HALF YEARLY","QUARTERLY","MONTHLY","SINGLE"]
    var hdfcOptionArray = ["SELECT","LIFE","3D LIFE","LIFE LONG PROTECTION","3D LIFE LONG PROTECTION","EXTRA LIFE","EXTRA LIFE INCOME","INCOME OPTION","INCOME REPLACEMENT","RETURN OF PREMIUM"]
    var icicipayTermArray = ["SELECT","REGULAR PAY","SINGLE PAY","LIMITED PAY","WHOLE LIFE"]
    var iciciPreFrqArray = ["SELECT","YEARLY","HALF YEARLY","MONTHLY"]
    var iciciOptionArray = ["SELECT","LIFE","LIFE PLUS","LIFE AND HEALTH","ALL IN ONE"]
    var iciciprePayArray = ["SELECT","PAY TILL AGE 60","10 PAY","7 PAY","5 PAY"]
    var iciciprePayArray2 = ["SELECT","PAY TILL AGE 99","PAY TILL AGE 60","10 PAY"]
    var fromScreen = ""
    var gender = "M"
    var smoker = "false"
    var pincodeText = ""
    var premiumFrqText = ""
    var optionText = ""
    var sumassuredText = ""
    var policyTermText = ""
    var preTermText = ""
    var criticalIllnessText = ""
    var deathBenefit = ""
    var payTermText = ""
    var InsurerID = ""
    
    var cntctMob = ""
    var contctNm = ""
    var insdob = ""
    var gendr = ""
    var smkr = ""
    var pincde = ""
    var sumassurd = ""
    var plcytrm = ""
    var pretrm = ""
    
    //--<hdfcIncrementDecreValues>--
    var hdfcsumAssuredTfValue: Int = 0 {
        didSet {
            hdfcsumAssuredTf.text! = "\(hdfcsumAssuredTfValue)"
        }
    }
    var hdfcpolicyTermTfValue: Int = 0 {
        didSet {
            hdfcpolicyTermTf.text! = "\(hdfcpolicyTermTfValue)"
        }
    }
    var hdfcpreTermTfValue: Int = 0 {
        didSet {
            hdfcpreTermAssuredTf.text! = "\(hdfcpreTermTfValue)"
        }
    }
    var hdfcsaIncreTfValue: Int = 0 {
        didSet {
            hdfcsaIncreTf.text! = "\(hdfcsaIncreTfValue)"
        }
    }
    var hdfcADBTfValue: Int = 0 {
        didSet {
            hdfcADBLbl.text! = "\(hdfcADBTfValue)"
        }
    }
    var hdfcmonthincomTfValue: Int = 0 {
        didSet {
            hdfcmonthincomLbl.text! = "\(hdfcmonthincomTfValue)"
        }
    }
    var hdfcincomperiTfValue: Int = 0 {
        didSet {
            hdfcincomperiLbl.text! = "\(hdfcincomperiTfValue)"
        }
    }
    var hdfcincresTfValue: Int = 0 {
        didSet {
            hdfcincresLbl.text! = "\(hdfcincresTfValue)"
        }
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        //btn
//        btnColorChangeBlue(Btn: maleBtn)
//        btnColorChangeGray(Btn: femaleBtn)
//        btnColorChangeBlue(Btn: sNoBtn)
//        btnColorChangeGray(Btn: sYesBtn)
        
        //--<HideViews>--
        hdfcmothlyIncomeVIew.isHidden = true
        hdfcmonthIcomeViewHeight.constant = 0
        hdfcIncomePeriodView.isHidden = true
        hdfcIncomePeriViewHeight.constant = 0
        hdfcincreView.isHidden = true
        hdfcIncreViewHeight.constant = 0
        hdfcADBView.isHidden = true
        hdfcADBViewHeight.constant = 0

        //--<hdfcIncrementDecreValues>--
        hdfcsumAssuredTfValue = 10000000 // didSet is called when the variable is changed, not upon initialization.
        hdfcpolicyTermTfValue = 20
        hdfcpreTermTfValue = 20
        hdfcsaIncreTfValue = 10
        hdfcADBTfValue = 100
        hdfcmonthincomTfValue = 25000
        hdfcincomperiTfValue = 20
        hdfcincresTfValue = 5
        
        hdfcsumAssuredTf.text! = "10000000"
        
        mobNoTf.text! = cntctMob
        let frstName = contctNm.components(separatedBy: " ").dropLast().joined(separator: " ")
        firstNameTf.text! = frstName.uppercased()
        let lstName = contctNm.components(separatedBy: " ").dropFirst().joined(separator: " ")
        lastNameTf.text! = lstName.uppercased()
        dobTf.text! = insdob
        let igendr = gendr
        if(igendr == "M"){
            btnColorChangeBlue(Btn: maleBtn)
            btnColorChangeGray(Btn: femaleBtn)
        }
        else {
            btnColorChangeGray(Btn: maleBtn)
            btnColorChangeBlue(Btn: femaleBtn)
        }
        let ismkr = smkr
        if(ismkr == "false"){
            btnColorChangeBlue(Btn: sNoBtn)
            btnColorChangeGray(Btn: sYesBtn)
        }
        else{
            btnColorChangeGray(Btn: sNoBtn)
            btnColorChangeBlue(Btn: sYesBtn)
        }
        hdfcPincodeTf.text! = pincde
        hdfcsumAssuredTf.text! = sumassurd
        hdfcpolicyTermTf.text! = plcytrm
        
    
    }
    
    //---<textFieldRange>---
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if(textField == mobNoTf)
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
        else if(textField == hdfcPincodeTf)
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
    
    
    @IBAction func dobBtnCliked(_ sender: Any)
    {
        self.view.endEditing(true)
        let DatePicker : DatePickerVC = storyboard?.instantiateViewController(withIdentifier: "stbDatePickerVC") as! DatePickerVC
        DatePicker.fromScreen = "fromlyfInsInput"
        self.addChild(DatePicker)
        self.view.addSubview(DatePicker.view)
        DatePicker.dateDelegate = self
    }
    
    func getDateData(currDate: String, fromScreen: String)
    {
        dobTf.text = currDate
        dobTf.textColor = UIColor.black
        
        let dateYear = currDate.components(separatedBy: "-").dropFirst().joined(separator: "-")
        let yearOnly = dateYear.components(separatedBy: "-").dropFirst().joined(separator: "-")
        
        var year = Int()
        year = Int(yearOnly)!
        let Age = 2019 - year
        UserDefaults.standard.set(String(describing: Age), forKey: "Age")
        if(hdfcOptionLbl.text! == "LIFE LONG PROTECTION" || hdfcOptionLbl.text! == "3D LIFE LONG PROTECTION")
        {
            let policyTermValue = 100 - Age
            hdfcpolicyTermTf.text! = String(policyTermValue)
            let premiumTermValue = 65 - Age
            hdfcpreTermAssuredTf.text! = String(premiumTermValue)
        }

    }
    
    func getintData(indata: Int)
    {
        
    }
    
    @IBAction func maleBtnCliked(_ sender: Any)
    {
        btnColorChangeBlue(Btn: maleBtn)
        btnColorChangeGray(Btn: femaleBtn)
        gender = "M"
    }
    
    @IBAction func femaleBtnCliked(_ sender: Any)
    {
        btnColorChangeBlue(Btn: femaleBtn)
        btnColorChangeGray(Btn: maleBtn)
        gender = "F"
    }
    
    @IBAction func sYesBtnCliked(_ sender: Any)
    {
        btnColorChangeBlue(Btn: sYesBtn)
        btnColorChangeGray(Btn: sNoBtn)
        smoker = "true"
    }
    
    @IBAction func sNoBtnCliked(_ sender: Any)
    {
        btnColorChangeBlue(Btn: sNoBtn)
        btnColorChangeGray(Btn: sYesBtn)
        smoker = "false"
    }
    
    @IBAction func preFrqSelctBtnCliked(_ sender: Any)
    {
        self.view.endEditing(true)
        let Picker : PickerViewVC! = storyboard?.instantiateViewController(withIdentifier: "stbPickerViewVC") as? PickerViewVC
        Picker.fromScreen = "hdfcPremiumTerm"
        Picker.pickerData = premiumTermArray
        //        Picker.pickerIdData = sourceIdArray
        self.addChild(Picker)
        self.view.addSubview(Picker.view)
        Picker.pickerdelegate = self
    }
    
    @IBAction func optionslectBtnCliked(_ sender: Any)
    {
        self.view.endEditing(true)
        let Picker : PickerViewVC! = storyboard?.instantiateViewController(withIdentifier: "stbPickerViewVC") as? PickerViewVC
        Picker.fromScreen = "hdfcOption"
        Picker.pickerData = hdfcOptionArray
        //        Picker.pickerIdData = sourceIdArray
        self.addChild(Picker)
        self.view.addSubview(Picker.view)
        Picker.pickerdelegate = self
    }
    
 
    func getPickerDataValue(pickerSelectedData: String, fromScreen: String, pickerSelectedId: String) {
        switch fromScreen
        {
        
        case "hdfcPremiumTerm":
            self.premFrqLbl.text = pickerSelectedData
            //            self.sourceId = pickerSelectedId
            if(self.premFrqLbl.text == "SINGLE"){
                hdfcpreTermAssuredTf.text! = "1"
                hdfcsaIncreTf.text! = "0"
            }
            break
        case "hdfcOption":
            self.hdfcOptionLbl.text = pickerSelectedData
            //            self.sourceId = pickerSelectedId
            if(hdfcOptionLbl.text == "EXTRA LIFE")
            {
                hdfcmothlyIncomeVIew.isHidden = true
                hdfcmonthIcomeViewHeight.constant = 0
                hdfcIncomePeriodView.isHidden = true
                hdfcIncomePeriViewHeight.constant = 0
                hdfcincreView.isHidden = true
                hdfcIncreViewHeight.constant = 0
                hdfcADBView.isHidden = false
                hdfcADBViewHeight.constant = 50
                hdfcADBViewTop.constant = -20
            }
            else if(hdfcOptionLbl.text == "EXTRA LIFE INCOME")
            {
                hdfcmothlyIncomeVIew.isHidden = false
                hdfcmonthIcomeViewHeight.constant = 50
                hdfcIncomePeriodView.isHidden = false
                hdfcIncomePeriViewHeight.constant = 50
                hdfcincreView.isHidden = false
                hdfcIncreViewHeight.constant = 50
                hdfcADBView.isHidden = false
                hdfcADBViewHeight.constant = 50
                hdfcADBViewTop.constant = 10
            }
            else if(hdfcOptionLbl.text == "INCOME OPTION")
            {
                hdfcmothlyIncomeVIew.isHidden = false
                hdfcmonthIcomeViewHeight.constant = 50
                hdfcIncomePeriodView.isHidden = false
                hdfcIncomePeriViewHeight.constant = 50
                hdfcincreView.isHidden = false
                hdfcIncreViewHeight.constant = 50
                hdfcincreViewTop.constant = 10
                hdfcADBView.isHidden = true
                hdfcADBViewHeight.constant = 0
            }
            else if(hdfcOptionLbl.text == "INCOME REPLACEMENT")
            {
                hdfcmothlyIncomeVIew.isHidden = false
                hdfcmonthIcomeViewHeight.constant = 50
                hdfcIncomePeriodView.isHidden = true
                hdfcIncomePeriViewHeight.constant = 0
                hdfcincreView.isHidden = false
                hdfcIncreViewHeight.constant = 50
                hdfcincreViewTop.constant = 0
                hdfcADBView.isHidden = true
                hdfcADBViewHeight.constant = 0
            }
            else{
                hdfcmothlyIncomeVIew.isHidden = true
                hdfcmonthIcomeViewHeight.constant = 0
                hdfcIncomePeriodView.isHidden = true
                hdfcIncomePeriViewHeight.constant = 0
                hdfcincreView.isHidden = true
                hdfcIncreViewHeight.constant = 0
                hdfcADBView.isHidden = true
                hdfcADBViewHeight.constant = 0
            }
            break
        
        default:
            break
        }
        
    }
    
    //--<hdfcIncrementDecreValueBtns>--
    
    //hdfc
    @IBAction func hdfcsumAssurdDecBtnCliked(_ sender: Any)
    {
        if(hdfcsumAssuredTfValue == 2500000)
        {
            hdfcsumAssuredTfValue = 2500000
        }else{
            hdfcsumAssuredTfValue -= 500000
        }
    }
    
    @IBAction func hdfcsumAssIncBtnCliked(_ sender: Any)
    {
        //        if(hdfcsumAssuredTfValue == 10000000)
        //        {
        //            hdfcsumAssuredTfValue = 10000000
        //        }else{
        hdfcsumAssuredTfValue += 500000
        //        }
    }
    
    @IBAction func hdfcpoliTrmDecBtnCliked(_ sender: Any)
    {
        if(hdfcpolicyTermTfValue == 0)
        {
            hdfcpolicyTermTfValue = 0
        }else{
            hdfcpolicyTermTfValue -= 1
        }
    }
    
    @IBAction func hdfcpoliTrmIncBtnCliked(_ sender: Any)
    {
        if(hdfcpolicyTermTfValue == 20)
        {
            hdfcpolicyTermTfValue = 20
        }else{
            hdfcpolicyTermTfValue += 1
        }
    }
    
    @IBAction func hdfcpreTrmDecBtnCliked(_ sender: Any)
    {
        if(self.premFrqLbl.text == "SINGLE")
        {
            hdfcpreTermTfValue = 1
        }
        else if(hdfcpreTermTfValue == 0)
        {
            hdfcpreTermTfValue = 0
        }else{
            hdfcpreTermTfValue -= 1
        }
    }
    
    @IBAction func hdfcpreTrmIncBtnCliked(_ sender: Any)
    {
        if(self.premFrqLbl.text == "SINGLE")
        {
            hdfcpreTermTfValue = 1
        }
        else if(hdfcpreTermTfValue == 20)
        {
            hdfcpreTermTfValue = 20
        }else{
            hdfcpreTermTfValue += 1
        }
        
    }
    
    @IBAction func hdfcsaincrDecBtnCliked(_ sender: Any)
    {
        if(hdfcsaIncreTfValue == 0)
        {
            hdfcsaIncreTfValue = 0
        }else{
            hdfcsaIncreTfValue -= 1
        }
    }
    
    @IBAction func hdfcsaincrIncBtnCliked(_ sender: Any)
    {
        if(self.premFrqLbl.text == "SINGLE")
        {
            hdfcsaIncreTfValue = 0
        }
        else if(hdfcsaIncreTfValue == 10){
            hdfcsaIncreTfValue = 10
        }else{
            hdfcsaIncreTfValue += 1
        }
        
    }
    
    @IBAction func hdfcADBDecBtnCliked(_ sender: Any)
    {
        if(hdfcADBTfValue == 0)
        {
            hdfcADBTfValue = 0
        }else{
            hdfcADBTfValue -= 1
        }
    }
    
    @IBAction func hdfcADBIncBtnCliked(_ sender: Any)
    {
        if(hdfcADBTfValue == 100)
        {
            hdfcADBTfValue = 100
        }else{
            hdfcADBTfValue += 1
        }
    }
    
    @IBAction func hdfcmonthincDecBtnCliked(_ sender: Any)
    {
        //        if(hdfcADBTfValue == 100)
        //        {
        //            hdfcADBTfValue = 100
        //        }else{
        hdfcmonthincomTfValue -= 1
        //        }
    }
    
    @IBAction func hdfcmonthincIncBtnCliked(_ sender: Any)
    {
        hdfcmonthincomTfValue += 1
    }
    
    @IBAction func hdfcincomperiDecBtnCliked(_ sender: Any)
    {
        if(hdfcincomperiTfValue == 0)
        {
            hdfcincomperiTfValue = 0
        }else{
            hdfcincomperiTfValue -= 1
        }
    }
    
    @IBAction func hdfcincomperiIncBtnCliked(_ sender: Any)
    {
        if(hdfcincomperiTfValue == 20)
        {
            hdfcincomperiTfValue = 20
        }else{
            hdfcincomperiTfValue += 1
        }
    }
    
    @IBAction func hdfcincreDecBtnCliked(_ sender: Any)
    {
        hdfcincresTfValue -= 1
    }
    
    @IBAction func hdfcincreIncBtnCliked(_ sender: Any)
    {
        hdfcincresTfValue += 1
    }
    
    
    @IBAction func getQuotesBtnCliked(_ sender: Any)
    {
        if(firstNameTf.text! != "" && lastNameTf.text! != "" && mobNoTf.text! != "" && mobNoTf.text!.count == 10)
        {
            smarttermlifeAPI()
        }
        else if(firstNameTf.text! == ""){
            TTGSnackbar.init(message: "Enter First Name", duration: .long).show()
        }
        else if(lastNameTf.text! == ""){
            TTGSnackbar.init(message: "Enter Last Name", duration: .long).show()
        }
        else if(mobNoTf.text! == ""){
            TTGSnackbar.init(message: "Enter Mobile Number", duration: .long).show()
        }
        else if(mobNoTf.text!.count != 10){
            TTGSnackbar.init(message: "Enter 10 digit Mobile Number", duration: .long).show()
        }
        
    }
    
    
    //---<APICALL>---
    func smarttermlifeAPI()
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
        
        var params:  [String: Any] = [ "NetPremium": "null","fba_id": FBAId!,"insImage": "null","quote": "null","statusProgress": "0","termRequestId": "0"]
        params["termRequestEntity"] = ["ADBPercentage": "0",
                                       "ADBSA": nil,
                                       "ADHB": "",
                                       "ATPDSA": nil,
                                       "CIBenefit": "",
                                       "CISA": nil,
                                       "CityName": "Mumbai",
                                       "ContactEmail": "finmarttest@gmail.com",
                                       "ContactMobile": mobNoTf.text!,
                                       "ContactName": firstNameTf.text! + " " + lastNameTf.text!,
                                       "DeathBenefitOption": deathBenefit,
                                       "Existing_ProductInsuranceMapping_Id": nil,
                                       "FBAID": FBAId!,
                                       "Frequency": premFrqLbl.text!.localizedCapitalized,
                                       "HCBSA": nil,
                                       "IncomeTerm": "0",
                                       "IncreaseIncomePercentage": hdfcsaIncreTf.text!,
                                       "IncreaseSAPercentage": hdfcsaIncreTf.text!,
                                       "InsuredDOB": dobTf.text!,
                                       "InsuredGender": gender,
//                                       "InsurerId": InsurerID,
                                       "InsurerId": "28",
                                       "Is_TabaccoUser": smoker,
                                       "LumpsumAmount": "10000000",
                                       "LumpsumBSAProp": nil,
                                       "LumpsumPercentage": "0",
                                       "MaritalStatus": "",
                                       "MonthlyIncome": "0",
                                       "PPT": hdfcpreTermAssuredTf.text!,
                                       "PaymentModeValue": "1",
                                       "PaymentOptn": nil,
                                       "PlanTaken": hdfcOptionLbl.text!.localizedCapitalized,
                                       "PolicyCommencementDate": dobTf.text!,
                                       "PolicyTerm": hdfcpolicyTermTf.text!,
                                       "PremiumPaymentOption": "",
                                       "ServiceTaxNotApplicable": "",
                                       "SessionID": "",
                                       "State": "Maharashtra",
                                       "SumAssured": hdfcsumAssuredTf.text!,
                                       "SupportsAgentID": "2335",
                                       "TypeOfLife": nil,
                                       "WOP": nil,
                                       "comment": nil,
                                       "created_date": nil,
                                       "crn": nil,
                                       "pincode": hdfcPincodeTf.text!]
        
        
        let url = "smart-term-life"
        
        FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params as [String : AnyObject], onSuccess: { (userObject, metadata) in
            alertView.close()
            
            self.view.layoutIfNeeded()
            
            let jsonData = userObject as? NSDictionary
            let LifeTermRequestID = jsonData?.value(forKey: "LifeTermRequestID") as AnyObject
            let Response = jsonData?.value(forKey: "Response") as! NSArray
            
            for i in 0..<Response.count {
                
                let dict = Response[i]
                
                let CustomerReferenceID = (Response[0] as AnyObject).value(forKey: "CustomerReferenceID") as! Int
                let CustomerReferenceIDString = String(CustomerReferenceID)
                let ProductPlanName = (Response[0] as AnyObject).value(forKey: "ProductPlanName") as! String
                let SumAssured = (Response[0] as AnyObject).value(forKey: "SumAssured") as! Int
                let sumAssuredString = String(SumAssured)
                let PolicyTermYear = (Response[0] as AnyObject).value(forKey: "PolicyTermYear") as! Int
                let PolicyTermYearString = String(PolicyTermYear)
                let NetPremium = (Response[0] as AnyObject).value(forKey: "NetPremium") as! Int
                let ProposerPageUrl = (Response[0] as AnyObject).value(forKey: "ProposerPageUrl") as! String
                
                UserDefaults.standard.set(String(describing: self.smoker), forKey: "smoker")
                UserDefaults.standard.set(String(describing: self.hdfcPincodeTf.text!), forKey: "hdfcPincode")
                UserDefaults.standard.set(String(describing: self.firstNameTf.text!), forKey: "frstName")
                UserDefaults.standard.set(String(describing: self.lastNameTf.text!), forKey: "lstName")
                UserDefaults.standard.set(String(describing: self.mobNoTf.text!), forKey: "mobNoTf")
                UserDefaults.standard.set(String(describing: CustomerReferenceIDString), forKey: "CustomerReferenceIDString")
                UserDefaults.standard.set(String(describing: ProductPlanName), forKey: "ProductPlanName")
                UserDefaults.standard.set(String(describing: sumAssuredString), forKey: "sumAssuredString")
                UserDefaults.standard.set(String(describing: PolicyTermYearString), forKey: "PolicyTermYearString")
                UserDefaults.standard.set(String(describing: NetPremium), forKey: "NetPremium")
                UserDefaults.standard.set(String(describing: ProposerPageUrl), forKey: "ProposerPageUrl")
                
            }
            
            TTGSnackbar.init(message: "Record saved successfully.", duration: .long).show()
            
            let MotorInsuranceV : MotorInsuranceVCS = self.storyboard?.instantiateViewController(withIdentifier: "stbMotorInsuranceVCS") as! MotorInsuranceVCS
            MotorInsuranceV.fromScreen = "fromhdfcgetQuote"
            self.present(MotorInsuranceV, animated:true, completion: nil)
            
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
        //        Btn.setTitleColor(UIColor.init(red: 0/225.0, green: 125/225.0, blue: 213/225.0, alpha: 1), for: UIControl.State.normal)
    }
    
    func btnColorChangeGray(Btn:UIButton)
    {
        let borderColr = UIColor.gray
        Btn.layer.cornerRadius=2.0;
        Btn.layer.borderWidth=1.0;
        Btn.layer.borderColor=borderColr.cgColor;
        //        Btn.setTitleColor(UIColor.gray, for: .normal)
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
