//
//  motorInsuranceVC.swift
//  MagicFinmart
//
//  Created by Ashwini on 27/12/18.
//  Copyright © 2018 Ashwini. All rights reserved.
//

import UIKit
import TTGSnackbar
import CustomIOSAlertView

class motorInsuranceVC: UIViewController,SelectedDateDelegate,UITableViewDelegate,UITableViewDataSource,mcellBtnDelegate {
    
    @IBOutlet var carmobNumberView: UIView!
    @IBOutlet var carDetailsView: UIView!
    @IBOutlet var carDetailsViewHeight: NSLayoutConstraint!//322
    @IBOutlet var mobNoDetailsTV: UITableView!
    @IBOutlet var mobNoDetailsTVHeight: NSLayoutConstraint!//365
    @IBOutlet var regNoLblName: UILabel!
    @IBOutlet var regNoLbl: UILabel!
    @IBOutlet var vehiNoLblName: UILabel!
    @IBOutlet var vehiNoLbl: UILabel!
    @IBOutlet var nameTf: ACFloatingTextfield!
    @IBOutlet var mobNoTf: ACFloatingTextfield!
    @IBOutlet var expiDateTf: ACFloatingTextfield!
    @IBOutlet var carNumImgV: UIImageView!
    @IBOutlet var mobNumImgV: UIImageView!
    @IBOutlet var carNumBtn: UIButton!
    @IBOutlet var mobNumBtn: UIButton!
    @IBOutlet var goTf: ACFloatingTextfield!
    
    var selectNumber = ""
    var expDate = ""
    var indexID = Int()
    var categoryArray = [String]()
    var VehicleRegNumberArray = [String]()
    var NameArray = [String]()
    var MobileNoArray = [String]()
    var ExpiryDateArray = [String]()
    
    var mRegNnCategory = ""
    var mvehiRegnInfo = ""
    var mname = ""
    var mmobNo = ""
    var mexpdate = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewColorGray(view:carmobNumberView)
        viewColorGray(view:carDetailsView)
        
        carDetailsView.isHidden = true
        carDetailsViewHeight.constant = 0
        mobNoDetailsTV.isHidden = true
        mobNoDetailsTVHeight.constant = 0
        self.selectNumber = "CAR"
        
    }
    
    @IBAction func backBtnCliked(_ sender: Any)
    {
        let KYDrawer : KYDrawerController = self.storyboard?.instantiateViewController(withIdentifier: "stbKYDrawerController") as! KYDrawerController
        KYDrawer.modalPresentationStyle = .fullScreen
        present(KYDrawer, animated: true, completion: nil)
    }
    
    @IBAction func carNumberBtnCliked(_ sender: Any)
    {
        carNumImgV.image = UIImage(named: "icons8-unchecked-radio-button-24 (1).png")
        mobNumImgV.image = UIImage(named: "icons8-round-24.png")
        self.selectNumber = "CAR"
        carDetailsView.isHidden = true
        carDetailsViewHeight.constant = 0
        mobNoDetailsTV.isHidden = true
        mobNoDetailsTVHeight.constant = 0
        self.goTf.text! = ""
    }
    
    @IBAction func mobNumberBtnCliked(_ sender: Any)
    {
        mobNumImgV.image = UIImage(named: "icons8-unchecked-radio-button-24 (1).png")
        carNumImgV.image = UIImage(named: "icons8-round-24.png")
        self.selectNumber = "MOBILE"
        carDetailsView.isHidden = true
        carDetailsViewHeight.constant = 0
        mobNoDetailsTV.isHidden = true
        mobNoDetailsTVHeight.constant = 0
        self.goTf.text! = ""
    }
    
    @IBAction func goBtnCliked(_ sender: Any)
    {
        if(goTf.text! != "")
        {
            if(self.selectNumber == "CAR"){
                regNoLblName.text! = "REG. NO"
                vehiNoLblName.text! = "VEH. INFO"
                vehicleinfoAPI()
            }else{
                regNoLblName.text! = "CATEGORY"
                vehiNoLblName.text! = "VEHICLE REG."
                getdatafrommobNumber()
            }
        }
        else{
            TTGSnackbar.init(message: "Please enter Car Number or Mobile Number", duration: .long).show()
        }
        
    }
    
    
    @IBAction func expDateBtnCliked(_ sender: Any)
    {
        self.view.endEditing(true)
        let DatePicker : DatePickerVC = storyboard?.instantiateViewController(withIdentifier: "stbDatePickerVC") as! DatePickerVC
        self.addChild(DatePicker)
        self.view.addSubview(DatePicker.view)
        DatePicker.dateDelegate = self
//        self.expDate = "car"
    }
    
    
    @IBAction func generateLeadBtnCliked(_ sender: Any)
    {
        mRegNnCategory = regNoLbl.text!
        mvehiRegnInfo = vehiNoLbl.text!
        mname = nameTf.text!
        mmobNo = mobNoTf.text!
        mexpdate = expiDateTf.text!
        
        savemoterleaddetailsAPI()
    }
    
    
    //--<tableBtn>--
    func dateBtnTapped(cell: motorinsuranceTVCell) {
        print("Date")
        //Get the indexpath of cell where button was tapped
        let indexPath = self.mobNoDetailsTV.indexPath(for: cell)
        indexID = indexPath!.row
//        if(indexPath!.row == 0)
//        {
//            cell.expdateLblTf.text! = ""
//            cell.expdateLblTf.isEnabled = true
//        }
//        else if(indexPath!.row == 1)
//        {
//            cell.expdateLblTf.text! = ""
//            cell.expdateLblTf.isEnabled = true
//        }
//        self.view.endEditing(true)
//        let DatePicker : DatePickerVC = storyboard?.instantiateViewController(withIdentifier: "stbDatePickerVC") as! DatePickerVC
//        self.addChild(DatePicker)
//        self.view.addSubview(DatePicker.view)
//        DatePicker.dateDelegate = self
//        self.expDate = "mobile"
        
    }
    
    func generateBtnTapped(cell: motorinsuranceTVCell) {
//        let cell = self.mobNoDetailsTV.dequeueReusableCell(withIdentifier: "cell") as! motorinsuranceTVCell
        print("Generate")
//        let indexPath = self.mobNoDetailsTV.indexPath(for: cell)
//        print("indexPath!.row",indexPath!.row)
//        indexID = indexPath!.row
//        if(indexPath!.row == 0)
//        {
//            mRegNnCategory = cell.categoryLbl.text!
//            mvehiRegnInfo = cell.vehicleregLbl.text!
//            mname = cell.nameTf.text!
//            mmobNo = cell.mobNoTf.text!
//            mexpdate = cell.expdateLblTf.text!
//        }
//        else if(indexPath!.row == 1)
//        {
//            mRegNnCategory = cell.categoryLbl.text!
//            mvehiRegnInfo = cell.vehicleregLbl.text!
//            mname = cell.nameTf.text!
//            mmobNo = cell.mobNoTf.text!
//            mexpdate = cell.expdateLblTf.text!
//        }
//        savemoterleaddetailsAPI()
    }
    
    
    func getDateData(currDate: String, fromScreen: String) {
        print(currDate)
//        let cell = self.mobNoDetailsTV.dequeueReusableCell(withIdentifier: "cell") as! motorinsuranceTVCell
//
        expiDateTf.text = currDate
        expiDateTf.textColor = UIColor.black
        
//        cell.expdateLblTf.text! = ""
//
//        if(indexID == 0){
////            self.expDate = currDate
//            cell.expdateLblTf.text! = currDate
//            print("cell.expdateLblTf.text!",cell.expdateLblTf.text!)
//        }
//        else if(indexID == 1){
////            self.expDate = currDate
//            cell.expdateLblTf.text! = currDate
//            print("cell.expdateLblTf.text!",cell.expdateLblTf.text!)
//        }
        
        
    }
    
    func getintData(indata: Int) {
        
    }
    
    
    //---<tableView Datasource+Delegates>---
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! motorinsuranceTVCell
        
        viewColorGray(view:cell.cellView)
        
        cell.categoryLbl.text! = categoryArray[indexPath.row]
        cell.vehicleregLbl.text! = VehicleRegNumberArray[indexPath.row]
        cell.nameTf.text! = NameArray[indexPath.row]
        cell.mobNoTf.text! = MobileNoArray[indexPath.row]
        cell.expdateLblTf.text! = ExpiryDateArray[indexPath.row]
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(motorInsuranceVC.tapFunction))
        cell.expdateLblTf.isUserInteractionEnabled = true
        cell.expdateLblTf.addGestureRecognizer(tap)
        
        //--<cellBtn Delegate>--
        cell.delegate = self
        
        return cell
        
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 330
    }
    
    //---<end tableView Datasource+Delegates>---
    
    @objc func tapFunction(sender:UITapGestureRecognizer)
    {
        print("tap working")
        
//        self.view.endEditing(true)
//        let DatePicker : DatePickerVC = storyboard?.instantiateViewController(withIdentifier: "stbDatePickerVC") as! DatePickerVC
//        self.addChild(DatePicker)
//        self.view.addSubview(DatePicker.view)
//        DatePicker.dateDelegate = self
        
    }
   
    
    //--<APICALL>--
    func getdatafrommobNumber()
    {
        
        let url = URL(string: "http://inspection.policyboss.com/api/generic-info?m=9375166823")
        URLSession.shared.dataTask(with:url!, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else { return }
            print(String(data: data, encoding: .utf8)!)
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
                let CustomerDetails = json["CustomerDetails"] as? [[String: Any]] ?? []
                
                for i in 0..<CustomerDetails.count {
                    
                    let dict = CustomerDetails[i]
                    let Category = (dict as AnyObject).value(forKey: "Category") as AnyObject
                    self.categoryArray.append(Category as! String)
                    let VehicleRegNumber = (dict as AnyObject).value(forKey: "VehicleRegNumber") as AnyObject
                    self.VehicleRegNumberArray.append(VehicleRegNumber as! String)
                    let Name = (dict as AnyObject).value(forKey: "Name") as AnyObject
                    self.NameArray.append(Name as! String)
                    let MobileNo = (dict as AnyObject).value(forKey: "MobileNo") as AnyObject
                    self.MobileNoArray.append(MobileNo as! String)
                    let ExpiryDate = (dict as AnyObject).value(forKey: "ExpiryDate") as AnyObject
                    self.ExpiryDateArray.append(ExpiryDate as! String)
                   
                }
                
                DispatchQueue.main.async {
                    self.carDetailsView.isHidden = true
                    self.carDetailsViewHeight.constant = 0
                    self.mobNoDetailsTV.isHidden = false
                    self.mobNoDetailsTVHeight.constant = 365
                    
                    self.mobNoDetailsTV.reloadData()
                }
                
               
            } catch let error as NSError {
                print(error)
            }
        }).resume()
        
    }
    
    
    func vehicleinfoAPI()
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
        
        let params: [String: AnyObject] = ["RegistrationNumber": goTf.text! as AnyObject]
        
        let url = "vehicle-info"
        
        FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
            alertView.close()
            
            self.view.layoutIfNeeded()
            
            let jsonData = userObject as? NSDictionary
            let Registration_Number = jsonData!.value(forKey: "Registration_Number") as AnyObject
            let Make_Name = jsonData!.value(forKey: "Make_Name") as AnyObject
            let Model_Name = jsonData!.value(forKey: "Model_Name") as AnyObject
            let Variant_Name = jsonData!.value(forKey: "Variant_Name") as AnyObject
            
            self.regNoLbl.text! = Registration_Number as! String
            
            let vehiinfoString = (Make_Name as! String) + "," + (Model_Name as! String) + "," + (Variant_Name as! String)
            
            self.vehiNoLbl.text! = vehiinfoString
            
            self.carDetailsView.isHidden = false
            self.carDetailsViewHeight.constant = 322
            self.mobNoDetailsTV.isHidden = true
            self.mobNoDetailsTVHeight.constant = 0
            
            
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
    
    func savemoterleaddetailsAPI()
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
        
        let params: [String: AnyObject] = ["Category": mRegNnCategory as AnyObject,
                                           "ChasisNo":"" as AnyObject,
                                           "City":"" as AnyObject,
                                           "ClaimNo":"" as AnyObject,
                                           "ClaimSattlementType":"" as AnyObject,
                                           "ClaimStatus":"NA" as AnyObject,
                                           "ClientName":"" as AnyObject,
                                           "DOB":"NA" as AnyObject,
                                           "Email":"null" as AnyObject,
                                           "EngineNo":"" as AnyObject,
                                           "ExpiryDate": mexpdate as AnyObject,
                                           "FBAID":FBAId as AnyObject,
                                           "FuelType":"" as AnyObject,
                                           "Gender":"" as AnyObject,
                                           "HolderPincode":"" as AnyObject,
                                           "InceptionDate":"" as AnyObject,
                                           "InsuranceID":"NA" as AnyObject,
                                           "InsuranceName":"NA" as AnyObject,
                                           "IsCustomer":"" as AnyObject,
                                           "Make":"" as AnyObject,
                                           "Mfgyear":"" as AnyObject,
                                           "MobileNo": mmobNo as AnyObject,
                                           "Name": mname as AnyObject,
                                           "NoClaimBonus":"" as AnyObject,
                                           "POSPCode":"" as AnyObject,
                                           "POSPName":"" as AnyObject,
                                           "Pincode":"NA" as AnyObject,
                                           "PolicyNumber":"NA" as AnyObject,
                                           "Premium":"NA" as AnyObject,
                                           "QT_Entry_Number":"NA" as AnyObject,
                                           "RTOCity":"" as AnyObject,
                                           "RTOState":"" as AnyObject,
                                           "RegistrationDate":"" as AnyObject,
                                           "RegistrationNo": mRegNnCategory as AnyObject,
                                           "SubModel":"" as AnyObject,
                                           "VehicleRegNumber":"" as AnyObject,
                                           "holderaddress":"" as AnyObject,
                                           "model":"" as AnyObject]
             
        
        let url = "save-moter-lead-details"
        
        FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
            alertView.close()
            
            self.view.layoutIfNeeded()
            
            let jsonData = userObject as? NSArray

            TTGSnackbar.init(message: "Saved successfully!", duration: .long).show()
            
            
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
    

    //--<colorChange>--
    func viewColorGray(view:UIView)
    {
        let borderColr = UIColor.lightGray
        view.layer.cornerRadius=2.0;
        view.layer.borderWidth=0.5;
        view.layer.borderColor=borderColr.cgColor;
        //        Btn.setTitleColor(UIColor.gray, for: .normal)
    }
    
    
}
