//
//  healthAssureVC.swift
//  MagicFinmart
//
//  Created by Admin on 17/04/19.
//  Copyright © 2019 Ashwini. All rights reserved.
//

import UIKit
import CustomIOSAlertView
import TTGSnackbar

class healthAssureVC: UIViewController,UITableViewDelegate,UITableViewDataSource,healthAssurecellDelegates,UIGestureRecognizerDelegate {
    
    @IBOutlet var healthAssureTV: UITableView!
    
    @IBOutlet var titlNameLbl: UILabel!
    @IBOutlet var titleMobLbl: UILabel!
    var detailpackNameArray = [String]()
    var detailcntArray = [String]()
    var detailmrpArray = [String]()
    var detailofferpriceArray = [String]()
    var detailpckcodeArray = [String]()
    var nameArray = [String]()
    var ParamDetailsArray = Array<Any>()
    var ParamDetailsArrayCount = [String]()
    var paramArr = [String]()
    var paramCount = Int()
    
    //-<tableView>-
    private let headerIdentifier = "headercell"
    private let cellIdentifier = "contentcell"
    private var sectionTitles = ["One", "Two"]
    private let Titles = ["First", "Second"]
    private var sectionIsExpanded = [Bool]()
    private let numberOfActualRowsForSection = 1
    
    var packCode = ""
    var hmobNo = ""
    var hfirstNme = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.titlNameLbl.text! = hfirstNme
        self.titleMobLbl.text! = hmobNo
        
        //apicall
        PackDetailsAPI()

    }
   
    
    @IBAction func backBtnCliked(_ sender: Any)
    {
        let KYDrawer : KYDrawerController = self.storyboard?.instantiateViewController(withIdentifier: "stbKYDrawerController") as! KYDrawerController
        present(KYDrawer, animated: true, completion: nil)
    }
    
    @IBAction func homeBtnCliked(_ sender: Any)
    {
        let KYDrawer : KYDrawerController = self.storyboard?.instantiateViewController(withIdentifier: "stbKYDrawerController") as! KYDrawerController
        present(KYDrawer, animated: true, completion: nil)
    }
    
    
    @IBAction func hshareBtnCliked(_ sender: Any)
    {
        let commonWeb : commonWebVC = self.storyboard?.instantiateViewController(withIdentifier: "stbcommonWebVC") as! commonWebVC
        commonWeb.webfromScreen = "healthAssure"
        commonWeb.healthpckCode = "71"
        present(commonWeb, animated: true, completion: nil)
    }
    
    func dwnArrowBtnTapped(cell: healthAssureTVCell) {
        let indexPath = self.healthAssureTV.indexPath(for: cell)
        self.packCode = detailpckcodeArray[(indexPath?.section)!]
       
        PackParamAPI()
        
        if indexPath!.row == 0 {
            sectionIsExpanded[indexPath!.section] = !sectionIsExpanded[indexPath!.section]
            healthAssureTV.reloadSections([indexPath!.section], with: .automatic)
        }
    }
    
    func shareBtnTapped(cell: healthAssureTVCell) {
        let indexPath = self.healthAssureTV.indexPath(for: cell)
        let commonWeb : commonWebVC = self.storyboard?.instantiateViewController(withIdentifier: "stbcommonWebVC") as! commonWebVC
        commonWeb.webfromScreen = "healthAssure"
        commonWeb.healthpckCode = self.packCode
        present(commonWeb, animated: true, completion: nil)
        
    }
    
    //--<tableViewDatasource+Delegates>--
    func numberOfSections(in tableView: UITableView) -> Int {
        return detailpackNameArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // First will always be header
        return sectionIsExpanded[section] ? (1+numberOfActualRowsForSection) : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: headerIdentifier, for: indexPath) as! healthAssureTVCell
            
            cell.pckNameLbl.text! = detailpackNameArray[indexPath.section]
            //             cell.mrpLbl.text! = detailmrpArray[indexPath.section]
            cell.offerPriceLbl.text! = "₹ " + detailofferpriceArray[indexPath.section]
            cell.cntLbl.text! = detailcntArray[indexPath.section]+" Tests"
            let mrpArrays = "₹ " + detailmrpArray[indexPath.section]
            cell.mrpLbl.attributedText! = mrpArrays.strikeThrough()
            
            if sectionIsExpanded[indexPath.section] {
                cell.setExpanded()
                cell.shareBtn.isHidden = false
            } else {
                cell.setCollapsed()
                cell.shareBtn.isHidden = true
            }
            
            //--buttonRow--
            cell.hadelegate = self
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! healthAssure2TVCell
            
            let replacementRules = ["0": ""]
            let result = ParamDetailsArrayCount.map{replacementRules[$0] ?? $0}
            print("result",result)
    
            var oddArray = [String]()
            var evenArray = [String]()
            var oddArrayC = [String]()
            var evenArrayC = [String]()
            
            var oddArrayS = Array<Any>()
            var evenArrayS = Array<Any>()
            
            
            
            for (indexas,valueas) in ParamDetailsArray.enumerated() {
                if indexas % 2 == 0 {
                    // It is odd because index starts from 0 in array and I am assuming the 0 index as the odd one.
                   
                    oddArrayS.append(valueas)
                        print("oddArrayS?",oddArrayS)
                  
                    
                } else {
                    
                    evenArrayS.append(valueas)
                        print("evenArrayS?",evenArrayS)
                        
                  
                }
                
            }
            
            
            for (index,value) in nameArray.enumerated() {
                if index % 2 == 0 {
                    // It is odd because index starts from 0 in array and I am assuming the 0 index as the odd one.
                    oddArray.append(value)
                    print("oddArray?",oddArray)
                    cell.hidecellLbl.attributedText = NSAttributedStringHelper.createBulletedList(fromStringArray: oddArray, font: UIFont.systemFont(ofSize: 15), bullet: "✓ ")
                } else {
                    evenArray.append(value)
                    print("evenArray?",evenArray)
                    cell.hidecellLbl2.attributedText = NSAttributedStringHelper.createBulletedList(fromStringArray: evenArray, font: UIFont.systemFont(ofSize: 15), bullet: "✓ ")
                    
                }
            }
            
            for (index1,value1) in result.enumerated() {
                if index1 % 2 == 0 {
                    // It is odd because index starts from 0 in array and I am assuming the 0 index as the odd one.
                    if(value1 == ""){
                        oddArrayC.append(value1)
                        print("oddArrayC?",oddArrayC)
                        
                    }else{
                        oddArrayC.append("- " + value1  + " Tests")
                        print("oddArrayC?",oddArrayC)
                        
                    }
                    cell.hidecellBtnLbl1.attributedText = NSAttributedStringHelper.createBulletedList(fromStringArray: oddArrayC, font: UIFont.systemFont(ofSize: 16), bullet: " ")
                    
                    let tap = UITapGestureRecognizer(target: self, action: #selector(healthAssureVC.tapFunction))
                    cell.hidecellBtnLbl1.isUserInteractionEnabled = true
                    cell.hidecellBtnLbl1.addGestureRecognizer(tap)
                    
                } else {
                    if(value1 == ""){
                        evenArrayC.append(value1)
                        print("evenArrayC?",evenArrayC)
                        
                    }else{
                        evenArrayC.append("- " + value1  + " Tests")
                        print("evenArrayC?",evenArrayC)
                        
                    }
                    cell.hidecellBtnLbl2.attributedText = NSAttributedStringHelper.createBulletedList(fromStringArray: evenArrayC, font: UIFont.systemFont(ofSize: 16), bullet: " ")
                    
                    let tap = UITapGestureRecognizer(target: self, action: #selector(healthAssureVC.tapFunction))
                    cell.hidecellBtnLbl2.isUserInteractionEnabled = true
                    cell.hidecellBtnLbl2.addGestureRecognizer(tap)
                    
                }
                
            }
            
            return cell
        }
        
        
    }
    

    @objc func tapFunction(sender:UITapGestureRecognizer)
    {
        let tag = sender.view?.tag
        print("tag=",tag!)
        
        print("tap working")
        let healthTests : healthTestsVC = self.storyboard?.instantiateViewController(withIdentifier: "stbhealthTestsVC") as! healthTestsVC
        healthTests.testArray = ParamDetailsArray
        self.addChild(healthTests)
        self.view.addSubview(healthTests.view)
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 90
        }else{
            return UITableView.automaticDimension;
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        // Expand/hide the section if tapped its header
//        if indexPath.row == 0 {
//            sectionIsExpanded[indexPath.section] = !sectionIsExpanded[indexPath.section]
//            healthAssureTV.reloadSections([indexPath.section], with: .automatic)
//        }
//        self.packCode = detailpckcodeArray[(indexPath.section)]
//        print("packCode=",packCode)
//        PackParamAPI()
        
    }
    
    
    //--<APICALL>--
    func PackDetailsAPI()
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
        
        
        var params:  [String: Any] = [ "pack_details" : ""]
        params["pack_details"] = ["fromage":"0",
                                       "fromamt":"0",
                                       "gender":"B",
                                       "pass":"Health@1234",
                                       "toage":"0",
                                       "toamt":"0",
                                       "username":"Datacomp"]
        
        print("params=",params)
        let url = "/Products/HAMobileProductService.asmx/PackDetails"
        
        FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params as [String : AnyObject], onSuccess: { (userObject, metadata) in
            alertView.close()
            
            self.view.layoutIfNeeded()
            
            let jsonData = userObject as? NSDictionary
            print("jsonData=",jsonData!)
            let lstPackageDetails = jsonData!.value(forKey: "lstPackageDetails") as! NSArray
            print("lstPackageDetails= ", lstPackageDetails)
            
            for i in 0..<lstPackageDetails.count {

                let dict = lstPackageDetails[i]
                print("dict=",dict)
                let PackName = (dict as AnyObject).value(forKey: "PackName") as AnyObject
                self.detailpackNameArray.append(PackName as! String)
                let cnt = (dict as AnyObject).value(forKey: "cnt") as AnyObject
                self.detailcntArray.append(cnt as! String)
                let PackCode = (dict as AnyObject).value(forKey: "PackCode") as AnyObject
                self.detailpckcodeArray.append(PackCode as! String)
                let MRP = (dict as AnyObject).value(forKey: "MRP") as! Int
                let MRPs = String(MRP)
                self.detailmrpArray.append(MRPs)
                let OfferPrice = (dict as AnyObject).value(forKey: "OfferPrice") as! Int
                let OfferPricess = String(OfferPrice)
                self.detailofferpriceArray.append(OfferPricess)
                self.sectionIsExpanded.append(false)
                print("sectionIsExpanded=?",self.sectionIsExpanded)
                
            }
            
            self.healthAssureTV.reloadData()
            
        
        }, onError: { errorData in
            alertView.close()
            let snackbar = TTGSnackbar.init(message: errorData.errorMessage, duration: .long)
            snackbar.show()
        }, onForceUpgrade: {errorData in},healthAssure: true)
            
        }else{
            let snackbar = TTGSnackbar.init(message: Connectivity.message, duration: .middle )
            snackbar.show()
        }
        
    }
    
    func PackParamAPI()
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
        
        
        var params:  [String: Any] = [ "pack_param" : ""]
        params["pack_param"] = ["packcode":self.packCode,
                                "pass":"Health@1234",
                                "username":"Datacomp"]
        
        print("params=",params)
        let url = "/Products/HAMobileProductService.asmx/PackParam"
        
        FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params as [String : AnyObject], onSuccess: { (userObject, metadata) in
            alertView.close()
            
            self.view.layoutIfNeeded()
            
            let jsonData = userObject as? NSDictionary
            print("jsonData=",jsonData!)
            let lstPackParameter = jsonData!.value(forKey: "lstPackParameter") as! NSArray
            print("lstPackParameter= ", lstPackParameter)
            let Name = (lstPackParameter as AnyObject).value(forKey: "Name") as AnyObject
            self.nameArray = Name as! [String]
            print("nameArray==",self.nameArray)
            let nameCount = self.nameArray.count
            print("nameCount",nameCount)
            
            let ParamDetails = (lstPackParameter as AnyObject).value(forKey: "ParamDetails") as! NSArray
            print("ParamDetails==",ParamDetails)
//            self.ParamDetailsArray = ParamDetails as! [String]
//            print("self.ParamDetailsArray??=",self.ParamDetailsArray)
            self.paramCount = ParamDetails.count
            print("paramCount",self.paramCount)

            
            for i in 0..<lstPackParameter.count {

                let dict = lstPackParameter[i]
                print("dict=",dict)
//                let Name = (dict as AnyObject).value(forKey: "Name") as AnyObject
//                self.nameArray.append(Name as! String)
//                print("nameArray=",self.nameArray)
                
//                let paramCount = self.ParamDetailsArray.count
//                print("ParamCount??",paramCount)
                
                if(self.ParamDetailsArrayCount.count <= nameCount-1){
                    
                    let ParamDetails = (dict as AnyObject).value(forKey: "ParamDetails") as! NSArray
                    print("ParamDetails=",ParamDetails)
//                    self.ParamDetailsArray = ParamDetails as! [String]
//                    print("self.ParamDetailsArray=",self.ParamDetailsArray)
                    self.ParamDetailsArray.append(ParamDetails as! [String])
                     print("self.ParamDetailsArray=",self.ParamDetailsArray)
                    let param = ParamDetails.count
                    print("param=",param)
                    self.ParamDetailsArrayCount.append(String(param))
                    print("self.ParamDetailsArrayCount=",self.ParamDetailsArrayCount)
                    
                }
               

            }
            
//            self.ParamDetailsArrayCount = self.paramArr
//            print("ParamDetailsArrayCount",self.ParamDetailsArrayCount)
            
            self.healthAssureTV.reloadData()
            
            
        }, onError: { errorData in
            alertView.close()
            let snackbar = TTGSnackbar.init(message: errorData.errorMessage, duration: .long)
            snackbar.show()
        }, onForceUpgrade: {errorData in},healthAssure: true)
        
    }else{
    let snackbar = TTGSnackbar.init(message: Connectivity.message, duration: .middle )
    snackbar.show()
    }
        
    }
    
}


extension String{
    func strikeThrough()->NSAttributedString{
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
}
