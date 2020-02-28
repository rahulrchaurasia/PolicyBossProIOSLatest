//
//  cmnloanselectCityVC.swift
//  MagicFinmart
//
//  Created by iOS Developer on 19/07/19.
//  Copyright © 2019 Ashwini. All rights reserved.
//

import UIKit
import CustomIOSAlertView
import TTGSnackbar

class cmnloanselectCityVC: UIViewController,UITextFieldDelegate,getPickerDataDelegate {
   
    @IBOutlet weak var cityviewTitleLbl: UILabel!
    @IBOutlet weak var otherCitiesTf: ACFloatingTextfield!
    var otherCitiesArray = [String]()
    var otherCitiesIdArray = [String]()
    var citiesIdArr = ""
    var titlLbl = ""
    var btnClicked = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        if(titlLbl == "PERSONAL LOAN")
        {
            cityviewTitleLbl.text! = "PERSONAL LOAN"
        }
        else if(titlLbl == "BUSINESS LOAN")
        {
            cityviewTitleLbl.text! = "BUSINESS LOAN"
        }
        else if(titlLbl == "HOME LOAN")
        {
            cityviewTitleLbl.text! = "HOME LOAN"
        }
        else if(titlLbl == "LAP LOAN")
        {
            cityviewTitleLbl.text! = "LAP LOAN"
        }
    }
    
    @IBAction func homeBtnCliked(_ sender: Any)
    {
        let KYDrawer : KYDrawerController = self.storyboard?.instantiateViewController(withIdentifier: "stbKYDrawerController") as! KYDrawerController
        present(KYDrawer, animated: true, completion: nil)

    }
    @IBAction func backBtnCliked(_ sender: Any)
    {
        let commonQuotes : commonQuotesVC = self.storyboard?.instantiateViewController(withIdentifier: "stbcommonQuotesVC") as! commonQuotesVC
        if(cityviewTitleLbl.text! == "PERSONAL LOAN")
        {
            commonQuotes.titleL = "PERSONAL LOAN"
            commonQuotes.loanType = "PSL"            
        }
        else if(cityviewTitleLbl.text! == "BUSINESS LOAN")
        {
            commonQuotes.titleL = "BUSINESS LOAN"
            commonQuotes.loanType = "BL"
        }
        else if(cityviewTitleLbl.text! == "HOME LOAN")
        {
            commonQuotes.titleL = "HOME LOAN"
            commonQuotes.loanType = "HML"
        }
        else if(cityviewTitleLbl.text! == "LAP LOAN")
        {
            commonQuotes.titleL = "LAP LOAN"
            commonQuotes.loanType = "LAP"
        }
        commonQuotes.fromScreen = "NO DATA"
        present(commonQuotes, animated:true, completion: nil)
    }
    
    //----------<ScrollView move up with Keyboard>---------
    func textFieldDidBeginEditing(_ textField: UITextField) {
        moveTextField(textfield: textField, moveDistance: -250, up: true)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        moveTextField(textfield: textField, moveDistance: -250, up: false)
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
    
    
    @IBAction func mumbaiCityCliked(_ sender: Any)
    {
        btnClicked = "Mumbai"
        gotoCityDetails()
    }
    @IBAction func delhiCityCliked(_ sender: Any)
    {
        btnClicked = "Delhi"
        gotoCityDetails()
    }
    @IBAction func bangaloreCityCliked(_ sender: Any)
    {
        btnClicked = "Bangalore"
        gotoCityDetails()
    }
    @IBAction func hyderabadCityCliked(_ sender: Any)
    {
        btnClicked = "Hyderabad"
        gotoCityDetails()
    }
    @IBAction func ahemadabadBtnCliked(_ sender: Any)
    {
        btnClicked = "Ahemadabad"
        gotoCityDetails()
    }
    @IBAction func kolkataCityCliked(_ sender: Any)
    {
        btnClicked = "Kolkata"
        gotoCityDetails()
    }
    @IBAction func chennaiCityCliked(_ sender: Any)
    {
        btnClicked = "Chennai"
        gotoCityDetails()
    }
    @IBAction func puneCItyCliked(_ sender: Any)
    {
        btnClicked = "Pune"
        gotoCityDetails()
    }
    @IBAction func jaipurBtnCliked(_ sender: Any)
    {
        btnClicked = "Jaipur"
        gotoCityDetails()
    }
    @IBAction func otherCitiesBtnCliked(_ sender: Any)
    {
        dsplyCityDtlsAPI()
        self.view.endEditing(true)
    }
    
    func getPickerDataValue(pickerSelectedData: String, fromScreen: String, pickerSelectedId: String)
    {
        switch fromScreen
        {
        case "cityList":
            self.otherCitiesTf.text = pickerSelectedData
            self.citiesIdArr = pickerSelectedId
            
            break
            
        default:
            break
        
        }
        
    }
    
    @IBAction func nextBtnCliked(_ sender: Any)
    {
        gotoCityDetails()
    }
    
    func gotoCityDetails()
    {
        let cmnloancityDetails : cmnloancityDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "stbcmnloancityDetailsVC") as! cmnloancityDetailsVC
        if(cityviewTitleLbl.text! == "PERSONAL LOAN")
        {
            cmnloancityDetails.titlLabel = "PERSONAL LOAN"
            cmnloancityDetails.productID = "9"
        }
        else if(cityviewTitleLbl.text! == "BUSINESS LOAN")
        {
            cmnloancityDetails.titlLabel = "BUSINESS LOAN"
            cmnloancityDetails.productID = "13"
        }
        else if(cityviewTitleLbl.text! == "HOME LOAN")
        {
            cmnloancityDetails.titlLabel = "HOME LOAN"
            cmnloancityDetails.productID = "12"
        }
        else if(cityviewTitleLbl.text! == "LAP LOAN")
        {
            cmnloancityDetails.titlLabel = "LAP LOAN"
            cmnloancityDetails.productID = "7"
        }
        if(btnClicked == "Mumbai"){
            cmnloancityDetails.citiesId = "677"

        }
        else if(btnClicked == "Delhi"){
            cmnloancityDetails.citiesId = "252"

        }
        else if(btnClicked == "Bangalore"){
            cmnloancityDetails.citiesId = "93"

        }
        else if(btnClicked == "Hyderabad"){
            cmnloancityDetails.citiesId = "404"

        }
        else if(btnClicked == "Ahemadabad"){
            cmnloancityDetails.citiesId = "9"

        }
        else if(btnClicked == "Kolkata"){
            cmnloancityDetails.citiesId = "550"

        }
        else if(btnClicked == "Chennai"){
            cmnloancityDetails.citiesId = "196"

        }
        else if(btnClicked == "Pune"){
            cmnloancityDetails.citiesId = "828"

        }
        else if(btnClicked == "Jaipur"){
            cmnloancityDetails.citiesId = "419"

        }
        else{
            cmnloancityDetails.citiesId = citiesIdArr
        }
        self.present(cmnloancityDetails, animated: true, completion: nil)
    }
    
    //--<APICALL>--
    func dsplyCityDtlsAPI()
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
        
        let url = "/LoginDtls.svc/XMLService/dsplyCityDtls"
        
        FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
            alertView.close()
            
            self.view.layoutIfNeeded()
            
            let jsonData = userObject as? NSDictionary
            let lstCity = jsonData?.value(forKey: "lstCity") as! NSArray
            let cityName = lstCity.value(forKey: "cityName") as AnyObject
            let cityId = lstCity.value(forKey: "cityId") as AnyObject
            self.otherCitiesArray = cityName as! [String]
            let cityIdArr = cityId as! [Int]
            self.otherCitiesIdArray = cityIdArr.map { String($0) }
     
            let Picker : PickerViewVC! = self.storyboard?.instantiateViewController(withIdentifier: "stbPickerViewVC") as? PickerViewVC
            Picker.fromScreen = "cityList"
            Picker.pickerData = ["Select"]+self.otherCitiesArray
            Picker.pickerIdData = [""]+self.otherCitiesIdArray
            self.addChild(Picker)
            self.view.addSubview(Picker.view)
            Picker.pickerdelegate = self
            
        }, onError: { errorData in
            alertView.close()
            let snackbar = TTGSnackbar.init(message: errorData.errorMessage, duration: .long)
            snackbar.show()
        }, onForceUpgrade: {errorData in},checkLead: true)
        
    }
    
    
    
    
}
