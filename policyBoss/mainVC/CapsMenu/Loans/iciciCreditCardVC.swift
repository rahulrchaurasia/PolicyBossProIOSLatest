//
//  iciciCreditCardVC.swift
//  MagicFinmart
//
//  Created by iOS Developer on 22/08/19.
//  Copyright © 2019 Ashwini. All rights reserved.
//

import UIKit
import CustomIOSAlertView
import TTGSnackbar

class iciciCreditCardVC: UIViewController,SelectedDateDelegate,getPickerDataDelegate,UITextFieldDelegate {
    
    @IBOutlet weak var personalView: UIView!
    @IBOutlet weak var companyDetailsView: UIView!
    @IBOutlet weak var addressDetailsView: UIView!
    @IBOutlet weak var contactDetailsView: UIView!
    @IBOutlet weak var perfirstNameTf: ACFloatingTextfield!
    @IBOutlet weak var perlastNameTf: ACFloatingTextfield!
    @IBOutlet weak var perdobTf: ACFloatingTextfield!
    @IBOutlet weak var maleImgView: UIImageView!
    @IBOutlet weak var femaleImgView: UIImageView!
    @IBOutlet weak var mothersmaidenNameTf: ACFloatingTextfield!
    @IBOutlet weak var noofDependLbl: UILabel!
    @IBOutlet weak var nametobeprintedoncardTf: ACFloatingTextfield!
    @IBOutlet weak var iwanttoapplyforsuppLbl: UILabel!
    @IBOutlet weak var preferredmailingLbl: UILabel!
    @IBOutlet weak var singlImgView: UIImageView!
    @IBOutlet weak var marriedImgView: UIImageView!
    @IBOutlet weak var indianImgView: UIImageView!
    @IBOutlet weak var nriforeignImgView: UIImageView!
    @IBOutlet weak var employtypeLbl: UILabel!
    @IBOutlet weak var companyNameTf: ACFloatingTextfield!
    @IBOutlet weak var designationTf: ACFloatingTextfield!
    @IBOutlet weak var workMailTf: ACFloatingTextfield!
    @IBOutlet weak var higstEduLbl: UILabel!
    @IBOutlet weak var incomeTf: ACFloatingTextfield!
    @IBOutlet weak var icicibankrelationLbl: UILabel!
    @IBOutlet weak var workedstdCodeLbl: ACFloatingTextfield!
    @IBOutlet weak var phnnumbrTf: ACFloatingTextfield!
    @IBOutlet weak var typeofCompanyLbl: UILabel!
    @IBOutlet weak var totlExpTf: ACFloatingTextfield!
    @IBOutlet weak var salryaccvthothrYesImgView: UIImageView!
    @IBOutlet weak var salryaccvthothrNoImgView: UIImageView!
    @IBOutlet weak var icicirelationshipnumbrTf: ACFloatingTextfield!
    @IBOutlet weak var curflatNoTf: ACFloatingTextfield!
    @IBOutlet weak var curBuildingNoTf: ACFloatingTextfield!
    @IBOutlet weak var curRoadTf: ACFloatingTextfield!
    @IBOutlet weak var curCityTf: ACFloatingTextfield!
    @IBOutlet weak var curpincodeTf: ACFloatingTextfield!
    @IBOutlet weak var curStateTf: ACFloatingTextfield!
    @IBOutlet weak var curResiTypeLbl: UILabel!
    @IBOutlet weak var sameasaboveImgView: UIImageView!
    @IBOutlet weak var perflatNoTf: ACFloatingTextfield!
    @IBOutlet weak var perBuildingNoTf: ACFloatingTextfield!
    @IBOutlet weak var perRoadTf: ACFloatingTextfield!
    @IBOutlet weak var perCityTf: ACFloatingTextfield!
    @IBOutlet weak var perpincodeTf: ACFloatingTextfield!
    @IBOutlet weak var perStateTf: ACFloatingTextfield!
    @IBOutlet weak var perEmailTf: ACFloatingTextfield!
    @IBOutlet weak var perResiTypeLbl: UILabel!
    @IBOutlet weak var stdCodeTf: ACFloatingTextfield!
    @IBOutlet weak var telephnNoTf: ACFloatingTextfield!
    @IBOutlet weak var cmpnymobileNoTf: ACFloatingTextfield!
    @IBOutlet weak var creditCardNoImgView: UIImageView!
    @IBOutlet weak var creditCardYesImgView: UIImageView!
    @IBOutlet weak var companyBankTf: ACFloatingTextfield!
    @IBOutlet weak var companymemberSinceTf: ACFloatingTextfield!
    @IBOutlet weak var companyCreditLmtTf: ACFloatingTextfield!
    @IBOutlet weak var identitypancardTf: ACFloatingTextfield!
    @IBOutlet weak var salaryaccopendLbl: UILabel!
    @IBOutlet weak var declaratnBtnImgView: UIImageView!
    @IBOutlet weak var entrbankView: UIView!
    @IBOutlet weak var membrncreditcardView: UIView!
    @IBOutlet weak var menbrcreditViewHeight: NSLayoutConstraint!
    @IBOutlet weak var sameasaboveBtn: UIButton!
    @IBOutlet weak var declartnBtn: UIButton!
    @IBOutlet weak var icicireltnshipView: UIView!
    @IBOutlet weak var icicireltnViewHeight: NSLayoutConstraint!
    
    var noofDependentsArray = ["0","1","2","3","4","5","5+"]
    var prefmailingaddressArray = ["Office","Residence"]
    var highEduQualiArray = ["Under Graduate","Graduate/Diploma","Post Graduate","Professional"]
    var icicibankRelatnArray = ["Salary","Saving","Loan","Non Relationship"]
    var typeofcompanyArray = ["Central Government","MNC","Partnership","Private Limited","Proprietorship","PSU","Public Limited","State Government"]
    var residnceTypeArray = ["Owned by self/spouse","Owned by parents/siblings","Rented with Family","Rented with Friends","Rented staying alone","Paying guest/Hostel","Company Provided"]
    var salaryacountopendArray = ["< 2 MONTHS","> 2 MONTHS"]
    var iwanttoapplyfrsuppcard = ["YES","NO"]
    var gender = "M"
    var singlemarried = "Single"
    var indiannri = "Indian"
    var salryAccount = "Yes"
    var hvcreditCard = "No"
    var sameasAbove = "off"
    var declrTerms = "off"
    
    override func viewDidLoad() {
        super.viewDidLoad()

       self.hideKeyboardWhenTappedAround()
       viewColorGray(view:personalView)
       viewColorGray(view:companyDetailsView)
       viewColorGray(view:addressDetailsView)
       viewColorGray(view:contactDetailsView)
       
       entrbankView.isHidden = true
       membrncreditcardView.isHidden = true
       menbrcreditViewHeight.constant = 0
       icicireltnshipView.isHidden = true
       icicireltnViewHeight.constant = 0
        
       identitypancardTf.autocapitalizationType = UITextAutocapitalizationType.allCharacters
       identitypancardTf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        
    }
    
    //---<textFieldRange>---
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if(textField == phnnumbrTf || textField == cmpnymobileNoTf)
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
        if(textField == identitypancardTf)
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
        else if(textField == curpincodeTf || textField == perpincodeTf)
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
        if identitypancardTf.text?.count == 5 || identitypancardTf.text?.count == 6 || identitypancardTf.text?.count == 7 || identitypancardTf.text?.count == 8
        {
            identitypancardTf.keyboardType = .numberPad
            identitypancardTf.reloadInputViews() // need to reload the input view for this work
        } else {
            identitypancardTf.keyboardType = .default
            identitypancardTf.reloadInputViews()
        }
    }
    //--------<end keyboard text change for PAN>--------

    
    @IBAction func dobBtnCliked(_ sender: Any)
    {
        self.view.endEditing(true)
        let DatePicker : DatePickerVC = storyboard?.instantiateViewController(withIdentifier: "stbDatePickerVC") as! DatePickerVC
        self.addChild(DatePicker)
        self.view.addSubview(DatePicker.view)
        DatePicker.dateDelegate = self
    }
    
    func getDateData(currDate: String, fromScreen: String) {
        print(currDate)
        perdobTf.text = currDate
        perdobTf.textColor = UIColor.black
    }
    
    func getintData(indata: Int) {
        
    }
    
    @IBAction func maleBtnCliked(_ sender: Any)
    {
        maleImgView.image = UIImage(named: "icons8-unchecked-radio-button-24 (1).png")
        femaleImgView.image = UIImage(named: "icons8-round-24.png")
        gender = "Male"
    }
    
    @IBAction func femaleBtnCliked(_ sender: Any)
    {
        femaleImgView.image = UIImage(named: "icons8-unchecked-radio-button-24 (1).png")
        maleImgView.image = UIImage(named: "icons8-round-24.png")
        gender = "Female"
    }
    
    @IBAction func noofDepenBtnCliked(_ sender: Any)
    {
        self.view.endEditing(true)
        let Picker : PickerViewVC! = storyboard?.instantiateViewController(withIdentifier: "stbPickerViewVC") as? PickerViewVC
        Picker.fromScreen = "noofDependents"
        Picker.pickerData = ["No of Dependents"]+noofDependentsArray
        self.addChild(Picker)
        self.view.addSubview(Picker.view)
        Picker.pickerdelegate = self
    }
    
    @IBAction func iwanttoapplyforsuppBtnCliked(_ sender: Any)
    {
        self.view.endEditing(true)
        let Picker : PickerViewVC! = storyboard?.instantiateViewController(withIdentifier: "stbPickerViewVC") as? PickerViewVC
        Picker.fromScreen = "supplimentarycard"
        Picker.pickerData = ["I want to apply for supplimentary card"]+iwanttoapplyfrsuppcard
        self.addChild(Picker)
        self.view.addSubview(Picker.view)
        Picker.pickerdelegate = self
    }
    
    @IBAction func preferredmailngBtnCliked(_ sender: Any)
    {
        self.view.endEditing(true)
        let Picker : PickerViewVC! = storyboard?.instantiateViewController(withIdentifier: "stbPickerViewVC") as? PickerViewVC
        Picker.fromScreen = "preferredmailingaddress"
        Picker.pickerData = ["Preferred mailing address"]+prefmailingaddressArray
        self.addChild(Picker)
        self.view.addSubview(Picker.view)
        Picker.pickerdelegate = self
    }
    
    @IBAction func singleBtnCliked(_ sender: Any)
    {
        singlImgView.image = UIImage(named: "icons8-unchecked-radio-button-24 (1).png")
        marriedImgView.image = UIImage(named: "icons8-round-24.png")
        singlemarried = "Single"
    }
    
    @IBAction func marriedBtnCliked(_ sender: Any)
    {
        marriedImgView.image = UIImage(named: "icons8-unchecked-radio-button-24 (1).png")
        singlImgView.image = UIImage(named: "icons8-round-24.png")
        singlemarried = "Married"
    }
    
    @IBAction func indianBtnCliked(_ sender: Any)
    {
        indianImgView.image = UIImage(named: "icons8-unchecked-radio-button-24 (1).png")
        nriforeignImgView.image = UIImage(named: "icons8-round-24.png")
        indiannri = "Indian"
    }
    
    @IBAction func nriforeignBtnCliked(_ sender: Any)
    {
        nriforeignImgView.image = UIImage(named: "icons8-unchecked-radio-button-24 (1).png")
        indianImgView.image = UIImage(named: "icons8-round-24.png")
        indiannri = "NRI/Foregin National"
    }
    
    @IBAction func highstEduBtnCliked(_ sender: Any)
    {
        self.view.endEditing(true)
        let Picker : PickerViewVC! = storyboard?.instantiateViewController(withIdentifier: "stbPickerViewVC") as? PickerViewVC
        Picker.fromScreen = "highEduQuali"
        Picker.pickerData = ["Highest Education Qualification"]+highEduQualiArray
        self.addChild(Picker)
        self.view.addSubview(Picker.view)
        Picker.pickerdelegate = self
    }
    
    @IBAction func icicibankRelatnBtnCliked(_ sender: Any)
    {
        self.view.endEditing(true)
        let Picker : PickerViewVC! = storyboard?.instantiateViewController(withIdentifier: "stbPickerViewVC") as? PickerViewVC
        Picker.fromScreen = "icicibankRelatn"
        Picker.pickerData = ["ICICI Bank Relationship"]+icicibankRelatnArray
        self.addChild(Picker)
        self.view.addSubview(Picker.view)
        Picker.pickerdelegate = self
    }
    
    @IBAction func typeofcompnyBtnCliked(_ sender: Any)
    {
        self.view.endEditing(true)
        let Picker : PickerViewVC! = storyboard?.instantiateViewController(withIdentifier: "stbPickerViewVC") as? PickerViewVC
        Picker.fromScreen = "typeofcompany"
        Picker.pickerData = ["Type Of Company"]+typeofcompanyArray
        self.addChild(Picker)
        self.view.addSubview(Picker.view)
        Picker.pickerdelegate = self
    }
    
    @IBAction func salaryaccvthothrYesImgView(_ sender: Any)
    {
        salryaccvthothrYesImgView.image = UIImage(named: "icons8-unchecked-radio-button-24 (1).png")
        salryaccvthothrNoImgView.image = UIImage(named: "icons8-round-24.png")
        salryAccount = "Yes"
    }
    
    @IBAction func salaryaccvthothrNoImgView(_ sender: Any)
    {
        salryaccvthothrNoImgView.image = UIImage(named: "icons8-unchecked-radio-button-24 (1).png")
        salryaccvthothrYesImgView.image = UIImage(named: "icons8-round-24.png")
        salryAccount = "No"
    }
    
    @IBAction func curResitypeBtnCliked(_ sender: Any)
    {
        self.view.endEditing(true)
        let Picker : PickerViewVC! = storyboard?.instantiateViewController(withIdentifier: "stbPickerViewVC") as? PickerViewVC
        Picker.fromScreen = "residnceType"
        Picker.pickerData = ["Residence Type"]+residnceTypeArray
        self.addChild(Picker)
        self.view.addSubview(Picker.view)
        Picker.pickerdelegate = self
    }
    
    @IBAction func perResitypeBtnCliked(_ sender: Any)
    {
        self.view.endEditing(true)
        let Picker : PickerViewVC! = storyboard?.instantiateViewController(withIdentifier: "stbPickerViewVC") as? PickerViewVC
        Picker.fromScreen = "residnceType2"
        Picker.pickerData = ["Residence Type"]+residnceTypeArray
        self.addChild(Picker)
        self.view.addSubview(Picker.view)
        Picker.pickerdelegate = self
    }
    
    @IBAction func sameasaboveBtnCliked(_ sender: Any)
    {
        if(sameasaboveBtn.tag == 0){
            sameasaboveImgView.image = UIImage(named: "black-check-box-with-white-check (2).png")
            sameasaboveBtn.tag = 1
            sameasAbove = "on"
            perflatNoTf.text! = curflatNoTf.text!
            perBuildingNoTf.text! = curBuildingNoTf.text!
            perRoadTf.text! = curRoadTf.text!
            perpincodeTf.text! = curpincodeTf.text!
            perCityTf.text! = curCityTf.text!
            perStateTf.text! = curStateTf.text!
            perResiTypeLbl.text! = curResiTypeLbl.text!
        }else if(sameasaboveBtn.tag == 1){
            sameasaboveImgView.image = UIImage(named: "check-box-empty.png")
            sameasaboveBtn.tag = 0
            sameasAbove = "off"
            perflatNoTf.text! = ""
            perBuildingNoTf.text! = ""
            perRoadTf.text! = ""
            perpincodeTf.text! = ""
            perCityTf.text! = ""
            perStateTf.text! = ""
            perResiTypeLbl.text! = ""
        }
    }
    
    @IBAction func creditCardYesBtnCliked(_ sender: Any)
    {
        creditCardYesImgView.image = UIImage(named: "icons8-unchecked-radio-button-24 (1).png")
        creditCardNoImgView.image = UIImage(named: "icons8-round-24.png")
        entrbankView.isHidden = false
        membrncreditcardView.isHidden = false
        menbrcreditViewHeight.constant = 60
        hvcreditCard = "Yes"
    }
    
    @IBAction func creditCardNoBtnCliked(_ sender: Any)
    {
        creditCardNoImgView.image = UIImage(named: "icons8-unchecked-radio-button-24 (1).png")
        creditCardYesImgView.image = UIImage(named: "icons8-round-24.png")
        entrbankView.isHidden = true
        membrncreditcardView.isHidden = true
        menbrcreditViewHeight.constant = 0
        hvcreditCard = "No"
    }
    
    @IBAction func salaryaccountOpendBtnCliked(_ sender: Any)
    {
        self.view.endEditing(true)
        let Picker : PickerViewVC! = storyboard?.instantiateViewController(withIdentifier: "stbPickerViewVC") as? PickerViewVC
        Picker.fromScreen = "salaryacountopend"
        Picker.pickerData = ["Salary Account Opened"]+salaryacountopendArray
        self.addChild(Picker)
        self.view.addSubview(Picker.view)
        Picker.pickerdelegate = self
    }
    
    @IBAction func declarationBtnCliked(_ sender: Any)
    {
        if(declartnBtn.tag == 0){
            declaratnBtnImgView.image = UIImage(named: "black-check-box-with-white-check (2).png")
            declartnBtn.tag = 1
            declrTerms = "on"
        }else if(declartnBtn.tag == 1){
            declaratnBtnImgView.image = UIImage(named: "check-box-empty.png")
            declartnBtn.tag = 0
            declrTerms = "off"
        }
    }
    
    func getPickerDataValue(pickerSelectedData: String, fromScreen: String, pickerSelectedId: String) {
        switch fromScreen
        {
        case "noofDependents":
            self.noofDependLbl.text = pickerSelectedData
            break
        case "supplimentarycard":
            self.iwanttoapplyforsuppLbl.text = pickerSelectedData
            break
        case "highEduQuali":
            self.higstEduLbl.text = pickerSelectedData
            break
        case "preferredmailingaddress":
            self.preferredmailingLbl.text = pickerSelectedData
            break
        case "icicibankRelatn":
            self.icicibankrelationLbl.text = pickerSelectedData
            if(self.icicibankrelationLbl.text == "Salary")
            {
                icicireltnshipView.isHidden = false
                icicireltnViewHeight.constant = 60
            }else{
                icicireltnshipView.isHidden = true
                icicireltnViewHeight.constant = 0
            }
            break
        case "typeofcompany":
            self.typeofCompanyLbl.text = pickerSelectedData
            break
        case "residnceType":
            self.curResiTypeLbl.text = pickerSelectedData
            break
        case "residnceType2":
            self.perResiTypeLbl.text = pickerSelectedData
            break
        case "salaryacountopend":
            self.salaryaccopendLbl.text = pickerSelectedData
            break
        default:
            break
        }
    }
    
    @IBAction func backBtnCliked(_ sender: Any)
    {
        let stbcreditCard : creditCardVC = self.storyboard?.instantiateViewController(withIdentifier: "stbcreditCardVC") as! creditCardVC
        present(stbcreditCard, animated: true, completion: nil)
    }
    
    @IBAction func iciciNextBtnCliked(_ sender: Any)
    {
        if(declrTerms == "on" && perfirstNameTf.text! != "" && perlastNameTf.text! != "" && perdobTf.text! != "" && mothersmaidenNameTf.text! != "" && nametobeprintedoncardTf.text! != "" && companyNameTf.text! != "" && designationTf.text! != "" && workMailTf.text! != "" && incomeTf.text! != "" && workedstdCodeLbl.text! != "" && phnnumbrTf.text! != "" && totlExpTf.text! != "" && curflatNoTf.text! != "" && curBuildingNoTf.text! != "" && curRoadTf.text! != "" && curCityTf.text! != "" && curpincodeTf.text! != "" && curStateTf.text! != "" && perflatNoTf.text! != "" && perBuildingNoTf.text! != "" && perRoadTf.text! != "" && perCityTf.text! != "" && perpincodeTf.text! != "" && perStateTf.text! != "" && perEmailTf.text! != "" && stdCodeTf.text! != "" && telephnNoTf.text! != "" && identitypancardTf.text! != "")
        {
            creditcardiciciAPI()
        }
        else if(perfirstNameTf.text! == ""){
            TTGSnackbar.init(message: "Enter first name", duration: .long).show()
        }
        else if(perlastNameTf.text! == ""){
            TTGSnackbar.init(message: "Enter last name", duration: .long).show()
        }
        else if(perdobTf.text! == ""){
            TTGSnackbar.init(message: "Select date of birth", duration: .long).show()
        }
        else if(mothersmaidenNameTf.text! == ""){
            TTGSnackbar.init(message: "Enter mother's maiden name", duration: .long).show()
        }
        else if(companyNameTf.text! == ""){
            TTGSnackbar.init(message: "Enter Company name", duration: .long).show()
        }
        else if(designationTf.text! == ""){
            TTGSnackbar.init(message: "Enter Designation", duration: .long).show()
        }
        else if(workMailTf.text! == ""){
            TTGSnackbar.init(message: "Enter work mail", duration: .long).show()
        }
        else if(incomeTf.text! == ""){
            TTGSnackbar.init(message: "Enter Income", duration: .long).show()
        }
        else if(workedstdCodeLbl.text! == ""){
            TTGSnackbar.init(message: "Enter Worked STD", duration: .long).show()
        }
        else if(phnnumbrTf.text! == ""){
            TTGSnackbar.init(message: "Enter phone number", duration: .long).show()
        }
        else if(totlExpTf.text! == ""){
            TTGSnackbar.init(message: "Enter total experiance", duration: .long).show()
        }
        else if(curflatNoTf.text! == ""){
            TTGSnackbar.init(message: "Enter current flat no/house no", duration: .long).show()
        }
        else if(curBuildingNoTf.text! == ""){
            TTGSnackbar.init(message: "Enter current building no/society no", duration: .long).show()
        }
        else if(curRoadTf.text! == ""){
            TTGSnackbar.init(message: "Enter current road/area/Locality", duration: .long).show()
        }
        else if(curpincodeTf.text! == ""){
            TTGSnackbar.init(message: "Enter current pincode", duration: .long).show()
        }
        else if(curStateTf.text! == ""){
            TTGSnackbar.init(message: "Enter current state", duration: .long).show()
        }
        else if(curCityTf.text! == ""){
            TTGSnackbar.init(message: "Enter current city", duration: .long).show()
        }
        else if(perflatNoTf.text! == ""){
            TTGSnackbar.init(message: "Enter permenant flat no/house no", duration: .long).show()
        }
        else if(perBuildingNoTf.text! == ""){
            TTGSnackbar.init(message: "Enter permenant building no/society no", duration: .long).show()
        }
        else if(perRoadTf.text! == ""){
            TTGSnackbar.init(message: "Enter permenant road/area/Locality", duration: .long).show()
        }
        else if(perpincodeTf.text! == ""){
            TTGSnackbar.init(message: "Enter permenant pincode", duration: .long).show()
        }
        else if(perStateTf.text! == ""){
            TTGSnackbar.init(message: "Enter permenant state", duration: .long).show()
        }
        else if(perCityTf.text! == ""){
            TTGSnackbar.init(message: "Enter permenant city", duration: .long).show()
        }
        else if(declrTerms == "off"){
            TTGSnackbar.init(message: "Accept Terms and Conditions", duration: .long).show()
        }
    }
    
    
    //---<APICALL>---
    func getrblcityAPI()
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
        
        let params: [String: AnyObject] = [:]
        
        let url = "/api/get-rbl-city"
        
        FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
            alertView.close()
            
            self.view.layoutIfNeeded()
            
            let jsonData = userObject as? NSDictionary
            print("jsonData=",jsonData!)
            
//            let CityName = jsonData?.value(forKey: "CityName") as! [String]
//            let CityCode = jsonData?.value(forKey: "CityCode") as! [String]
            
            
            
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
    
    func creditcardiciciAPI()
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
        
        let params: [String: AnyObject] = ["ApplicantFirstName": perfirstNameTf.text! as AnyObject,
                                           "ApplicantLastName": perlastNameTf.text! as AnyObject,
                                           "ApplicantMiddleName": "" as AnyObject,
                                           "CampaignName": "Rupeeboss Online" as AnyObject,
                                           "ChannelType": "RupeeBoss" as AnyObject,
                                           "City": curCityTf.text! as AnyObject,
                                           "CompanyName": companyNameTf.text! as AnyObject,
                                           "CreditCardDetailId": 20 as AnyObject,
                                           "CustomerProfile": "Salaried" as AnyObject,
                                           "DateOfBirth": perdobTf.text! as AnyObject,
                                           "Gender": gender as AnyObject,
                                           "ICICIBankRelationship": "Non Relationship" as AnyObject,
                                           "ICICIRelationshipNumber": icicirelationshipnumbrTf.text! as AnyObject,
                                           "Income": incomeTf.text! as AnyObject,
                                           "MotherName": mothersmaidenNameTf.text! as AnyObject,
                                           "NameOnCard": nametobeprintedoncardTf.text! as AnyObject,
                                           "PanNo": identitypancardTf.text! as AnyObject,
                                           "PerCity": perCityTf.text! as AnyObject,
                                           "PerResidenceAddress1": perflatNoTf.text! as AnyObject,
                                           "PerResidenceAddress2": perBuildingNoTf.text! as AnyObject,
                                           "PerResidenceAddress3": perRoadTf.text! as AnyObject,
                                           "PerResidencePincode": perpincodeTf.text! as AnyObject,
                                           "PerResidenceState": perStateTf.text! as AnyObject,
                                           "ResidenceAddress1": perflatNoTf.text! as AnyObject,
                                           "ResidenceAddress2": perBuildingNoTf.text! as AnyObject,
                                           "ResidenceAddress3": perRoadTf.text! as AnyObject,
                                           "ResidenceMobileNo": "8687775754" as AnyObject,
                                           "ResidencePhoneNumber": "227757575" as AnyObject,
                                           "ResidencePincode": perpincodeTf.text! as AnyObject,
                                           "ResidenceState": curStateTf.text! as AnyObject,
                                           "STDCode": stdCodeTf.text! as AnyObject,
                                           "SalaryAccountOpened": salaryaccopendLbl.text! as AnyObject,
                                           "SalaryAccountWithOtherBank": salryAccount as AnyObject,
                                           "Total_Exp": totlExpTf.text! as AnyObject,
                                           "amount": ">3.0Lacs" as AnyObject,
                                           "brokerid": "38054" as AnyObject,
                                           "credit_date": "" as AnyObject,
                                           "credit_limit": "" as AnyObject,
                                           "designation": designationTf.text! as AnyObject,
                                           "email_id": perEmailTf.text! as AnyObject,
                                           "fba_id": FBAId as AnyObject,
                                           "have_credit_card": hvcreditCard as AnyObject,
                                           "highest_education": higstEduLbl.text! as AnyObject,
                                           "interest": "LIFESTYLE" as AnyObject,
                                           "marital_status": singlemarried as AnyObject,
                                           "no_of_dependents": noofDependLbl.text! as AnyObject,
                                           "per_res_type": perResiTypeLbl.text! as AnyObject,
                                           "preferred_address": "Residence" as AnyObject,
                                           "previous_bank": "" as AnyObject,
                                           "prod": "Coral-Credit-Card" as AnyObject,
                                           "resident_status": indiannri as AnyObject,
                                           "same": sameasAbove as AnyObject,
                                           "supplementary_card": iwanttoapplyforsuppLbl.text! as AnyObject,
                                           "terms": declrTerms as AnyObject,
                                           "type": "finmart" as AnyObject,
                                           "type_current": "Owned by parents/siblings" as AnyObject,
                                           "type_of_company": typeofCompanyLbl.text! as AnyObject,
                                           "work_STDCode": workedstdCodeLbl.text! as AnyObject,
                                           "work_email": workMailTf.text! as AnyObject,
                                           "work_number": phnnumbrTf.text! as AnyObject]
        
        let url = "/api/credit-card-icici"
        
        FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
            alertView.close()
            
            self.view.layoutIfNeeded()
            
            let jsonData = userObject as? NSDictionary
            print("jsonData=",jsonData!)
            
            let ApplicationId = jsonData?.value(forKey: "ApplicationId") as! String
            let Decision = jsonData?.value(forKey: "Decision") as! String
            let Reason = jsonData?.value(forKey: "Reason") as! String
            
            let appliedSuccessfuly : appliedSuccessfulyVC = self.storyboard?.instantiateViewController(withIdentifier: "stbappliedSuccessfulyVC") as! appliedSuccessfulyVC
            appliedSuccessfuly.applictntext = ApplicationId
            appliedSuccessfuly.decisntext = Decision
            appliedSuccessfuly.mesgtext = Reason
            self.addChild(appliedSuccessfuly)
            self.view.addSubview(appliedSuccessfuly.view)
            
            
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
    

    func viewColorGray(view:UIView)
    {
        let borderColr = UIColor.lightGray
        view.layer.cornerRadius=2.0;
        view.layer.borderWidth=1.0;
        view.layer.borderColor=borderColr.cgColor;
        view.layer.shadowColor=borderColr.cgColor;
        view.layer.shadowRadius=2.0;
        //        Btn.setTitleColor(UIColor.gray, for: .normal)
    }

}
