//
//  MotorInsuranceVC.swift
//  MagicFinmart
//
//  Created by Ashwini on 11/01/19.
//  Copyright © 2019 Ashwini. All rights reserved.
//

import UIKit
import CustomIOSAlertView
import TTGSnackbar

class MotorInsuranceVCS: UIViewController,CAPSPageMenuDelegate {

    var CAPSMenu : CAPSPageMenu?
    var startIndex = 1
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var motorinsuranceView: UIView!
    
    //privateCar
    var qtfrstNameArray = [String]()
    var qtlstNameArray = [String]()
    var qtvehicleIdArray = [String]()
    var intqtvehicleIdArray = [Int]()
    var qtcrnArray = [String]()
    var qtquoteDateArray = [String]()
    var intvehicleRequestIDArray = [Int]()
    var qtvehicleRequestIDArray = [String]()
    
    var applfrstNameArray = [String]()
    var appllstNameArray = [String]()
    var applcrnArray = [String]()
    var applquoteDateArray = [String]()
    var applregistNoArray = [String]()
    var applappstatusArray = [String]()
    var intapplappstatusArray = [Int]()
    var applappstatusperArray = [String]()
    var applImgArray = [String]()
    
    //twoWheeler
    var twqtfrstNameArray = [String]()
    var twqtlstNameArray = [String]()
    var twqtvehicleIdArray = [String]()
    var twintqtvehicleIdArray = [Int]()
    var twqtcrnArray = [String]()
    var twqtquoteDateArray = [String]()
    var twintvehicleRequestIDArray = [Int]()
    var twqtvehicleRequestIDArray = [String]()
    
    var twapplfrstNameArray = [String]()
    var twappllstNameArray = [String]()
    var twapplcrnArray = [String]()
    var twapplquoteDateArray = [String]()
    var twapplregistNoArray = [String]()
    var twapplappstatusArray = [String]()
    var twintapplappstatusArray = [Int]()
    var twapplappstatusperArray = [String]()
    var twapplImgArray = [String]()
    
    //lifeInsurance
    var lffrstNameArray = [String]()
    var lfcrnArray = [String]()
    var lfquoteDateArray = [String]()
    
    var lfapplfrstNameArray = [String]()
    var lfapplquoteDateArray = [String]()
    var lfasumArray = [String]()
    var lfamodeArray = [String]()
    var lfastatusArray = [String]()
    var lfastatusDateArray = [String]()
    var lfaappNoArray = [String]()
    var lfapremiumppArray = [String]()
    var lfatermpptArray = [String]()
    //
    var policyTermArray = [String]()
    var insuredGenderArray = [String]()
    var is_TabaccoUserArray = [String]()
    var sumAssuredArray = [String]()
    var insuredDOBArray = [String]()
    var pPTArray = [String]()
    var contactNameArray = [String]()
    var pincodeArray = [String]()
    var contactMobileArray = [String]()
    
    var fromScreen = ""
    var InsurerID = ""
    var contactMob = ""
    var contctName = ""
    var dobtxt = ""
    var smkrtxt = ""
    var gndrtxt = ""
    var pincdetxt = ""
    var sumasstxt = ""
    var policytrmtxt = ""
    var pretrmtxt = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //--<reloadCapsMenu and data according to fromscreen>--
        callfromScreens()
    
        //--<apiCall>--
        if(fromScreen == "twoWheeler")
        {
            gettwoWhlrvehiclerequestAPI()
        }
        else if(fromScreen == "private")
        {
            getvehiclerequestAPI()
        }
        else if(fromScreen == "compareTerm" || fromScreen == "hdfcLife" || fromScreen == "iciciPruden")
        {
            getsmarttermlifeAPI()
        }
        
    }
   
    
    //-------<capsMenu>--------
    func maincapsMenu()
    {
        var controllerArray : [UIViewController] = []
        let storyboardName: String = "Main"
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
    
        if(fromScreen == "private" || fromScreen == "twoWheeler"){
            let controller1: cmnQuotesVC = storyboard.instantiateViewController(withIdentifier: "stbcmnQuotesVC") as! cmnQuotesVC
            controller1.title = "QUOTE"
            let controller2: cmnApplicationsVC = storyboard.instantiateViewController(withIdentifier: "stbcmnApplicationsVC") as! cmnApplicationsVC
            controller2.title = "APPLICATION"
            
            if(fromScreen == "twoWheeler")
            {
                controller1.fromScreen = "gettwowhlrInput"
                
                controller1.frstNameArr = twqtfrstNameArray
                controller1.lastNameArr = twqtlstNameArray
                controller1.crnArr = twqtcrnArray
                controller1.qdateArr = twqtquoteDateArray
                controller1.vehicleIdArr = twqtvehicleIdArray
                controller1.qVehicleRequestIDArr = twqtvehicleRequestIDArray
                
                controller2.frstNameArray = twapplfrstNameArray
                controller2.lstNameArray = twappllstNameArray
                controller2.crnArray = twapplcrnArray
                controller2.quoteDateArray = twapplquoteDateArray
                controller2.registNoArray = twapplregistNoArray
                controller2.appstatusperArray = twapplappstatusArray
                controller2.imagesArray = twapplImgArray
            }
            else if(fromScreen == "private")
            {
                controller1.fromScreen = "getprivateInput"
                controller1.frstNameArr = qtfrstNameArray
                controller1.lastNameArr = qtlstNameArray
                controller1.crnArr = qtcrnArray
                controller1.qdateArr = qtquoteDateArray
                controller1.vehicleIdArr = qtvehicleIdArray
                controller1.qVehicleRequestIDArr = qtvehicleRequestIDArray
                
                controller2.frstNameArray = applfrstNameArray
                controller2.lstNameArray = appllstNameArray
                controller2.crnArray = applcrnArray
                controller2.quoteDateArray = applquoteDateArray
                controller2.registNoArray = applregistNoArray
                controller2.appstatusperArray = applappstatusArray
                controller2.imagesArray = applImgArray
            }
            
            controllerArray = [controller1, controller2]
            
        }
        else if(fromScreen == "homeLoan" || fromScreen == "personalLoan" || fromScreen == "lap")
        {
            let controller1: commonQuotesVC = storyboard.instantiateViewController(withIdentifier: "stbcommonQuotesVC") as! commonQuotesVC
            controller1.title = "QUOTE"
            if(fromScreen == "personalLoan")
            {
                controller1.fromScreen = "getpersonalLoanInput"
                
            }else if(fromScreen == "lap")
            {
                controller1.fromScreen = "getlapInput"
                
            }else if(fromScreen == "homeLoan")
            {
                controller1.fromScreen = "gethomeLoanInput"
            }
            
//            controller1.frstNameArr = qtfrstNameArray
//            controller1.lastNameArr = qtlstNameArray
//            controller1.crnArr = qtcrnArray
//            controller1.qdateArr = qtquoteDateArray
//            controller1.vehicleIdArr = qtvehicleIdArray
//            controller1.qVehicleRequestIDArr = qtvehicleRequestIDArray
            
            let controller2: commonApplicatnVC = storyboard.instantiateViewController(withIdentifier: "stbcommonApplicatnVC") as! commonApplicatnVC
            controller2.title = "APPLICATION"
//            controller2.frstNameArray = applfrstNameArray
//            controller2.lstNameArray = appllstNameArray
//            controller2.crnArray = applcrnArray
//            controller2.quoteDateArray = applquoteDateArray
//            controller2.registNoArray = applregistNoArray
//            controller2.appstatusperArray = applappstatusArray
//            controller2.imagesArray = applImgArray
            
            controllerArray = [controller1, controller2]
        }
        else if(fromScreen == "compareTerm" || fromScreen == "hdfcLife" || fromScreen == "iciciPruden")
        {
            let controller1: cmnQuotesLifeinsVC = storyboard.instantiateViewController(withIdentifier: "stbcmnQuotesLifeinsVC") as! cmnQuotesLifeinsVC
            controller1.title = "QUOTE"
            if(fromScreen == "compareTerm"){
                controller1.fromScreen = "comparetermInput"
            }
            else if(fromScreen == "hdfcLife"){
                controller1.fromScreen = "hdfcLifeInput"
            }
            else if(fromScreen == "iciciPruden"){
                controller1.fromScreen = "iciciPrudenInput"
            }
            controller1.frstNameArray = lffrstNameArray
            controller1.crnArray = lfcrnArray
            controller1.quoteDateArray = lfquoteDateArray
            controller1.contactMobArray = contactMobileArray
            controller1.insdobArray = insuredDOBArray
            controller1.inspolicyTermArr = policyTermArray
            controller1.insuredGenderArr = insuredGenderArray
            controller1.is_TabaccoUserArr = is_TabaccoUserArray
            controller1.sumAssuredArr = sumAssuredArray
            controller1.inspolicyTermArr = policyTermArray
            controller1.pPTArr = pPTArray
            controller1.pincodeArr = pincodeArray
            
            let controller2: cmnApplictnLifeinsVC = storyboard.instantiateViewController(withIdentifier: "stbcmnApplictnLifeinsVC") as! cmnApplictnLifeinsVC
            controller2.title = "APPLICATION"
            controller2.afrstNameArray = lfapplfrstNameArray
            controller2.aquoteDateArray = lfapplquoteDateArray
            controller2.asumArray = lfasumArray
            controller2.amodeArray = lfamodeArray
            controller2.astatusArray = lfastatusArray
            controller2.astatusDateArray = lfastatusDateArray
            controller2.aappNoArray = lfaappNoArray
            controller2.apremiumppArray = lfapremiumppArray
            controller2.atermpptArray = lfatermpptArray
            
            controllerArray = [controller1, controller2]
        }
        
        let parameters : [CAPSPageMenuOption] = [
            
            .scrollMenuBackgroundColor(UIColor(red: CGFloat(0.00 / 255.0), green: CGFloat(51.0 / 255.0), blue: CGFloat(91.0 / 255.0), alpha: CGFloat(1))),
            .viewBackgroundColor(UIColor(red: CGFloat(31.00 / 255.0), green: CGFloat(74.0 / 255.0), blue: CGFloat(132.0 / 255.0), alpha: CGFloat(1))),
            .selectionIndicatorColor(UIColor.white),
            
            .addBottomMenuHairline(true),
            .centerMenuItems(true),
            .bottomMenuHairlineColor(UIColor.white),
            .menuItemFont(UIFont.init(name: "HelveticaNeue", size: 15)!),
            .menuHeight(50.0),
            .menuItemWidth(0),
            .selectedMenuItemLabelColor(UIColor.white),
            .unselectedMenuItemLabelColor(UIColor.white),
            .selectionIndicatorHeight(4),
            .useMenuLikeSegmentedControl(true),
            .menuItemWidthBasedOnTitleTextWidth(false),
            .hideTopMenuBar(false)
        ]
        
        self.CAPSMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0.0, y: 0.0, width: self.motorinsuranceView.frame.size.width, height: self.motorinsuranceView.frame.size.height), pageMenuOptions: parameters)
        
        self.motorinsuranceView.addSubview((self.CAPSMenu?.view)!)
        
    }
    
    
    
    
    func capsMenu()
    {
        var controllerArray : [UIViewController] = []
        let storyboardName: String = "Main"
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        if(fromScreen == "hLoan" || fromScreen == "pLoan" || fromScreen == "lp")
        {
            let controller1: homeLinputPageVC = storyboard.instantiateViewController(withIdentifier: "stbhomeLinputPageVC") as! homeLinputPageVC
            controller1.title = "INPUT"
            
            let controller2: homeLinputPageVC = storyboard.instantiateViewController(withIdentifier: "stbhomeLinputPageVC") as! homeLinputPageVC
            controller2.title = "QUOTE"
            
            let controller3: homeLinputPageVC = storyboard.instantiateViewController(withIdentifier: "stbhomeLinputPageVC") as! homeLinputPageVC
            controller3.title = "APPLY"
            
            controllerArray = [controller1, controller2, controller3]
        }
        else if(self.fromScreen == "compare" || self.fromScreen == "fromcompgetQuote")
        {
            let controller1: lyfinsInputPageVC = storyboard.instantiateViewController(withIdentifier: "stblyfinsInputPageVC") as! lyfinsInputPageVC
            controller1.title = "INPUT"
            controller1.cntctMob = contactMob
            controller1.contctNm = contctName
            controller1.insdob = dobtxt
            controller1.smkr = smkrtxt
            controller1.gendr = gndrtxt
            controller1.pincde = pincdetxt
            controller1.sumassurd = sumasstxt
            controller1.plcytrm = policytrmtxt
            controller1.pretrm = pretrmtxt
            
            if(self.fromScreen == "compare"){
                controller1.fromScreen = "compInput"
                controller1.InsurerID = "0"
            }
            else if(self.fromScreen == "hdfc"){
                controller1.fromScreen = "hdfcInput"
                controller1.InsurerID = "28"
            }
            else if(self.fromScreen == "icici"){
                controller1.fromScreen = "iciciInput"
                controller1.InsurerID = "39"
            }
            
            let controller2: lyfinsQuotePageVC = storyboard.instantiateViewController(withIdentifier: "stblyfinsQuotePageVC") as! lyfinsQuotePageVC
            controller2.title = "QUOTE"
            if(self.fromScreen == "compare" || self.fromScreen == "fromcompgetQuote"){
                controller2.fromScreen = "compQuote"
                controller2.InsurerID = "0"
            }
            else if(self.fromScreen == "hdfc" || self.fromScreen == "fromhdfcgetQuote"){
                controller2.fromScreen = "hdfcQuote"
                controller2.InsurerID = "28"
            }
            else if(self.fromScreen == "icici" || self.fromScreen == "fromicicigetQuote"){
                controller2.fromScreen = "iciciQuote"
                controller2.InsurerID = "39"
            }
            
            let controller3: lyfinsApplyPageVC = storyboard.instantiateViewController(withIdentifier: "stblyfinsApplyPageVC") as! lyfinsApplyPageVC
            controller3.title = "APPLY"
            
            controllerArray = [controller1, controller2, controller3]
        }
        else if(fromScreen == "hdfc" || self.fromScreen == "fromhdfcgetQuote")
        {
            let controller1: lyfinshdfcInputPageVC = storyboard.instantiateViewController(withIdentifier: "stblyfinshdfcInputPageVC") as! lyfinshdfcInputPageVC
            controller1.title = "INPUT"
            controller1.cntctMob = contactMob
            controller1.contctNm = contctName
            controller1.insdob = dobtxt
            controller1.smkr = smkrtxt
            controller1.gendr = gndrtxt
            controller1.pincde = pincdetxt
            controller1.sumassurd = sumasstxt
            controller1.plcytrm = policytrmtxt
            controller1.pretrm = pretrmtxt
            if(self.fromScreen == "compare"){
                controller1.fromScreen = "compInput"
//                controller1.InsurerID = "0"
            }
            else if(self.fromScreen == "hdfc"){
                controller1.fromScreen = "hdfcInput"
//                controller1.InsurerID = "28"
            }
            else if(self.fromScreen == "icici"){
                controller1.fromScreen = "iciciInput"
//                controller1.InsurerID = "39"
            }
            
            let controller2: lyfinsQuotePageVC = storyboard.instantiateViewController(withIdentifier: "stblyfinsQuotePageVC") as! lyfinsQuotePageVC
            controller2.title = "QUOTE"
            if(self.fromScreen == "compare" || self.fromScreen == "fromcompgetQuote"){
                controller2.fromScreen = "compQuote"
                controller2.InsurerID = "0"
            }
            else if(self.fromScreen == "hdfc" || self.fromScreen == "fromhdfcgetQuote"){
                controller2.fromScreen = "hdfcQuote"
                controller2.InsurerID = "28"
            }
            else if(self.fromScreen == "icici" || self.fromScreen == "fromicicigetQuote"){
                controller2.fromScreen = "iciciQuote"
                controller2.InsurerID = "39"
            }
            
            let controller3: lyfinsApplyPageVC = storyboard.instantiateViewController(withIdentifier: "stblyfinsApplyPageVC") as! lyfinsApplyPageVC
            controller3.title = "APPLY"
            
            controllerArray = [controller1, controller2, controller3]
        }
        else if(self.fromScreen == "icici" || self.fromScreen == "fromicicigetQuote")
        {
            let controller1: lyfinsiciciInputPageVC = storyboard.instantiateViewController(withIdentifier: "stblyfinsiciciInputPageVC") as! lyfinsiciciInputPageVC
            controller1.title = "INPUT"
            controller1.cntctMob = contactMob
            controller1.contctNm = contctName
            controller1.insdob = dobtxt
            controller1.smkr = smkrtxt
            controller1.gendr = gndrtxt
            controller1.pincde = pincdetxt
            controller1.sumassurd = sumasstxt
            controller1.plcytrm = policytrmtxt
            controller1.pretrm = pretrmtxt
            if(self.fromScreen == "compare"){
                controller1.fromScreen = "compInput"
//                controller1.InsurerID = "0"
            }
            else if(self.fromScreen == "hdfc"){
                controller1.fromScreen = "hdfcInput"
//                controller1.InsurerID = "28"
            }
            else if(self.fromScreen == "icici"){
                controller1.fromScreen = "iciciInput"
//                controller1.InsurerID = "39"
            }
            
            let controller2: lyfinsQuotePageVC = storyboard.instantiateViewController(withIdentifier: "stblyfinsQuotePageVC") as! lyfinsQuotePageVC
            controller2.title = "QUOTE"
            if(self.fromScreen == "compare" || self.fromScreen == "fromcompgetQuote"){
                controller2.fromScreen = "compQuote"
                controller2.InsurerID = "0"
            }
            else if(self.fromScreen == "hdfc" || self.fromScreen == "fromhdfcgetQuote"){
                controller2.fromScreen = "hdfcQuote"
                controller2.InsurerID = "28"
            }
            else if(self.fromScreen == "icici" || self.fromScreen == "fromicicigetQuote"){
                controller2.fromScreen = "iciciQuote"
                controller2.InsurerID = "39"
            }
            
            let controller3: lyfinsApplyPageVC = storyboard.instantiateViewController(withIdentifier: "stblyfinsApplyPageVC") as! lyfinsApplyPageVC
            controller3.title = "APPLY"
            
            controllerArray = [controller1, controller2, controller3]
        }
        else{
            let controller1: motorInsurancecapsVC = storyboard.instantiateViewController(withIdentifier: "stbmotorInsurancecapsVC") as! motorInsurancecapsVC
            controller1.title = "INPUT"
            
            let controller2: motorInsurance2capsVC = storyboard.instantiateViewController(withIdentifier: "stbmotorInsurance2capsVC") as! motorInsurance2capsVC
            controller2.title = "QUOTE"
            
            let controller3: motorInsurance3capsVC = storyboard.instantiateViewController(withIdentifier: "stbmotorInsurance3capsVC") as! motorInsurance3capsVC
            controller3.title = "APPLY"
            
            controllerArray = [controller1, controller2, controller3]
        }
        
        let parameters : [CAPSPageMenuOption] = [
            
            .scrollMenuBackgroundColor(UIColor(red: CGFloat(0.00 / 255.0), green: CGFloat(51.0 / 255.0), blue: CGFloat(91.0 / 255.0), alpha: CGFloat(1))),
            .viewBackgroundColor(UIColor(red: CGFloat(31.00 / 255.0), green: CGFloat(74.0 / 255.0), blue: CGFloat(132.0 / 255.0), alpha: CGFloat(1))),
            .selectionIndicatorColor(UIColor.white),
            
            .addBottomMenuHairline(true),
            .centerMenuItems(true),
            .bottomMenuHairlineColor(UIColor.white),
            .menuItemFont(UIFont.init(name: "HelveticaNeue", size: 15)!),
            .menuHeight(50.0),
            .menuItemWidth(0),
            .selectedMenuItemLabelColor(UIColor.white),
            .unselectedMenuItemLabelColor(UIColor.white),
            .selectionIndicatorHeight(4),
            .useMenuLikeSegmentedControl(true),
            .menuItemWidthBasedOnTitleTextWidth(false),
            .hideTopMenuBar(false)
        ]
        
        
        self.CAPSMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0.0, y: 0.0, width: self.motorinsuranceView.frame.size.width, height: self.motorinsuranceView.frame.size.height), pageMenuOptions: parameters)
        
        if(self.fromScreen == "fromcompgetQuote")
        {
            // Optional delegate
            self.CAPSMenu!.delegate = self
            self.CAPSMenu!.setStartIndexToPage(index: startIndex)
        }
        else if(self.fromScreen == "fromhdfcgetQuote")
        {
            // Optional delegate
            self.CAPSMenu!.delegate = self
            self.CAPSMenu!.setStartIndexToPage(index: startIndex)
        }
        else if(self.fromScreen == "fromicicigetQuote")
        {
            // Optional delegate
            self.CAPSMenu!.delegate = self
            self.CAPSMenu!.setStartIndexToPage(index: startIndex)
        }
        if(self.fromScreen == "compare")
        {
            // Optional delegate
            self.CAPSMenu!.delegate = self
            self.CAPSMenu!.setStartIndexToPage(index: 0)
        }
        else if(self.fromScreen == "hdfc")
        {
            // Optional delegate
            self.CAPSMenu!.delegate = self
            self.CAPSMenu!.setStartIndexToPage(index: 0)
        }
        else if(self.fromScreen == "icici")
        {
            // Optional delegate
            self.CAPSMenu!.delegate = self
            self.CAPSMenu!.setStartIndexToPage(index: 0)
        }
        
        self.motorinsuranceView.addSubview((self.CAPSMenu?.view)!)
        
    }
    //-------<end capsMenu>--------
    

    @objc func willMoveToPage(_ controller: UIViewController, index: Int){
        print("willMoveToPage")
        print("contctName=?",contctName)
        print("index=",index)
        if(self.fromScreen == "fromcompgetQuote" && index == 0)
        {
            self.CAPSMenu!.setStartIndexToPage(index: 0)
        }
        else if(self.fromScreen == "fromhdfcgetQuote" && index == 0)
        {
            self.CAPSMenu!.setStartIndexToPage(index: 0)
        }
        else if(self.fromScreen == "fromicicigetQuote" && index == 0)
        {
            self.CAPSMenu!.setStartIndexToPage(index: 0)
        }
        if(self.fromScreen == "fromcompgetQuote" && index == 1)
        {
            self.CAPSMenu!.setStartIndexToPage(index: 1)
        }
        else if(self.fromScreen == "fromhdfcgetQuote" && index == 1)
        {
            self.CAPSMenu!.setStartIndexToPage(index: 1)
        }
        else if(self.fromScreen == "fromicicigetQuote" && index == 1)
        {
            self.CAPSMenu!.setStartIndexToPage(index: 1)
        }
        if(self.fromScreen == "compare")
        {
            self.CAPSMenu!.setStartIndexToPage(index: 0)
            TTGSnackbar.init(message: "Please fill all inputs", duration: .long).show()
        }
        else if(self.fromScreen == "hdfc")
        {
            self.CAPSMenu!.setStartIndexToPage(index: 0)
            TTGSnackbar.init(message: "Please fill all inputs", duration: .long).show()
        }
        else if(self.fromScreen == "icici")
        {
            self.CAPSMenu!.setStartIndexToPage(index: 0)
            TTGSnackbar.init(message: "Please fill all inputs", duration: .long).show()
        }

    }
    @objc func didMoveToPage(_ controller: UIViewController, index: Int){
        print("didMoveToPage")
        print("contctName=?",contctName)
        print("index=",index)
        if(self.fromScreen == "fromcompgetQuote" && index == 0)
        {
            self.CAPSMenu!.setStartIndexToPage(index: 0)
        }
        else if(self.fromScreen == "fromhdfcgetQuote" && index == 0)
        {
            self.CAPSMenu!.setStartIndexToPage(index: 0)
        }
        else if(self.fromScreen == "fromicicigetQuote" && index == 0)
        {
            self.CAPSMenu!.setStartIndexToPage(index: 0)
        }
        if(self.fromScreen == "fromcompgetQuote" && index == 1)
        {
            self.CAPSMenu!.setStartIndexToPage(index: 1)
        }
        else if(self.fromScreen == "fromhdfcgetQuote" && index == 1)
        {
            self.CAPSMenu!.setStartIndexToPage(index: 1)
        }
        else if(self.fromScreen == "fromicicigetQuote" && index == 1)
        {
            self.CAPSMenu!.setStartIndexToPage(index: 1)
        }
        if(self.fromScreen == "compare")
        {
            self.CAPSMenu!.setStartIndexToPage(index: 0)
            TTGSnackbar.init(message: "Please fill all inputs", duration: .long).show()
        }
        else if(self.fromScreen == "hdfc")
        {
            self.CAPSMenu!.setStartIndexToPage(index: 0)
            TTGSnackbar.init(message: "Please fill all inputs", duration: .long).show()
        }
        else if(self.fromScreen == "icici")
        {
            self.CAPSMenu!.setStartIndexToPage(index: 0)
            TTGSnackbar.init(message: "Please fill all inputs", duration: .long).show()
        }
        
    }
    
    
    @IBAction func backBtnCliked(_ sender: Any)
    {
        let LifeInsurance : LifeInsuranceVC = self.storyboard?.instantiateViewController(withIdentifier: "stbLifeInsuranceVC") as! LifeInsuranceVC
        present(LifeInsurance, animated:true, completion: nil)
    }
    
    
    //---<APICALL>---
    func getvehiclerequestAPI()
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
        
        let params: [String: AnyObject] = ["VehicleRequestID":"" as AnyObject,
                                           "count":"0" as AnyObject,
                                           "crn":"" as AnyObject,
                                           "fba_id":FBAId as AnyObject,
                                           "first_name":"" as AnyObject,
                                           "product_id":"1" as AnyObject,
                                           "type":"0" as AnyObject]
        
        let url = "/api/get-vehicle-request"
        
        FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
            alertView.close()
            
            self.view.layoutIfNeeded()
            
            let jsonData = userObject as? NSDictionary
            let quote = jsonData?.value(forKey: "quote") as AnyObject
            let qmotorRequestEntity = quote.value(forKey: "motorRequestEntity") as AnyObject
            let application = jsonData?.value(forKey: "application") as AnyObject
            let appmotorRequestEntity = application.value(forKey: "motorRequestEntity") as AnyObject
            
            if(qmotorRequestEntity != nil)
            {
                let crn = qmotorRequestEntity.value(forKey: "crn") as AnyObject
                self.qtcrnArray = crn as! [String]
                let created_date = qmotorRequestEntity.value(forKey: "created_date") as AnyObject
                self.qtquoteDateArray = created_date as! [String]
                let first_name = qmotorRequestEntity.value(forKey: "first_name") as AnyObject
                self.qtfrstNameArray = first_name as! [String]
                let last_name = qmotorRequestEntity.value(forKey: "last_name") as AnyObject
                self.qtlstNameArray = last_name as! [String]
                let vehicle_id = qmotorRequestEntity.value(forKey: "vehicle_id") as AnyObject
                self.intqtvehicleIdArray = vehicle_id as! [Int]
                self.qtvehicleIdArray = self.intqtvehicleIdArray.map { String($0) }
                let VehicleRequestID = qmotorRequestEntity.value(forKey: "VehicleRequestID") as AnyObject
                self.intvehicleRequestIDArray = VehicleRequestID as! [Int]
                self.qtvehicleRequestIDArray = self.intvehicleRequestIDArray.map { String($0) }
                
            }
            if(appmotorRequestEntity != nil)
            {
                let registration_no = appmotorRequestEntity.value(forKey: "registration_no") as AnyObject
                self.applregistNoArray = registration_no as! [String]
                let created_date = appmotorRequestEntity.value(forKey: "created_date") as AnyObject
                self.applquoteDateArray = created_date as! [String]
                let first_name = appmotorRequestEntity.value(forKey: "first_name") as AnyObject
                self.applfrstNameArray = first_name as! [String]
                let last_name = appmotorRequestEntity.value(forKey: "last_name") as AnyObject
                self.appllstNameArray = last_name as! [String]
                let StatusPercent = appmotorRequestEntity.value(forKey: "StatusPercent") as AnyObject
                self.intapplappstatusArray = StatusPercent as! [Int]
                self.applappstatusArray = self.intapplappstatusArray.map { String($0) }
                let crn = appmotorRequestEntity.value(forKey: "crn") as AnyObject
                self.applcrnArray = crn as! [String]
                let insImage = appmotorRequestEntity.value(forKey: "insImage") as AnyObject
                self.applImgArray = insImage as! [String]
                
            }
        
            self.callfromScreens()
            
            
        }, onError: { errorData in
            alertView.close()
            let snackbar = TTGSnackbar.init(message: errorData.errorMessage, duration: .long)
            snackbar.show()
        }, onForceUpgrade: {errorData in})
        
    }
    
    func gettwoWhlrvehiclerequestAPI()
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
        
        let params: [String: AnyObject] = ["VehicleRequestID":"" as AnyObject,
                                           "count":"0" as AnyObject,
                                           "crn":"" as AnyObject,
                                           "fba_id":FBAId as AnyObject,
                                           "first_name":"" as AnyObject,
                                           "product_id":"10" as AnyObject,
                                           "type":"0" as AnyObject]
        
        let url = "/api/get-vehicle-request"
        
        FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
            alertView.close()
            
            self.view.layoutIfNeeded()
            
            let jsonData = userObject as? NSDictionary
            let quote = jsonData?.value(forKey: "quote") as AnyObject
            let qmotorRequestEntity = quote.value(forKey: "motorRequestEntity") as AnyObject
            let application = jsonData?.value(forKey: "application") as AnyObject
            let appmotorRequestEntity = application.value(forKey: "motorRequestEntity") as AnyObject
            
            if(qmotorRequestEntity != nil)
            {
                let crn = qmotorRequestEntity.value(forKey: "crn") as AnyObject
                self.twqtcrnArray = crn as! [String]
                let created_date = qmotorRequestEntity.value(forKey: "created_date") as AnyObject
                self.twqtquoteDateArray = created_date as! [String]
                let first_name = qmotorRequestEntity.value(forKey: "first_name") as AnyObject
                self.twqtfrstNameArray = first_name as! [String]
                let last_name = qmotorRequestEntity.value(forKey: "last_name") as AnyObject
                self.twqtlstNameArray = last_name as! [String]
                let vehicle_id = qmotorRequestEntity.value(forKey: "vehicle_id") as AnyObject
                self.intqtvehicleIdArray = vehicle_id as! [Int]
                self.twqtvehicleIdArray = self.intqtvehicleIdArray.map { String($0) }
                let VehicleRequestID = qmotorRequestEntity.value(forKey: "VehicleRequestID") as AnyObject
                self.intvehicleRequestIDArray = VehicleRequestID as! [Int]
                self.twqtvehicleRequestIDArray = self.intvehicleRequestIDArray.map { String($0) }
                
            }
            if(appmotorRequestEntity != nil)
            {
                let registration_no = appmotorRequestEntity.value(forKey: "registration_no") as AnyObject
                self.twapplregistNoArray = registration_no as! [String]
                let created_date = appmotorRequestEntity.value(forKey: "created_date") as AnyObject
                self.twapplquoteDateArray = created_date as! [String]
                let first_name = appmotorRequestEntity.value(forKey: "first_name") as AnyObject
                self.twapplfrstNameArray = first_name as! [String]
                let last_name = appmotorRequestEntity.value(forKey: "last_name") as AnyObject
                self.twappllstNameArray = last_name as! [String]
                let StatusPercent = appmotorRequestEntity.value(forKey: "StatusPercent") as AnyObject
                self.intapplappstatusArray = StatusPercent as! [Int]
                self.twapplappstatusArray = self.intapplappstatusArray.map { String($0) }
                let crn = appmotorRequestEntity.value(forKey: "crn") as AnyObject
                self.twapplcrnArray = crn as! [String]
                let insImage = appmotorRequestEntity.value(forKey: "insImage") as AnyObject
                self.twapplImgArray = insImage as! [String]
                
            }
            
            self.callfromScreens()
            
            
        }, onError: { errorData in
            alertView.close()
            let snackbar = TTGSnackbar.init(message: errorData.errorMessage, duration: .long)
            snackbar.show()
        }, onForceUpgrade: {errorData in})
        
    }
    
    func getsmarttermlifeAPI()
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
        
        let params: [String: AnyObject] = ["fba_id":FBAId as AnyObject,
                                           "count":"0" as AnyObject,
                                           "type":"0" as AnyObject,
                                           "InsurerId": InsurerID as AnyObject]
        
        let url = "/api/get-smart-term-life"
        
        FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
            alertView.close()
            
            self.view.layoutIfNeeded()
            
            let jsonData = userObject as? NSDictionary
//            let quote = jsonData?.value(forKey: "quote") as AnyObject
//            let qtermRequestEntity = quote.value(forKey: "termRequestEntity") as AnyObject
//            let application = jsonData?.value(forKey: "application") as AnyObject
//            let apptermRequestEntity = application.value(forKey: "termRequestEntity") as AnyObject
            
            //Quotes
            let quote = jsonData!.value(forKey: "quote") as! NSArray
            
            for i in 0..<quote.count {
                
                let dict = quote[i]
                
                let qtermRequestEntity = quote.value(forKey: "termRequestEntity") as! NSArray
                for i in 0..<qtermRequestEntity.count {
                    
                    let dict = qtermRequestEntity[i]
                    
                    let crn = (dict as AnyObject).value(forKey: "crn") as AnyObject
                    self.lfcrnArray.append(crn as! String)
                    let created_date = (dict as AnyObject).value(forKey: "created_date") as AnyObject
                    self.lfquoteDateArray.append(created_date as! String)
                    let first_name = (dict as AnyObject).value(forKey: "ContactName") as! String
                    self.lffrstNameArray.append(first_name)
                    let PolicyTerm = (dict as AnyObject).value(forKey: "PolicyTerm") as! String
                    self.policyTermArray.append(PolicyTerm)
                    let InsuredGender = (dict as AnyObject).value(forKey: "InsuredGender") as! String
                    self.insuredGenderArray.append(InsuredGender)
                    let Is_TabaccoUser = (dict as AnyObject).value(forKey: "Is_TabaccoUser") as! String
                    self.is_TabaccoUserArray.append(Is_TabaccoUser)
                    let SumAssured = (dict as AnyObject).value(forKey: "SumAssured") as! String
                    self.sumAssuredArray.append(SumAssured)
                    let InsuredDOB = (dict as AnyObject).value(forKey: "InsuredDOB") as! String
                    self.insuredDOBArray.append(InsuredDOB)
                    let PlanTaken = (dict as AnyObject).value(forKey: "PlanTaken") as! String
                    let PPT = (dict as AnyObject).value(forKey: "PPT") as! String
                    self.pPTArray.append(PPT)
                    let ContactMobile = (dict as AnyObject).value(forKey: "ContactMobile") as! String
                    self.contactMobileArray.append(ContactMobile)
                    let pincode = (dict as AnyObject).value(forKey: "pincode") as! String
                    self.pincodeArray.append(pincode)
                }
                
            }
            
            //Applicatn
            let application = jsonData!.value(forKey: "application") as! NSArray
            
            for i in 0..<application.count {
                
                let dict = application[i]
                
                let qtermRequestEntity = application.value(forKey: "termRequestEntity") as! NSArray
                let NetPremium = application.value(forKey: "NetPremium") as! NSArray
                self.lfapremiumppArray = NetPremium as! [String]
                let statusProgress = application.value(forKey: "statusProgress") as AnyObject
                let statusArray = statusProgress as! [Int]
                let sstatusArray = statusArray.map { String($0) }
                if(sstatusArray == ["0"]){
                    self.lfastatusArray.append("---")
                }
                else{
                    self.lfastatusArray.append("LINK SENT")
                }
                
                for i in 0..<qtermRequestEntity.count {
                    
                    let dict = qtermRequestEntity[i]
                   
                    let created_date = (dict as AnyObject).value(forKey: "created_date") as AnyObject
                    self.lfapplquoteDateArray.append(created_date as! String)
                    let first_name = (dict as AnyObject).value(forKey: "ContactName") as AnyObject
                    self.lfapplfrstNameArray.append(first_name as! String)
                    let SumAssured = (dict as AnyObject).value(forKey: "SumAssured") as AnyObject
                    self.lfasumArray.append(SumAssured as! String)
                    let IncomeTerm = (dict as AnyObject).value(forKey: "IncomeTerm") as AnyObject
                    self.lfasumArray.append(IncomeTerm as! String)
                    let PolicyTerm = (dict as AnyObject).value(forKey: "PolicyTerm") as AnyObject
                    let PPT = (dict as AnyObject).value(forKey: "PPT") as AnyObject
                    self.lfatermpptArray.append((PolicyTerm as! String)+"/"+(PPT as! String))
//                    self.applregistNoArray.append(PPT as! String)
                    let crn = (dict as AnyObject).value(forKey: "crn") as AnyObject
                    self.lfaappNoArray.append(crn as! String)
                    let conversion_date = (dict as AnyObject).value(forKey: "conversion_date") as AnyObject
                    self.lfastatusDateArray.append(conversion_date as! String)
                    let Frequency = (dict as AnyObject).value(forKey: "Frequency") as AnyObject
                    if(Frequency as! String == "Annual")
                    {
                        self.lfamodeArray.append("YEARLY")
                    }
                    else{
                        self.lfamodeArray.append("")
                    }
                    
//                    self.intapplappstatusArray.append(StatusPercent as! Int)
//                    self.applappstatusArray = self.intapplappstatusArray.map { String($0) }
//                    print("applappstatusArray=",self.applappstatusArray)
//
                    
                }
                
            }

            self.callfromScreens()
            
            
        }, onError: { errorData in
            alertView.close()
            let snackbar = TTGSnackbar.init(message: errorData.errorMessage, duration: .long)
            snackbar.show()
        }, onForceUpgrade: {errorData in})
        
    }
    
    
    //--<commonFunction>--
    func callfromScreens(){
        
        if(self.fromScreen == "addQuotes" || self.fromScreen == "twoWhlr" || self.fromScreen == "hLoan" || self.fromScreen == "pLoan" || self.fromScreen == "lp" || self.fromScreen == "compare" || self.fromScreen == "hdfc" || self.fromScreen == "icici" || fromScreen == "fromcompgetQuote" || self.fromScreen == "fromhdfcgetQuote" || self.fromScreen == "fromicicigetQuote")
        {
            if(self.fromScreen == "twoWhlr"){
                self.titleLbl.text! = "TWO WHEELER"
            }
            if(self.fromScreen == "hLoan"){
                self.titleLbl.text! = "HOME LOAN"
            }
            if(self.fromScreen == "pLoan"){
                self.titleLbl.text! = "PERSONAL LOAN"
            }
            if(self.fromScreen == "lp"){
                self.titleLbl.text! = "LOAN AGAINST PROPERTY"
            }
            if(self.fromScreen == "compare" || self.fromScreen == "fromcompgetQuote"){
                self.titleLbl.text! = "COMPARE TERM INSURANCE"
            }
            if(self.fromScreen == "hdfc" || self.fromScreen == "fromhdfcgetQuote"){
                self.titleLbl.text! = "CLICK TO PROTECT 3D"
            }
            if(self.fromScreen == "icici" || self.fromScreen == "fromicicigetQuote"){
                self.titleLbl.text! = "ICICI PRUDENTIAL"
            }
            self.capsMenu()
            
        }
        else if(self.fromScreen == "private" || self.fromScreen == "twoWheeler" || self.fromScreen == "homeLoan" || self.fromScreen == "personalLoan" || self.fromScreen == "lap" || fromScreen == "compareTerm" || fromScreen == "hdfcLife" || fromScreen == "iciciPruden")
        {
            if(self.fromScreen == "twoWheeler"){
                self.titleLbl.text! = "TWO WHEELER"
            }
            if(self.fromScreen == "homeLoan"){
                self.titleLbl.text! = "HOME LOAN"
            }
            if(self.fromScreen == "personalLoan"){
                self.titleLbl.text! = "PERSONAL LOAN"
            }
            if(self.fromScreen == "lap"){
                self.titleLbl.text! = "LOAN AGAINST PROPERTY"
            }
            if(fromScreen == "compareTerm"){
                self.titleLbl.text! = "COMPARE TERM INSURANCE"
            }
            if(fromScreen == "hdfcLife"){
                self.titleLbl.text! = "HDFC LIFE INSURANCE"
            }
            if(fromScreen == "iciciPruden"){
                self.titleLbl.text! = "ICICI PRUDENTIAL LIFE INSURANCE"
            }
            self.maincapsMenu()
            
        }
        
    }
    
    
}
