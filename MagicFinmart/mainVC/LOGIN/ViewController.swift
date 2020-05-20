//
//  ViewController.swift
//  MagicFinmart
//
//  Created by Ashwini on 10/12/18.
//  Copyright © 2018 Ashwini. All rights reserved.
//

import UIKit
import CustomIOSAlertView
import TTGSnackbar

class ViewController: UIViewController,UITextFieldDelegate,SelectedDateDelegate,getPickerDataDelegate,selectedDataDelegate {
  
    let aTextField = ACFloatingTextfield()

    @IBOutlet var ViewControllerBckView: UIView!
    @IBOutlet weak var verifymobOTPView: UIView!
    @IBOutlet weak var verifymobOTPViewHeight: NSLayoutConstraint!//250
    @IBOutlet weak var perArrowImg: UIImageView!
    @IBOutlet weak var profArrowImg: UIImageView!
    @IBOutlet weak var persnlBtn: UIButton!
    @IBOutlet weak var profBtn: UIButton!
    @IBOutlet weak var persnlTfView: UIView!
    @IBOutlet weak var persnlTfViewHeight: NSLayoutConstraint!//660
    @IBOutlet weak var profTfView: UIView!
    @IBOutlet weak var profTfViewHeight: NSLayoutConstraint!//380
    @IBOutlet weak var maleBtn: UIButton!
    @IBOutlet weak var femaleBtn: UIButton!
    //textfield
    @IBOutlet weak var firstNameTf: ACFloatingTextfield!
    @IBOutlet weak var lastNameTf: ACFloatingTextfield!
    @IBOutlet weak var dobTf: ACFloatingTextfield!
    @IBOutlet weak var mob1Tf: ACFloatingTextfield!
    @IBOutlet weak var mob2Tf: ACFloatingTextfield!
    @IBOutlet weak var emailTf: ACFloatingTextfield!
    @IBOutlet weak var confEmailTf: ACFloatingTextfield!
    @IBOutlet weak var pincodeTf: ACFloatingTextfield!
    @IBOutlet weak var cityTf: ACFloatingTextfield!
    @IBOutlet weak var stateTf: ACFloatingTextfield!
    @IBOutlet weak var referrCodeTf: ACFloatingTextfield!
    @IBOutlet weak var sourceLbl: UILabel!
    @IBOutlet weak var lifeinsuranceCheckbox: UIImageView!
    @IBOutlet weak var gernalinsuranceCheckbox: UIImageView!
    @IBOutlet weak var healthinsuranceCheckbox: UIImageView!
    @IBOutlet weak var mutualfundCheckbox: UIImageView!
    @IBOutlet weak var stockinsuranceCheckbox: UIImageView!
    @IBOutlet weak var postalinsuranceCheckbox: UIImageView!
    @IBOutlet weak var bondsinsuranceCheckbox: UIImageView!
    @IBOutlet weak var lifeinsuranceLbl: UILabel!
    @IBOutlet weak var gernlinsuranceLbl: UILabel!
    @IBOutlet weak var healthinsuranceLbl: UILabel!
    @IBOutlet weak var lifeinsuranceBtn: UIButton!
    @IBOutlet weak var gernlinsuranceBtn: UIButton!
    @IBOutlet weak var healthinsuranceBtn: UIButton!
    @IBOutlet weak var mutualfundBtn: UIButton!
    @IBOutlet weak var stockBtn: UIButton!
    @IBOutlet weak var postalBtn: UIButton!
    @IBOutlet weak var bondBtn: UIButton!
    @IBOutlet weak var verifymobTextView: UITextView!
    @IBOutlet weak var verifyOtpTf: ACFloatingTextfield!
    @IBOutlet weak var fieldSaleView: UIView!
    @IBOutlet weak var fieldSaleViewHeight: NSLayoutConstraint!//60
    @IBOutlet weak var fieldSaleLbl: UILabel!
    
    var lifeinsuranceSelected = "0"
    var gernalinsuranceSelected = "0"
    var healthinsuranceSelected = "0"
    var mutualFundSelected = "0"
    var stocksSelected = "0"
    var postalSelected = "0"
    var bondsSelected = "0"
    var Gender = "M"
    var profViewOpen = "No"
    
    var sourceNameArray = [String]()
    var sourceIdArray = [String]()
    var EmployeeNameArray = [String]()
    var EmployeeIdArray = [String]()
    var sourceId = ""
    var EmployeeId = ""
    var fromScreen = ""
    var multipleSelectedData = String()
    
    var multiselctionTV : multiselctionTVC! = multiselctionTVC()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //---<hideViews>--
        ViewControllerBckView.isHidden = true
        verifymobOTPView.isHidden = true
        verifymobOTPViewHeight.constant = 0
        persnlTfView.isHidden = true
        persnlTfViewHeight.constant = 0
        profTfView.isHidden = true
        profTfViewHeight.constant = 0
        fieldSaleView.isHidden = true
        fieldSaleViewHeight.constant = 0
        //--<border>--
        let borderColr = UIColor.init(red: 0/225.0, green: 125/225.0, blue: 213/225.0, alpha: 1)
        self.maleBtn.layer.cornerRadius=2.0;
        self.maleBtn.layer.borderWidth=2.0;
        self.maleBtn.layer.borderColor=borderColr.cgColor;
        let borderColor = UIColor.gray
        self.femaleBtn.layer.cornerRadius=2.0;
        self.femaleBtn.layer.borderWidth=2.0;
        self.femaleBtn.layer.borderColor=borderColor.cgColor;
        self.maleBtn.setTitleColor(UIColor.init(red: 0/225.0, green: 125/225.0, blue: 213/225.0, alpha: 1), for: UIControl.State.normal)

        //--<textField>--
        aTextField.delegate = self
        multiselctionTV.delegateData = self
    
        getregistrationsourceAPI()
        getfieldsalesAPI()
    }
    
    func getselectedData(selectedData: [String], stringId : String) {
        print("selectedData=",selectedData)
        print("stringId=",stringId)
        if(stringId == "lyf")
        {
            lifeinsuranceLbl.text = selectedData.joined(separator: ",")
        }
        else if(stringId == "gen")
        {
            gernlinsuranceLbl.text = selectedData.joined(separator: ",")
        }
        else if(stringId == "health")
        {
            healthinsuranceLbl.text = selectedData.joined(separator: ",")
        }
    }
    
    @IBAction func regiBackBtnCliked(_ sender: Any)
    {
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
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
    
    //---<textFieldRange>---
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if(textField == mob1Tf  ||  textField == mob2Tf)
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
        else if(textField == pincodeTf || textField == referrCodeTf)
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
        if (textField == self.cityTf || textField == self.stateTf)
        {
            getCityStateAPI()
        }
        if(textField == self.referrCodeTf)
        {
            validaterefercodeAPI()
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
    }
    
    //---<ButtonCliked>---
    @IBAction func persnlBtnCliked(_ sender: Any)
    {
        if(persnlTfView.isHidden)
        {
            if(self.sourceLbl.text == "Finmart"){
                fieldSaleView.isHidden = true
                fieldSaleViewHeight.constant = 0
                persnlTfView.isHidden = false
                persnlTfViewHeight.constant = 600
            }else{
                fieldSaleView.isHidden = false
                fieldSaleViewHeight.constant = 60
                persnlTfView.isHidden = false
                persnlTfViewHeight.constant = 660
            }
            profTfView.isHidden = true
            profTfViewHeight.constant = 0
            perArrowImg.image = UIImage(named: "up_arrow.png")
            profArrowImg.image = UIImage(named: "down_arrow.png")
        }
        else{
            persnlTfView.isHidden = true
            persnlTfViewHeight.constant = 0
            perArrowImg.image = UIImage(named: "down_arrow.png")
        }
    }
    
    @IBAction func profBtnCliked(_ sender: Any)
    {
        if(firstNameTf.text != "" && lastNameTf.text != "" && dobTf.text != "" && mob1Tf.text != "" && emailTf.text != "" && confEmailTf.text != "" && pincodeTf.text != "" && cityTf.text != "" && stateTf.text != "" && sourceLbl.text != "" && mob1Tf.text?.count == 10)
        {
            if(isValidEmail(testStr: emailTf.text!) && isValidEmail(testStr: confEmailTf.text!))
            {
                if(self.profViewOpen != "Yes")
                {
                    if(emailTf.text! == confEmailTf.text!)
                    {
                        //--<generateOTP>--
                        generateOTPAPI()
                    }
                    else{
                        alertCall(message:"Email Mismatch")
                    }
                }
                else if(self.profTfView.isHidden)
                {
                    self.profTfView.isHidden = false
                    self.profTfViewHeight.constant = 380
                    self.persnlTfView.isHidden = true
                    self.persnlTfViewHeight.constant = 0
                    self.profArrowImg.image = UIImage(named: "up_arrow.png")
                    self.perArrowImg.image = UIImage(named: "down_arrow.png")
                }
                else{
                    self.profTfView.isHidden = true
                    self.profTfViewHeight.constant = 0
                    self.profArrowImg.image = UIImage(named: "down_arrow.png")
                }
            }
            else{
                alertCall(message: "Please enter valid Email Id")
//                let alert = UIAlertController(title: "Alert", message: "Invalid Email Id", preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
//                self.present(alert, animated: true, completion: nil)
            }
        }
        else if(firstNameTf.text == "" || lastNameTf.text == "" || dobTf.text == "" || mob1Tf.text == "" || emailTf.text == "" || confEmailTf.text == "" || pincodeTf.text == "" || cityTf.text == "" || stateTf.text == "" || sourceLbl.text == "")
        {
            if(self.sourceLbl.text == "Finmart"){
                fieldSaleView.isHidden = true
                fieldSaleViewHeight.constant = 0
                persnlTfView.isHidden = false
                persnlTfViewHeight.constant = 600
            }else{
                fieldSaleView.isHidden = false
                fieldSaleViewHeight.constant = 60
                persnlTfView.isHidden = false
                persnlTfViewHeight.constant = 660
            }
            perArrowImg.image = UIImage(named: "up_arrow.png")
            profTfView.isHidden = true
            profTfViewHeight.constant = 0
            profArrowImg.image = UIImage(named: "down_arrow.png")
            alertCall(message: "Enter Fields")
//            let alert = UIAlertController(title: "Alert", message: "Enter Fields", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //---<EmailValidation>---
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
   
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
        dobTf.text = currDate
        dobTf.textColor = UIColor.black
    }
    func getintData(indata: Int) {
        
    }
        
    @IBAction func maleBtnCliked(_ sender: Any)
    {
        let borderColor = UIColor.init(red: 0/255.0, green: 125/255.0, blue: 213/255.0, alpha: 1)
        self.maleBtn.layer.cornerRadius=2.0;
        self.maleBtn.layer.borderWidth=2.0;
        self.maleBtn.layer.borderColor=borderColor.cgColor;
        self.maleBtn.setTitleColor(UIColor.init(red: 0/225.0, green: 125/225.0, blue: 213/225.0, alpha: 1), for: UIControl.State.normal)
        let borderColorr = UIColor.gray
        self.femaleBtn.layer.cornerRadius=2.0;
        self.femaleBtn.layer.borderWidth=2.0;
        self.femaleBtn.layer.borderColor = borderColorr.cgColor
        self.femaleBtn.titleLabel?.textColor = UIColor.darkGray
        self.Gender = "M"
    }
    @IBAction func femaleBtnCliked(_ sender: Any)
    {
        let borderColor = UIColor.init(red: 0/255.0, green: 125/255.0, blue: 213/255.0, alpha: 1)
        self.femaleBtn.layer.cornerRadius=2.0;
        self.femaleBtn.layer.borderWidth=2.0;
        self.femaleBtn.layer.borderColor=borderColor.cgColor;
        self.femaleBtn.setTitleColor(UIColor.init(red: 0/225.0, green: 125/225.0, blue: 213/225.0, alpha: 1), for: UIControl.State.normal)
        let borderColorr = UIColor.gray
        self.maleBtn.layer.cornerRadius=2.0;
        self.maleBtn.layer.borderWidth=2.0;
        self.maleBtn.layer.borderColor = borderColorr.cgColor
        self.maleBtn.titleLabel?.textColor = UIColor.darkGray
        self.Gender = "F"
    }
    
    @IBAction func sourceLblBtnCliked(_ sender: Any)
    {
        self.view.endEditing(true)
        let Picker : PickerViewVC! = storyboard?.instantiateViewController(withIdentifier: "stbPickerViewVC") as? PickerViewVC
        Picker.fromScreen = "source"
        Picker.pickerData = ["Select"]+sourceNameArray
        Picker.pickerIdData = [""]+sourceIdArray
        self.addChild(Picker)
        self.view.addSubview(Picker.view)
        Picker.pickerdelegate = self
    }
    @IBAction func fieldSaleBtnCliked(_ sender: Any)
    {
        self.view.endEditing(true)
        let Picker : PickerViewVC! = storyboard?.instantiateViewController(withIdentifier: "stbPickerViewVC") as? PickerViewVC
        Picker.fromScreen = "fieldSale"
        Picker.pickerData = ["Select"]+EmployeeNameArray
        Picker.pickerIdData = [""]+EmployeeIdArray
        self.addChild(Picker)
        self.view.addSubview(Picker.view)
        Picker.pickerdelegate = self
    }
    
    func getPickerDataValue(pickerSelectedData: String, fromScreen: String, pickerSelectedId: String) {
        switch fromScreen
        {
        case "source":
            self.sourceLbl.text = pickerSelectedData
            self.sourceId = pickerSelectedId
            if(self.sourceLbl.text == "Finmart"){
                fieldSaleView.isHidden = true
                fieldSaleViewHeight.constant = 0
                persnlTfView.isHidden = false
                persnlTfViewHeight.constant = 600
            }else{
                fieldSaleView.isHidden = false
                fieldSaleViewHeight.constant = 60
                persnlTfView.isHidden = false
                persnlTfViewHeight.constant = 660
            }
            break
        case "fieldSale":
            self.fieldSaleLbl.text = pickerSelectedData
            self.EmployeeId = pickerSelectedId
            break
        default:
            break
        }
        
    }
    
    @IBAction func lifedropDownBtn(_ sender: Any)
    {
        if(lifeinsuranceLbl.isEnabled)
        {
            multiselctionTV = storyboard?.instantiateViewController(withIdentifier: "stbmultiselctionTVC") as? multiselctionTVC
            multiselctionTV.fromScreen = "lifeInsurance"
            multiselctionTV.delegateData = self
            self.addChild(multiselctionTV)
            self.view.addSubview(multiselctionTV.view)
//            self.present(multiselctionTV, animated: true, completion: nil)
        }
    }
    @IBAction func genrldropDownBtn(_ sender: Any)
    {
        if(gernlinsuranceLbl.isEnabled)
        {
            multiselctionTV = storyboard?.instantiateViewController(withIdentifier: "stbmultiselctionTVC") as? multiselctionTVC
            multiselctionTV.fromScreen = "genInsurance"
            multiselctionTV.delegateData = self
            self.addChild(multiselctionTV)
            self.view.addSubview(multiselctionTV.view)
//            self.present(multiselctionTV, animated: true, completion: nil)
        }
    }
    @IBAction func healthdropDownBtn(_ sender: Any)
    {
        if(healthinsuranceLbl.isEnabled)
        {
            multiselctionTV = storyboard?.instantiateViewController(withIdentifier: "stbmultiselctionTVC") as? multiselctionTVC
            multiselctionTV.fromScreen = "healthInsurance"
            multiselctionTV.delegateData = self
            self.addChild(multiselctionTV)
            self.view.addSubview(multiselctionTV.view)
//            self.present(multiselctionTV, animated: true, completion: nil)
        }
    }
    @IBAction func lifeinsuranceBtnCliked(_ sender: Any)
    {
        if(lifeinsuranceBtn.tag == 0)
        {
            lifeinsuranceCheckbox.image = UIImage(named: "black-check-box-with-white-check (2).png")
            lifeinsuranceLbl.isEnabled = true
            lifeinsuranceBtn.tag = 1
            lifeinsuranceSelected = "1"
        }else{
            lifeinsuranceCheckbox.image = UIImage(named: "check-box-empty.png")
            lifeinsuranceLbl.isEnabled = false
            lifeinsuranceBtn.tag = 0
        }
        
    }
    @IBAction func gernalinsuranceBtnCliked(_ sender: Any)
    {
        if(gernlinsuranceBtn.tag == 0)
        {
            gernalinsuranceCheckbox.image = UIImage(named: "black-check-box-with-white-check (2).png")
            gernlinsuranceLbl.isEnabled = true
            gernlinsuranceBtn.tag = 1
            gernalinsuranceSelected = "1"
        }else{
            gernalinsuranceCheckbox.image = UIImage(named: "check-box-empty.png")
            gernlinsuranceLbl.isEnabled = false
            gernlinsuranceBtn.tag = 0
        }
    }
    @IBAction func healthinsuranceBtnCliked(_ sender: Any)
    {
        if(healthinsuranceBtn.tag == 0)
        {
            healthinsuranceCheckbox.image = UIImage(named: "black-check-box-with-white-check (2).png")
            healthinsuranceLbl.isEnabled = true
            healthinsuranceBtn.tag = 1
            healthinsuranceSelected = "1"
        }else{
            healthinsuranceCheckbox.image = UIImage(named: "check-box-empty.png")
            healthinsuranceLbl.isEnabled = false
            healthinsuranceBtn.tag = 0
        }
    }
    @IBAction func mutualfundBtnCliked(_ sender: Any)
    {
        if(mutualfundBtn.tag == 0)
        {
            mutualfundCheckbox.image = UIImage(named: "black-check-box-with-white-check (2).png")
            mutualfundBtn.tag = 1
            mutualFundSelected = "1"
        }else{
            mutualfundCheckbox.image = UIImage(named: "check-box-empty.png")
            mutualfundBtn.tag = 0
        }
    }
    @IBAction func stocksBtnCliked(_ sender: Any)
    {
        if(stockBtn.tag == 0)
        {
            stockinsuranceCheckbox.image = UIImage(named: "black-check-box-with-white-check (2).png")
            stockBtn.tag = 1
            stocksSelected = "1"
        }else{
            stockinsuranceCheckbox.image = UIImage(named: "check-box-empty.png")
            stockBtn.tag = 0
        }
    }
    @IBAction func postalBtnCliked(_ sender: Any)
    {
        if(postalBtn.tag == 0)
        {
            postalinsuranceCheckbox.image = UIImage(named: "black-check-box-with-white-check (2).png")
            postalBtn.tag = 1
            postalSelected = "1"
        }else{
            postalinsuranceCheckbox.image = UIImage(named: "check-box-empty.png")
            postalBtn.tag = 0
        }
    }
    @IBAction func bondsBtnCliked(_ sender: Any)
    {
        if(bondBtn.tag == 0)
        {
            bondsinsuranceCheckbox.image = UIImage(named: "black-check-box-with-white-check (2).png")
            bondBtn.tag = 1
            bondsSelected = "1"
        }else{
            bondsinsuranceCheckbox.image = UIImage(named: "check-box-empty.png")
            bondBtn.tag = 0
        }
    }
    
    @IBAction func submitBtnCliked(_ sender: Any)
    {
        if(firstNameTf.text != "" && lastNameTf.text != "" && dobTf.text != "" && mob1Tf.text != "" && mob1Tf.text?.count == 10 && emailTf.text != "" && confEmailTf.text != "" && pincodeTf.text != "" && cityTf.text != "" && stateTf.text != "" && sourceLbl.text != "")
        { 
            registrationSubmitAPI()
        }
        else if((firstNameTf.text?.isEmpty)!){
            if(self.sourceLbl.text == "Finmart"){
                fieldSaleView.isHidden = true
                fieldSaleViewHeight.constant = 0
                persnlTfView.isHidden = false
                persnlTfViewHeight.constant = 600
            }else{
                fieldSaleView.isHidden = false
                fieldSaleViewHeight.constant = 60
                persnlTfView.isHidden = false
                persnlTfViewHeight.constant = 660
            }
            perArrowImg.image = UIImage(named: "up_arrow.png")
            profTfView.isHidden = true
            profTfViewHeight.constant = 0
            profArrowImg.image = UIImage(named: "down_arrow.png")
//            firstNameTf.attributedPlaceholder = NSAttributedString(string: "First Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            alertCall(message:"Enter First Name")
        }
        else{
            if(self.sourceLbl.text == "Finmart"){
                fieldSaleView.isHidden = true
                fieldSaleViewHeight.constant = 0
                persnlTfView.isHidden = false
                persnlTfViewHeight.constant = 600
            }else{
                fieldSaleView.isHidden = false
                fieldSaleViewHeight.constant = 60
                persnlTfView.isHidden = false
                persnlTfViewHeight.constant = 660
            }
            perArrowImg.image = UIImage(named: "up_arrow.png")
            profTfView.isHidden = true
            profTfViewHeight.constant = 0
            profArrowImg.image = UIImage(named: "down_arrow.png")
            alertCall(message:"Enter Previous Details")
//            let alert = UIAlertController(title: "Alert", message: "Enter Previous Details", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func resendBtnCliked(_ sender: Any)
    {
        generateOTPAPI()
    }
    
    @IBAction func verifyMobBtnCliked(_ sender: Any)
    {
        if(verifyOtpTf.text! != "")
        {
            retriveOTPAPI()
        }
        else{
            alertCall(message: "Please Enter OTP")
//            let alert = UIAlertController(title: "Alert", message: "Please Enter OTP", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func verifyViewCloseBtnCliked(_ sender: Any)
    {
        ViewControllerBckView.isHidden = true
        verifymobOTPView.isHidden = true
        verifymobOTPViewHeight.constant = 0
    }
    
    //---<APICALL>---
    func generateOTPAPI()
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
        let params: [String: AnyObject] = ["MobileNo": mob1Tf.text! as AnyObject]
        
        let url = "/api/generate-otp"
        
        FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
            alertView.close()
            
            self.view.layoutIfNeeded()
            
            let jsonData = userObject as? NSArray
           
            self.verifymobOTPView.isHidden = false
            self.verifymobOTPViewHeight.constant = 250
            self.ViewControllerBckView.isHidden = false
            self.verifymobTextView.text! =  "Enter OTP sent on Mobile no " + self.mob1Tf.text!
            
            TTGSnackbar.init(message: "OTP has been sent", duration: .long).show()
            
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
    
    func retriveOTPAPI()
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
        let params: [String: AnyObject] = ["MobileNo": mob1Tf.text! as AnyObject,
                                           "MobileOTP": verifyOtpTf.text! as AnyObject]
        
        let url = "/api/retrive-otp"
        
        FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
            alertView.close()
            
            self.view.layoutIfNeeded()
            
            let jsonData = userObject as? NSArray

                self.verifymobOTPView.isHidden = true
                self.verifymobOTPViewHeight.constant = 0
                self.ViewControllerBckView.isHidden = true
                
                if(self.profTfView.isHidden)
                {
                    self.profTfView.isHidden = false
                    self.profTfViewHeight.constant = 380
                    self.persnlTfView.isHidden = true
                    self.persnlTfViewHeight.constant = 0
                    self.profArrowImg.image = UIImage(named: "up_arrow.png")
                    self.perArrowImg.image = UIImage(named: "down_arrow.png")
                    self.profViewOpen = "Yes"
                }
                else{
                    self.profTfView.isHidden = true
                    self.profTfViewHeight.constant = 0
                    self.profArrowImg.image = UIImage(named: "down_arrow.png")
                    self.profViewOpen = "Yes"
                }
            
                TTGSnackbar.init(message: "OTP verified successfully", duration: .long).show()

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
        let params: [String: AnyObject] = ["PinCode": pincodeTf.text! as AnyObject]
        
        let url = "/api/get-city-and-state"
        
        FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
            alertView.close()
            
            self.view.layoutIfNeeded()
            
            let jsonData = userObject as? NSDictionary
            let state_name = jsonData?.value(forKey: "state_name") as? String
            let cityname = jsonData?.value(forKey: "cityname") as? String
            self.stateTf.text! = state_name!
            self.cityTf.text! = cityname!
 
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
    
    func validaterefercodeAPI()
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
        let params: [String: AnyObject] = ["ref_code": "Kxwz4l" as AnyObject,
                                           "ref_type":"0" as AnyObject]
        
        let url = "/api/validate-refer-code"
        
        FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
            alertView.close()
            
            self.view.layoutIfNeeded()
            
            let jsonData = userObject as? NSString
            
            
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
    
    func getregistrationsourceAPI()
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
        
        let url = "/api/get-registration-source"
        
        FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
            alertView.close()
            
            self.view.layoutIfNeeded()
            
            let jsonData = userObject as? NSArray
            let Source_name = jsonData?.value(forKey: "Source_name") as AnyObject
            let Source_id = jsonData?.value(forKey: "id") as AnyObject
            
            self.sourceNameArray = Source_name as! [String]
            let sourceIdArr = Source_id as! NSArray
//            let string1 = String(describing: sourceIdArr[0])
//            let string2 = String(describing: sourceIdArr[1])
//            self.sourceIdArray = [string1,string2]
            self.sourceIdArray =  sourceIdArr.map { ($0 as AnyObject).stringValue }
            
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
    
    func getfieldsalesAPI()
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
        
        let url = "/api/get-field-sales"
        
        FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
            alertView.close()
            
            self.view.layoutIfNeeded()
            
            let jsonData = userObject as? NSArray
            let EmployeeName = jsonData?.value(forKey: "EmployeeName") as AnyObject
            let Uid = jsonData?.value(forKey: "Uid") as AnyObject
            
            self.EmployeeNameArray = EmployeeName as! [String]
            let UIdArr = Uid as! NSArray
            //            let string1 = String(describing: sourceIdArr[0])
            //            let string2 = String(describing: sourceIdArr[1])
            //            self.sourceIdArray = [string1,string2]
            self.EmployeeIdArray =  UIdArr.map { ($0 as AnyObject).stringValue }
            
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
    
    func registrationSubmitAPI()
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
        let params: [String: AnyObject] = ["Address_1": "" as AnyObject,
                                           "Address_2": "" as AnyObject,
                                           "Address_3": "" as AnyObject,
                                           "AppSource": sourceId as AnyObject,
                                           "Bonds": bondsSelected as AnyObject,
                                           "Bonds_Comp": "" as AnyObject,
                                           "BrokID": 0 as AnyObject,
                                           "City": cityTf.text! as AnyObject,
                                           "CustID": 0 as AnyObject,
                                           "DOB": dobTf.text! as AnyObject,
                                           "DisplayDesignation": "" as AnyObject,
                                           "DisplayEmail": "" as AnyObject,
                                           "DisplayPhoneNo": "" as AnyObject,
                                           "EmailId": emailTf.text! as AnyObject,
                                           "FBAID": 0 as AnyObject,
                                           "FBALiveID": 0 as AnyObject,
                                           "FBAPan": "" as AnyObject,
                                           "FBAStat": ""as AnyObject,
                                           "FBA_Designation": "" as AnyObject,
                                           "FirstName": firstNameTf.text! as AnyObject,
                                           "GIC_Comp": "" as AnyObject,
                                           "GIC_Comp_ID": "" as AnyObject,
                                           "GSTNumb": "" as AnyObject,
                                           "Gender": Gender as AnyObject,
                                           "Health_Comp": "" as AnyObject,
                                           "Health_Comp_ID": "" as AnyObject,
                                           "IsFOC": "" as AnyObject,
                                           "IsGic": gernalinsuranceSelected as AnyObject,
                                           "IsHealth": healthinsuranceSelected as AnyObject,
                                           "IsLic": lifeinsuranceSelected as AnyObject,
                                           "LIC_Comp": "" as AnyObject,
                                           "LIC_Comp_ID": "" as AnyObject,
                                           "LastName": lastNameTf.text! as AnyObject,
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
                                           "MF": mutualFundSelected as AnyObject,
                                           "MF_Comp": "" as AnyObject,
                                           "Mobile_1": mob1Tf.text! as AnyObject,
                                           "Mobile_2": mob2Tf.text! as AnyObject,
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
                                           "ParentId": "0" as AnyObject,
                                           "PinCode": pincodeTf.text! as AnyObject,
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
                                           "Posp_Email": "" as AnyObject,
                                           "Posp_FirstName": "" as AnyObject,
                                           "Posp_Gender": "" as AnyObject,
                                           "Posp_IFSC": ""as AnyObject,
                                           "Posp_LastName": "" as AnyObject,
                                           "Posp_MICR": "" as AnyObject,
                                           "Posp_Mobile1": "" as AnyObject,
                                           "Posp_Mobile2": "" as AnyObject,
                                           "Posp_PAN": "" as AnyObject,
                                           "Posp_PinCode": "" as AnyObject,
                                           "Posp_ServiceTaxNo": "" as AnyObject,
                                           "Posp_StatID": "" as AnyObject,
                                           "Postal": postalSelected as AnyObject,
                                           "Postal_Comp": "" as AnyObject,
                                           "SMID": 0 as AnyObject,
                                           "SM_Name": "" as AnyObject,
                                           "StatActi": "" as AnyObject,
                                           "State": stateTf.text! as AnyObject,
                                           "StateID": "33" as AnyObject,
                                           "Stock": stocksSelected as AnyObject,
                                           "Stock_Comp": "" as AnyObject,
                                           "Type": "" as AnyObject,
                                           "VersionCode": "2.1.6" as AnyObject,
                                           "field_sales_uid": EmployeeId as AnyObject,
                                           "password": "09012019" as AnyObject,
                                           "referedby_code": referrCodeTf.text! as AnyObject]
        
        let url = "/api/insert-fba-registration"
        
        FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
            alertView.close()

            self.view.layoutIfNeeded()
            
            let jsonData = userObject as? NSDictionary
            let Message = jsonData?.value(forKey: "Message") as? String
            if(Message == "FBA registered successfully.")
            {
                let Login : LoginVC! = self.storyboard?.instantiateViewController(withIdentifier: "stbLoginVC") as? LoginVC
                self.present(Login, animated: true, completion: nil)
                TTGSnackbar.init(message: "FBA registered successfully.", duration: .long).show()
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
    
    //--<showalertView>--
    func alertCall(message:String)
    {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
   
    
}

