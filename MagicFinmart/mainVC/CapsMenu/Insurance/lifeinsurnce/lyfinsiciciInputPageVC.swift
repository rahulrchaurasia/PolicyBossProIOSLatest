//
//  lyfinsiciciInputPageVC.swift
//  MagicFinmart
//
//  Created by Admin on 27/03/19.
//  Copyright © 2019 Ashwini. All rights reserved.
//

import UIKit
import CustomIOSAlertView
import TTGSnackbar

class lyfinsiciciInputPageVC: UIViewController,SelectedDateDelegate,getPickerDataDelegate,UITextFieldDelegate {

    @IBOutlet var firstlastNameView: UIView!
    @IBOutlet var firstlastNameViewHeight: NSLayoutConstraint!//60
    @IBOutlet var mobdobView: UIView!
    @IBOutlet var mobdobViewHeight: NSLayoutConstraint!//60
    @IBOutlet var gendersmokerView: UIView!
    @IBOutlet var gendersmokerViewHeight: NSLayoutConstraint!//60
    @IBOutlet weak var compView: UIView!
    @IBOutlet weak var compViewHeight: NSLayoutConstraint!//140
    @IBOutlet weak var hdfcView: UIView!
    @IBOutlet weak var hdfcViewHeight: NSLayoutConstraint!//472
    @IBOutlet weak var iciciView: UIView!
    @IBOutlet weak var iciciViewHeight: NSLayoutConstraint!//600
    @IBOutlet weak var icicisaIncreaView: UIView!
    @IBOutlet weak var icicisaIncreasHeight: NSLayoutConstraint!//50
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
    @IBOutlet weak var icicaccdentlView: UIView!
    @IBOutlet weak var icicaccdenViewHeight: NSLayoutConstraint!
    @IBOutlet weak var iciciAccDeathViewTop: NSLayoutConstraint!
    @IBOutlet weak var iciclumpSumView: UIView!
    @IBOutlet weak var iciclumpsumViewHeight: NSLayoutConstraint!
    @IBOutlet weak var icicipolicyTermViewTop: NSLayoutConstraint!
    @IBOutlet weak var iciciprePaymntView: UIView!
    @IBOutlet weak var icicipremiPayLbl: UILabel!
    @IBOutlet weak var maleBtn: UIButton!
    @IBOutlet weak var femaleBtn: UIButton!
    @IBOutlet weak var sYesBtn: UIButton!
    @IBOutlet weak var sNoBtn: UIButton!
    @IBOutlet weak var lumpSumBtn: UIButton!
    @IBOutlet weak var reguIncomeBtn: UIButton!
    @IBOutlet weak var increIncomeBtn: UIButton!
    @IBOutlet weak var lumpnreguIncomeBtn: UIButton!
    @IBOutlet weak var comppolicytermLbl: UILabel!
    @IBOutlet weak var premtermLbl: UILabel!
    @IBOutlet weak var premFrqLbl: UILabel!
    @IBOutlet weak var hdfcOptionLbl: UILabel!
    @IBOutlet weak var icicipaytermLbl: UILabel!
    @IBOutlet weak var icicpreFrqLbl: UILabel!
    @IBOutlet weak var icicioptionLbl: UILabel!
    @IBOutlet var sumLbl: UILabel!
    @IBOutlet var ageLbl: UILabel!
    @IBOutlet var crnLbl: UILabel!
    @IBOutlet var malesmkerLbl: UILabel!
    @IBOutlet var termLbl: UILabel!
    @IBOutlet var qimgView: UIImageView!
    @IBOutlet var qplanLbl: UILabel!
    @IBOutlet var qRsLbl: UILabel!
    @IBOutlet var qCoverLbl: UILabel!
    @IBOutlet var qpolicyTermLbl: UILabel!
    @IBOutlet var quptoageLbl: UILabel!
    
    @IBOutlet weak var firstNameTf: ACFloatingTextfield!
    @IBOutlet weak var lastNameTf: ACFloatingTextfield!
    @IBOutlet weak var mobNoTf: ACFloatingTextfield!
    @IBOutlet weak var dobTf: ACFloatingTextfield!
    @IBOutlet weak var compPincodeTf: ACFloatingTextfield!
    @IBOutlet weak var compsumAssuredTf: ACFloatingTextfield!
    @IBOutlet weak var hdfcPincodeTf: ACFloatingTextfield!
    @IBOutlet weak var icicPincodeTf: ACFloatingTextfield!
    @IBOutlet weak var hdfcsumAssuredTf: ACFloatingTextfield!
    @IBOutlet weak var hdfcpolicyTermTf: ACFloatingTextfield!
    @IBOutlet weak var hdfcpreTermAssuredTf: ACFloatingTextfield!
    @IBOutlet weak var hdfcsaIncreTf: ACFloatingTextfield!
    @IBOutlet weak var icicisumAssuredTf: ACFloatingTextfield!
    @IBOutlet weak var icicilumpsumTf: ACFloatingTextfield!
    @IBOutlet weak var icicipolicyTermTf: ACFloatingTextfield!
    @IBOutlet weak var icicipreTermAssuredTf: ACFloatingTextfield!
    @IBOutlet weak var icicicritiillTf: ACFloatingTextfield!
    @IBOutlet weak var icicacceDeathTf: ACFloatingTextfield!
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
    var smoker = "true"
    var pincodeText = ""
    var premiumFrqText = ""
    var optionText = ""
    var sumassuredText = ""
    var policyTermText = ""
    var preTermText = ""
    var criticalIllnessText = ""
    var deathBenefit = "lump-sum"
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
    //--<iciciIncrementDecreValues>--
    var icicisumAssuredTfValue: Int = 0 {
        didSet {
            icicisumAssuredTf.text! = "\(icicisumAssuredTfValue)"
        }
    }
    var icicilumpsumTfValue: Int = 0 {
        didSet {
            icicilumpsumTf.text! = "\(icicilumpsumTfValue)"
        }
    }
    var icicipolicyTermTfValue: Int = 0 {
        didSet {
            icicipolicyTermTf.text! = "\(icicipolicyTermTfValue)"
        }
    }
    var icicipreTermAssuredTfValue: Int = 0 {
        didSet {
            icicipreTermAssuredTf.text! = "\(icicipreTermAssuredTfValue)"
        }
    }
    var icicicritiillTfValue: Int = 0 {
        didSet {
            icicicritiillTf.text! = "\(icicicritiillTfValue)"
        }
    }
    var icicacceDeathTfValue: Int = 0 {
        didSet {
            icicacceDeathTf.text! = "\(icicacceDeathTfValue)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        //        let borderColr = UIColor.lightGray
        //        topfrstView.layer.cornerRadius=2.0;
        //        topfrstView.layer.borderWidth=1.0;
        //        topfrstView.layer.borderColor=borderColr.cgColor;
        //btn
//        btnColorChangeBlue(Btn: maleBtn)
//        btnColorChangeGray(Btn: femaleBtn)
//        btnColorChangeBlue(Btn: sNoBtn)
//        btnColorChangeGray(Btn: sYesBtn)
        btnColorChangeBlue(Btn: lumpSumBtn)
        btnColorChangeGray(Btn: reguIncomeBtn)
        btnColorChangeGray(Btn: increIncomeBtn)
        btnColorChangeGray(Btn: lumpnreguIncomeBtn)
        
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
        icicPincodeTf.text! = pincde
        icicisumAssuredTf.text! = sumassurd
//        icicipaytermLbl.text! =
//        icicipremiPayLbl.text! =
        
        //views
        //        viewColorGray(view:bankimageView)
        //        viewColorGray(view:planeView)
        //        viewColorGray(view:sharecartView)
        //        viewColorGray(view:coverView)
        //        viewColorGray(view:policyTermView)
        //        viewColorGray(view:uptodateView)
        
        //--<HideViews>--
//        hdfcmothlyIncomeVIew.isHidden = true
//        hdfcmonthIcomeViewHeight.constant = 0
//        hdfcIncomePeriodView.isHidden = true
//        hdfcIncomePeriViewHeight.constant = 0
//        hdfcincreView.isHidden = true
//        hdfcIncreViewHeight.constant = 0
//        hdfcADBView.isHidden = true
//        hdfcADBViewHeight.constant = 0
        //        icicisaIncreaView.isHidden = true
        //        icicisaIncreasHeight.constant = 0
        iciciprePaymntView.isHidden = true
        icicipolicyTermViewTop.constant = 0
        iciclumpSumView.isHidden = true
        iciclumpsumViewHeight.constant = 0
        icicisaIncreaView.isHidden = true
        icicisaIncreasHeight.constant = 0
        icicaccdentlView.isHidden = true
        icicaccdenViewHeight.constant = 0
        
        //--<Input>--
//        if(fromScreen == "compInput"){
//            //            topfrstView.isHidden = true
//            //            topfrstViewHeight.constant = 0
//            //            quoteSecondView.isHidden = true
//            //            quoteSecondViewHeight.constant = 0
//            compView.isHidden = false
//            compViewHeight.constant = 140
//            hdfcView.isHidden = true
//            hdfcViewHeight.constant = 0
//            iciciView.isHidden = true
//            iciciViewHeight.constant = 0
//            pincodeText = compPincodeTf.text!
//        }
//        if(fromScreen == "hdfcInput"){
//            //            topfrstView.isHidden = true
//            //            topfrstViewHeight.constant = 0
//            //            quoteSecondView.isHidden = true
//            //            quoteSecondViewHeight.constant = 0
//            compView.isHidden = true
//            compViewHeight.constant = 0
//            hdfcView.isHidden = false
//            hdfcViewHeight.constant = 655
//            iciciView.isHidden = true
//            iciciViewHeight.constant = 0
//            pincodeText = hdfcPincodeTf.text!
//        }
//        if(fromScreen == "iciciInput"){
//            //            topfrstView.isHidden = true
//            //            topfrstViewHeight.constant = 0
//            //            quoteSecondView.isHidden = true
//            //            quoteSecondViewHeight.constant = 0
//            compView.isHidden = true
//            compViewHeight.constant = 0
//            hdfcView.isHidden = true
//            hdfcViewHeight.constant = 0
//            iciciView.isHidden = false
//            iciciViewHeight.constant = 732
//            pincodeText = icicPincodeTf.text!
//        }
//
        //        //--<Quotes>--
        //        if(fromScreen == "compQuote"){
        ////            topfrstView.isHidden = false
        ////            topfrstViewHeight.constant = 80
        ////            quoteSecondView.isHidden = true
        ////            quoteSecondViewHeight.constant = 0
        //            compView.isHidden = false
        //            compViewHeight.constant = 140
        //            hdfcView.isHidden = true
        //            hdfcViewHeight.constant = 0
        //            iciciView.isHidden = true
        //            iciciViewHeight.constant = 0
        //            pincodeText = compPincodeTf.text!
        //        }
        //        if(fromScreen == "hdfcQuote"){
        ////            topfrstView.isHidden = false
        ////            topfrstViewHeight.constant = 80
        ////            quoteSecondView.isHidden = false
        ////            quoteSecondViewHeight.constant = 145
        //            firstlastNameView.isHidden = true
        //            firstlastNameViewHeight.constant = 0
        //            compView.isHidden = true
        //            compViewHeight.constant = 0
        //            hdfcView.isHidden = false
        //            hdfcViewHeight.constant = 655
        //            iciciView.isHidden = true
        //            iciciViewHeight.constant = 0
        //            pincodeText = hdfcPincodeTf.text!
        //        }
        //        if(fromScreen == "iciciQuote"){
        ////            topfrstView.isHidden = false
        ////            topfrstViewHeight.constant = 80
        ////            quoteSecondView.isHidden = false
        ////            quoteSecondViewHeight.constant = 145
        //            compView.isHidden = true
        //            compViewHeight.constant = 0
        //            hdfcView.isHidden = true
        //            hdfcViewHeight.constant = 0
        //            iciciView.isHidden = false
        //            iciciViewHeight.constant = 732
        //            pincodeText = icicPincodeTf.text!
        //        }
        
        //--<hdfcIncrementDecreValues>--
//        hdfcsumAssuredTfValue = 10000000 // didSet is called when the variable is changed, not upon initialization.
//        hdfcpolicyTermTfValue = 20
//        hdfcpreTermTfValue = 20
//        hdfcsaIncreTfValue = 10
//        hdfcADBTfValue = 100
//        hdfcmonthincomTfValue = 25000
//        hdfcincomperiTfValue = 20
//        hdfcincresTfValue = 5
        //--<iciciIncrementDecreValues>--
        icicisumAssuredTfValue = 10000000
        icicilumpsumTfValue = 50
        icicipolicyTermTfValue = 20
        icicipreTermAssuredTfValue = 20
        icicicritiillTfValue = 1000000
        icicacceDeathTfValue = 10000000
        
        icicisumAssuredTf.text! = "10000000"
        
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
        else if(textField == icicPincodeTf)
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
//        if(hdfcOptionLbl.text! == "LIFE LONG PROTECTION" || hdfcOptionLbl.text! == "3D LIFE LONG PROTECTION")
//        {
//            let policyTermValue = 100 - Age
//            hdfcpolicyTermTf.text! = String(policyTermValue)
//            let premiumTermValue = 65 - Age
//            hdfcpreTermAssuredTf.text! = String(premiumTermValue)
//        }
        if(icicipaytermLbl.text! == "LIMITED PAY")
        {
            let policyTermValue = 60 - Age
            icicipolicyTermTf.text! = String(policyTermValue)
            let premiumTermValue = 60 - Age
            icicipreTermAssuredTf.text! = String(premiumTermValue)
        }
        if(icicipaytermLbl.text! == "WHOLE LIFE")
        {
            let policyTermValue = 99 - Age
            icicipolicyTermTf.text! = String(policyTermValue)
            let premiumTermValue = 99 - Age
            icicipreTermAssuredTf.text! = String(premiumTermValue)
        }
        
    }
    
    func getintData(indata: Int)
    {
        
    }
    
    @IBAction func qEditBtnCliked(_ sender: Any)
    {
        
    }
    
    @IBAction func qShareBtnCliked(_ sender: Any)
    {
        
    }
    
    @IBAction func qCartBtnCliked(_ sender: Any)
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
    
    @IBAction func lumpSumBtnCliked(_ sender: Any)
    {
        btnColorChangeBlue(Btn: lumpSumBtn)
        btnColorChangeGray(Btn: reguIncomeBtn)
        btnColorChangeGray(Btn: increIncomeBtn)
        btnColorChangeGray(Btn: lumpnreguIncomeBtn)
        deathBenefit = "lump-sum"
        
        icicipolicyTermViewTop.constant = 0
        iciclumpSumView.isHidden = true
        iciclumpsumViewHeight.constant = 0
        //        icicisaIncreaView.isHidden = false
        //        icicisaIncreasHeight.constant = 50
        //        icicaccdentlView.isHidden = false
        //        icicaccdenViewHeight.constant = 50
    }
    
    @IBAction func reguIncomeBtnCliked(_ sender: Any)
    {
        btnColorChangeBlue(Btn: reguIncomeBtn)
        btnColorChangeGray(Btn: lumpSumBtn)
        btnColorChangeGray(Btn: increIncomeBtn)
        btnColorChangeGray(Btn: lumpnreguIncomeBtn)
        deathBenefit = "regular-income"
        
        icicipolicyTermViewTop.constant = 0
        iciclumpSumView.isHidden = true
        iciclumpsumViewHeight.constant = 0
        //        icicisaIncreaView.isHidden = false
        //        icicisaIncreasHeight.constant = 50
        //        icicaccdentlView.isHidden = false
        //        icicaccdenViewHeight.constant = 50
    }
    
    @IBAction func increIncomeBtnCliked(_ sender: Any)
    {
        btnColorChangeBlue(Btn: increIncomeBtn)
        btnColorChangeGray(Btn: lumpSumBtn)
        btnColorChangeGray(Btn: reguIncomeBtn)
        btnColorChangeGray(Btn: lumpnreguIncomeBtn)
        deathBenefit = "increasing-income"
        
        icicipolicyTermViewTop.constant = 0
        iciclumpSumView.isHidden = true
        iciclumpsumViewHeight.constant = 0
        //        icicisaIncreaView.isHidden = false
        //        icicisaIncreasHeight.constant = 50
        //        icicaccdentlView.isHidden = false
        //        icicaccdenViewHeight.constant = 50
    }
    
    @IBAction func lumpnreguIncomeBtnCliked(_ sender: Any)
    {
        btnColorChangeBlue(Btn: lumpnreguIncomeBtn)
        btnColorChangeGray(Btn: lumpSumBtn)
        btnColorChangeGray(Btn: increIncomeBtn)
        btnColorChangeGray(Btn: reguIncomeBtn)
        deathBenefit = "lump-sum+regular-income"
        
        icicipolicyTermViewTop.constant = 10
        iciclumpSumView.isHidden = false
        iciclumpsumViewHeight.constant = 50
        //        icicisaIncreaView.isHidden = false
        //        icicisaIncreasHeight.constant = 50
        //        icicaccdentlView.isHidden = false
        //        icicaccdenViewHeight.constant = 50
        
    }
    
    @IBAction func policyTermSelctBtnCliked(_ sender: Any)
    {
        self.view.endEditing(true)
        let Picker : PickerViewVC! = storyboard?.instantiateViewController(withIdentifier: "stbPickerViewVC") as? PickerViewVC
        Picker.fromScreen = "compPolicyTerm"
        Picker.pickerData = policyTermArray
        //        Picker.pickerIdData = sourceIdArray
        self.addChild(Picker)
        self.view.addSubview(Picker.view)
        Picker.pickerdelegate = self
    }
    
    @IBAction func premiTermSelctBtnCliked(_ sender: Any)
    {
        self.view.endEditing(true)
        let Picker : PickerViewVC! = storyboard?.instantiateViewController(withIdentifier: "stbPickerViewVC") as? PickerViewVC
        Picker.fromScreen = "compPremiumTerm"
        Picker.pickerData = policyTermArray
        //        Picker.pickerIdData = sourceIdArray
        self.addChild(Picker)
        self.view.addSubview(Picker.view)
        Picker.pickerdelegate = self
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
    
    @IBAction func icicipaytermSelctBtnCliked(_ sender: Any)
    {
        self.view.endEditing(true)
        let Picker : PickerViewVC! = storyboard?.instantiateViewController(withIdentifier: "stbPickerViewVC") as? PickerViewVC
        Picker.fromScreen = "icicipayTerm"
        Picker.pickerData = icicipayTermArray
        //        Picker.pickerIdData = sourceIdArray
        self.addChild(Picker)
        self.view.addSubview(Picker.view)
        Picker.pickerdelegate = self
    }
    
    @IBAction func prefrqSlctBtnCliked(_ sender: Any)
    {
        self.view.endEditing(true)
        let Picker : PickerViewVC! = storyboard?.instantiateViewController(withIdentifier: "stbPickerViewVC") as? PickerViewVC
        Picker.fromScreen = "icicipreFrq"
        Picker.pickerData = iciciPreFrqArray
        //        Picker.pickerIdData = sourceIdArray
        self.addChild(Picker)
        self.view.addSubview(Picker.view)
        Picker.pickerdelegate = self
    }
    
    @IBAction func icicioptionBtnCliked(_ sender: Any)
    {
        self.view.endEditing(true)
        let Picker : PickerViewVC! = storyboard?.instantiateViewController(withIdentifier: "stbPickerViewVC") as? PickerViewVC
        Picker.fromScreen = "iciciOption"
        Picker.pickerData = iciciOptionArray
        //        Picker.pickerIdData = sourceIdArray
        self.addChild(Picker)
        self.view.addSubview(Picker.view)
        Picker.pickerdelegate = self
    }
    
    @IBAction func icicipremiPayBtnCliked(_ sender: Any)
    {
        self.view.endEditing(true)
        let Picker : PickerViewVC! = storyboard?.instantiateViewController(withIdentifier: "stbPickerViewVC") as? PickerViewVC
        Picker.fromScreen = "icicipremiumPayment"
        if(icicipaytermLbl.text! == "LIMITED PAY"){
            Picker.pickerData = iciciprePayArray
        }
        if(icicipaytermLbl.text! == "WHOLE LIFE"){
            Picker.pickerData = iciciprePayArray2
        }
        self.addChild(Picker)
        self.view.addSubview(Picker.view)
        Picker.pickerdelegate = self
    }
    
    
    func getPickerDataValue(pickerSelectedData: String, fromScreen: String, pickerSelectedId: String) {
        switch fromScreen
        {
        case "compPolicyTerm":
            self.comppolicytermLbl.text = pickerSelectedData
            self.premtermLbl.text = pickerSelectedData
            //            self.sourceId = pickerSelectedId
            break
        case "compPremiumTerm":
            self.premtermLbl.text = pickerSelectedData
            //            self.sourceId = pickerSelectedId
            break
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
        case "icicipayTerm":
            self.icicipaytermLbl.text = pickerSelectedData
            //            self.sourceId = pickerSelectedId
            if(icicipaytermLbl.text! == "LIMITED PAY")
            {
                self.icicipremiPayLbl.text = "PAY TILL AGE 60"
                iciciprePaymntView.isHidden = false
            }
            else if(icicipaytermLbl.text! == "WHOLE LIFE")
            {
                self.icicipremiPayLbl.text = "PAY TILL AGE 99"
                iciciprePaymntView.isHidden = false
            }
            else{
                iciciprePaymntView.isHidden = true
            }
            break
        case "icicipreFrq":
            self.icicpreFrqLbl.text = pickerSelectedData
            //            self.sourceId = pickerSelectedId
            break
        case "iciciOption":
            self.icicioptionLbl.text = pickerSelectedData
            //            self.sourceId = pickerSelectedId
            if(icicioptionLbl.text == "LIFE"){
                icicipolicyTermViewTop.constant = 0
                iciclumpSumView.isHidden = true
                iciclumpsumViewHeight.constant = 0
                icicisaIncreaView.isHidden = true
                icicisaIncreasHeight.constant = 0
                icicaccdentlView.isHidden = true
                icicaccdenViewHeight.constant = 0
            }
            else if(icicioptionLbl.text == "LIFE PLUS"){
                icicipolicyTermViewTop.constant = 0
                iciciAccDeathViewTop.constant = 0
                iciclumpSumView.isHidden = true
                iciclumpsumViewHeight.constant = 0
                icicisaIncreaView.isHidden = true
                icicisaIncreasHeight.constant = 0
                icicaccdentlView.isHidden = false
                icicaccdenViewHeight.constant = 50
            }
            else if(icicioptionLbl.text == "LIFE AND HEALTH"){
                icicipolicyTermViewTop.constant = 0
                iciclumpSumView.isHidden = true
                iciclumpsumViewHeight.constant = 0
                icicisaIncreaView.isHidden = false
                icicisaIncreasHeight.constant = 50
                icicaccdentlView.isHidden = true
                icicaccdenViewHeight.constant = 0
            }
            else if(icicioptionLbl.text == "ALL IN ONE"){
                icicipolicyTermViewTop.constant = 0
                iciciAccDeathViewTop.constant = 10
                iciclumpSumView.isHidden = true
                iciclumpsumViewHeight.constant = 0
                icicisaIncreaView.isHidden = false
                icicisaIncreasHeight.constant = 50
                icicaccdentlView.isHidden = false
                icicaccdenViewHeight.constant = 50
            }
            else{
                iciclumpSumView.isHidden = true
                iciclumpsumViewHeight.constant = 0
                icicisaIncreaView.isHidden = true
                icicisaIncreasHeight.constant = 0
                icicaccdentlView.isHidden = true
                icicaccdenViewHeight.constant = 0
            }
            break
        case "icicipremiumPayment":
            self.icicipremiPayLbl.text = pickerSelectedData
            //            self.sourceId = pickerSelectedId
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
    
    
    //icici
    @IBAction func icicsumAssDecBtnCliked(_ sender: Any)
    {
        if(icicisumAssuredTfValue == 100000)
        {
            icicisumAssuredTfValue = 100000
        }else{
            icicisumAssuredTfValue -= 500000
        }
    }
    
    @IBAction func icicsumAssIncBtnCliked(_ sender: Any)
    {
        icicisumAssuredTfValue += 500000
    }
    
    @IBAction func iciclumpsumDecBtnCliked(_ sender: Any)
    {
        if(icicilumpsumTfValue == 0)
        {
            icicilumpsumTfValue = 0
        }else{
            icicilumpsumTfValue -= 5
        }
    }
    
    @IBAction func iciclumpsumIncBtnCliked(_ sender: Any)
    {
        if(icicilumpsumTfValue == 95)
        {
            icicilumpsumTfValue = 95
        }else{
            icicilumpsumTfValue += 5
        }
    }
    
    @IBAction func icicpoliTrmDecBtnCliked(_ sender: Any)
    {
        icicipolicyTermTfValue -= 1
    }
    
    @IBAction func icicpoliTrmIncBtnCliked(_ sender: Any)
    {
        icicipolicyTermTfValue += 1
    }
    
    @IBAction func icicpreTrmDecBtnCliked(_ sender: Any)
    {
        icicipreTermAssuredTfValue -= 1
    }
    
    @IBAction func icicpreTrmIncBtnCliked(_ sender: Any)
    {
        icicipreTermAssuredTfValue += 1
    }
    
    @IBAction func icicsaincreDecBtnCliked(_ sender: Any)
    {
        icicicritiillTfValue -= 100000
    }
    
    @IBAction func icicsaincrIncBtnCliked(_ sender: Any)
    {
        icicicritiillTfValue += 100000
    }
    
    @IBAction func icicaccdeathDecBtnCliked(_ sender: Any)
    {
        icicacceDeathTfValue -= 100000
    }
    
    @IBAction func icicaccdeathIncBtnCliked(_ sender: Any)
    {
        icicacceDeathTfValue += 100000
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
        params["termRequestEntity"] = ["ADBPercentage": nil,
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
                                       "Frequency": icicpreFrqLbl.text!.localizedCapitalized,
                                       "HCBSA": nil,
                                       "IncomeTerm": nil,
                                       "IncreaseIncomePercentage": nil,
                                       "IncreaseSAPercentage": nil,
                                       "InsuredDOB": dobTf.text!,
                                       "InsuredGender": gender,
                                       "InsurerId": "39",
                                       "Is_TabaccoUser": smoker,
                                       "LumpsumAmount": nil,
                                       "LumpsumBSAProp": nil,
                                       "LumpsumPercentage": "0",
                                       "MaritalStatus": "",
                                       "MonthlyIncome": "0",
                                       "PPT": icicipreTermAssuredTf.text!.localizedCapitalized,
                                       "PaymentModeValue": "1",
                                       "PaymentOptn": nil,
                                       "PlanTaken": icicioptionLbl.text!.localizedCapitalized,
                                       "PolicyCommencementDate": dobTf.text!,
                                       "PolicyTerm": icicipolicyTermTf.text!,
                                       "PremiumPaymentOption": icicipaytermLbl.text!.localizedCapitalized,
                                       "ServiceTaxNotApplicable": "",
                                       "SessionID": "",
                                       "State": "Maharashtra",
                                       "SumAssured": icicisumAssuredTf.text!,
                                       "SupportsAgentID": "2335",
                                       "TypeOfLife": nil,
                                       "WOP": nil,
                                       "comment": nil,
                                       "created_date": nil,
                                       "crn": nil,
                                       "pincode": icicPincodeTf.text!]
            
        let url = "/api/smart-term-life"
        
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
                UserDefaults.standard.set(String(describing: self.icicPincodeTf.text!), forKey: "hdfcPincode")
                UserDefaults.standard.set(String(describing: self.firstNameTf.text!), forKey: "frstName")
                UserDefaults.standard.set(String(describing: self.lastNameTf.text!), forKey: "lstName")
                UserDefaults.standard.set(String(describing: CustomerReferenceIDString), forKey: "CustomerReferenceIDString")
                UserDefaults.standard.set(String(describing: ProductPlanName), forKey: "ProductPlanName")
                UserDefaults.standard.set(String(describing: sumAssuredString), forKey: "sumAssuredString")
                UserDefaults.standard.set(String(describing: PolicyTermYearString), forKey: "PolicyTermYearString")
                UserDefaults.standard.set(String(describing: NetPremium), forKey: "NetPremium")
                UserDefaults.standard.set(String(describing: ProposerPageUrl), forKey: "ProposerPageUrl")
                
                
            }
            
            TTGSnackbar.init(message: "Record saved successfully.", duration: .long).show()
            
            let MotorInsuranceV : MotorInsuranceVCS = self.storyboard?.instantiateViewController(withIdentifier: "stbMotorInsuranceVCS") as! MotorInsuranceVCS
            MotorInsuranceV.fromScreen = "fromicicigetQuote"
            self.present(MotorInsuranceV, animated:true, completion: nil)
            
            
        }, onError: { errorData in
            alertView.close()
            let snackbar = TTGSnackbar.init(message: errorData.errorMessage, duration: .long)
            snackbar.show()
        }, onForceUpgrade: {errorData in})
        
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
