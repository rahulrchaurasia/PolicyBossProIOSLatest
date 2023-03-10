//
//  MainfinMartVC.swift
//  MagicFinmart
//
//  Created by Ashwini on 13/12/18.
//  Copyright © 2018 Ashwini. All rights reserved.


import UIKit
import CustomIOSAlertView
import TTGSnackbar
import SwiftyJSON
import Alamofire
import SDWebImage
import MessageUI
import StoreKit

class MainfinMartVC: UIViewController,UITableViewDataSource,UITableViewDelegate,callingrevampDelegate,MFMailComposeViewControllerDelegate ,HomeDelegate, SKStoreProductViewControllerDelegate{
   
    
   
    @IBOutlet weak var mainTV: UITableView!
    @IBOutlet weak var salesmaterialView: UIView!
    //@IBOutlet weak var pendingcasesView: UIView!
    @IBOutlet weak var knowguruView: UIView!
    
    @IBOutlet weak var NewImage: UIImageView!
    
    
    @IBOutlet weak var MainScrollView: UIScrollView!
    var dynamicDashboardModel = [DynamicDashboardModel]()
    var loanModel = [DynamicDashboardModel]()
    var moreServiceModel = [DynamicDashboardModel]()
    
     var userDashboardModel = [UserConstDashboarddModel]()
    var callingDashboardModel = [CallingDashboardModel]()     // For Calling
    // For AlertDialog
     let alertService = AlertService()
    //popUp
    @IBOutlet var popUpbackgroundView: UIView!
    @IBOutlet var popUpView: UIView!
    @IBOutlet weak var popUpTV: UITableView!
    var MobileNoArray = [String]()
    var EmailIdArry = [String]()
    var EmployeeNameArray = [String]()
    var DesignationArray = [String]()
    var managerName = ""
    var mobNo = ""
    
    //******************** Below Array Not in Used **********************
    var insuranceArray = ["PRIVATE CAR","TWO WHEELER","COMMERCIAL VEHICLE","HEALTH INSURANCE","LIFE INSURANCE","REQUEST OFFLINE QUOTES"]
    var loansArray = ["CREDIT CARD","PERSONAL LOAN","BUSINESS LOAN","HOME LOAN","LOAN AGAINST PROPERTY"]
    var moreservicesArray = ["OTHER INVESTMENT PRODUCT-P2P"]
    
     var moreservicesArray1 = ["OTHER INVESTMENT PRODUCT-P2P"]
    var insuranceImgArray = ["private_car.png","two_wheeler.png","commercial_vehicle","health_insurance.png","life_insurance.png","offlineportal.png"]
    var loansImgArray = ["credit_card.png","personal_loan.png","balance_transfer.png","home_loan.png","loan_against_property.png"]
    var othrImgArray = ["health_checkup_plan.png"]
    //--<detailsTVArrays>--
    var insuranceDetailArray = ["Best quotes for Private Car Insurance of your customers with instant policy.","Best quotes for Two Wheeler Insurance of your customers with instant policy.","Best quotes for CV Insurance of your customers with instant policy.","Get quotes and compare benefits of health insurance from top insurance companies.","Get quotes and compare benefits of life insurance from top insurance companies.","Get offline quotes"]
    
    
    var loansDetailArray = ["Home loan at best intrest rates from over 20+ banks & NBFCs.","Provide instant approval for your customers at attractive intrest rates.","Maximum loan amount at competitive intrest rate against property.","Get instant Credit card approvals with amazing offers and deals.","Transfer existing loans at lower intrest rate.And help customers to save more on existing loans.","Get your credit report with score at no cost.","Enjoy chatting with your BOT freind & provide instant loan sanction to your customer for Personal Loan,Home Loan,Business Loan,Car Loan,LAP,Gold Loan,etc.","Submit leads for products like Car Loan,Business Loan,Working Capital,Term Loan,LRD,etc.","Loan disbursed in just few hours!!!","We Finance your growth","Improve your credit score."]
    
  
    deinit {
      // NotificationCenter.default.removeObserver(self)
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        print("TAG" + "WillAppear ")
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        let notificationCenter = NotificationCenter.default
//           notificationCenter.addObserver(self, selector: #selector(appComeToForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        
        popUpbackgroundView.isHidden = true
        self.mainTV.isHidden = true
        //border
        let borderColor = UIColor.black
        salesmaterialView.layer.borderWidth=1.0;
        salesmaterialView.layer.borderColor=borderColor.cgColor;
       // pendingcasesView.layer.borderWidth=1.0;
       // pendingcasesView.layer.borderColor=borderColor.cgColor;
        knowguruView.layer.borderWidth=1.0;
        knowguruView.layer.borderColor=borderColor.cgColor;
        
        
        MainScrollView.isScrollEnabled = false
        
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            print("VERSION SHORT",version)
        }
        
        NewImage.loadGif(name: "newicon")     // Know your Finmart gif image
        
        // UITableViewCell.appearance().selectionStyle = .none    // for Removing Default Selection
        
        
        //--<api>--
       // getLoanStaticDashboard()
        self.userconstantAPI()
        self.getdynamicappAPI()
        self.getDeviceDetails()
        
    
        
        NotificationCenter.default.addObserver(self, selector: #selector(NotifyData(notification:)),
                                               name: .NotifyMyAccountProfile, object: nil)
     
    }
    
    
    @objc func NotifyData(notification : Notification){
        
        self.userconstantAPI()
        self.getdynamicappAPI()
        
       
    }
    
    //////////////////////  Method For Orientation   ////////////////////////////
    
    
    override var shouldAutorotate: Bool {
        
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        
        return .portrait
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        
        return .portrait
    }
    
    //////////////////////////
    
 
    
    
   // Mark : Used notificationCenter for method called when apps comes from foreground to background
    
//    @objc func appComeToForeground() {
//        print("On Resumed")
//        userconstantAPI()
//
//        self.verifyVersion()
//
//
//    }
//
    
    func verifyVersion(){
        
        if(UserDefaults.exists(key: "iosversion") == true) {
            
            if let buildVersion = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
                print("VERSION Device BUILD",buildVersion)
                
                
                let iosversion = UserDefaults.standard.string(forKey: "iosversion")
                
                let ServiceBuildVersion = (iosversion! as NSString).intValue
                
                let devicebuildVersion = (buildVersion as NSString).intValue
                print( "VERSION Service Build",  iosversion! as String )
                
                if(  ServiceBuildVersion > devicebuildVersion){
                   
                    callAppStore()
                    
                }
            }
        }
    }
    
    func callAppStore()
    {
        // Create the alert controller
        let alertController = UIAlertController(title: "UPDATE", message: "New version available on app store, Please update.", preferredStyle: .alert)
        // Create the actions
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
            UIAlertAction in
            NSLog("OK Pressed")
            
           
            self.openAppstore()
            
            self.dismissAll(animated: false)
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
                       let Login : LoginVC = self.storyboard?.instantiateViewController(withIdentifier: "stbLoginVC") as! LoginVC
                       Login.resetDefaults()

                       Login.modalPresentationStyle = .fullScreen

                       appDelegate?.window?.rootViewController = Login
                       self.present(Login, animated: true, completion: nil)
                       
    
        }
        
        // Add the actions
        alertController.addAction(okAction)
        
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    func openAppstore(){

        if let url = URL(string: "https://itunes.apple.com/in/app/policyboss-pro/id1596870566?mt=8")
        {
                   if #available(iOS 10.0, *) {
                      UIApplication.shared.open(url, options: [:], completionHandler: nil)
                   }
                   else {
                         if UIApplication.shared.canOpenURL(url as URL) {
                            UIApplication.shared.openURL(url as URL)
                        }
                   }
        }
    }
    
    func resetDefaults() {
        let defaults = UserDefaults.standard
        // let dictionary = defaults.dictionaryRepresentation()
        defaults.dictionaryRepresentation().keys.forEach(defaults.removeObject(forKey:))
        Core.shared.setNewUser()
         
    }
    func deSelectDashboard(){
        
        if let index = mainTV.indexPathForSelectedRow{
            self.mainTV.deselectRow(at: index, animated: false)
        }
    }
    
//    func loadParentFromMenu(){
//
//        let commonWeb : commonWebVC = self.storyboard?.instantiateViewController(withIdentifier: "stbcommonWebVC") as! commonWebVC
//        commonWeb.webfromScreen = "HealthInsurance"
//        commonWeb.addType = "CHILD"
//
//        self.add(commonWeb)    // Adding in Parent View
//
//    }
    
    
   
    @IBAction func finmartMenuBtn(_ sender: Any)
    {
        if let drawerController = navigationController?.parent as? KYDrawerController {
            drawerController.setDrawerState(.opened, animated: true)
        }
    }
   
    @IBAction func salesmaterialBtnCliked(_ sender: Any)
    {
        let Salesmaterial : SalesmaterialVC = self.storyboard?.instantiateViewController(withIdentifier: "stbSalesmaterialVC") as! SalesmaterialVC

          Salesmaterial.modalPresentationStyle = .fullScreen
          Salesmaterial.modalTransitionStyle = .coverVertical
          present(Salesmaterial, animated: false, completion: nil)
        
       // self.add(Salesmaterial)
    }

    @IBAction func knowguruBtnCliked(_ sender: Any)
    {
    
       let KnowlgeGuru : KnowlgeGuruVC = self.storyboard?.instantiateViewController(withIdentifier: "stbKnowlgeGuruVC") as! KnowlgeGuruVC
        
        KnowlgeGuru.modalPresentationStyle = .fullScreen
        KnowlgeGuru.modalTransitionStyle = .coverVertical
        present(KnowlgeGuru, animated: false, completion: nil)
    }
    
    //tableView Datasource+Delegates
    func numberOfSections(in tableView: UITableView) -> Int
    {
        if(popUpbackgroundView.isHidden == false)
        {
            return 1
        }
        else{
            return 2
        }
    }
    
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if(popUpbackgroundView.isHidden == false)
        {
           // return EmployeeNameArray.count
             return callingDashboardModel.count
        }
        else{
            if(section == 0)
            {
                return dynamicDashboardModel.count
            }
//            else if(section == 2)
//            {
//                return loanModel.count
//            }
//            else if(section == 2)
//            {
//               // return moreServiceModel.count
//                 return 0
//            }
            else if(section == 1)
            {
                return 0
            }
            else{
                return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if(popUpbackgroundView.isHidden == false)
        {
            let cell1 = popUpTV.dequeueReusableCell(withIdentifier: "pcell") as! callingRevampTVCell

            
            cell1.managerNameLbl.text! = callingDashboardModel[indexPath.row].EmployeeName
            cell1.mobLbl.text! = callingDashboardModel[indexPath.row].MobileNo
            cell1.emailLbl.text! = callingDashboardModel[indexPath.row].EmailId
            cell1.levelLbl.text! = callingDashboardModel[indexPath.row].Designation
            
            cell1.callingDelegate = self
            
       
            
            return cell1
            
        }
        else{
            let cell = mainTV.dequeueReusableCell(withIdentifier: "cell") as! MainfinmartTVCell

           
            //shadowColor for uiview
            cell.inTView.layer.cornerRadius = 4.0
            cell.inTView.layer.shadowColor = UIColor.gray.cgColor
            cell.inTView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
            cell.inTView.layer.shadowRadius = 10.0
            cell.inTView.layer.shadowOpacity = 0.8
            
            if(indexPath.section == 0)
            {
                
                /*********************************  Insurance *********************************************************/
                // When Dashboard cell's share Icon Clicked
                cell.tapShareProd = {
                    
                    let alertVC =  self.alertService.alert(title: self.dynamicDashboardModel[indexPath.row].title,
                                                           body:self.dynamicDashboardModel[indexPath.row].popupmsg,
                                                           buttonTitle: "SHARE")
                    
                    // When Alert Dialog Share Button Click
                    alertVC.didClickShare = {
                        print("share the Data ")
                        self.getShareData(prdID: self.dynamicDashboardModel[indexPath.row].ProdId)
                        
                    }
                    self.present(alertVC, animated: true)
                    
                    
                }
                
                // When Alert Dialog Info Button Click
                cell.tapInfoProd = {
                    
                    
                    let alertWebVC = self.alertService.alertWebView(webURL: self.dynamicDashboardModel[indexPath.row].info)
                    self.present(alertWebVC, animated: true)
                }
                
                /******************************************************************************************/
                
                cell.cellbtnInfoProduct.isHidden = true
                cell.cellbtnShareProduct.isHidden = true

                cell.cellImageInfoProduct.isHidden = true
                cell.cellImageShareProduct.isHidden = true
                
                  cell.cellNewImage.isHidden = true
                // check if Info  is not empty
                if(dynamicDashboardModel[indexPath.row].info == "" )
                {
                    cell.cellbtnInfoProduct.isHidden = true
                    cell.cellImageInfoProduct.isHidden = true
                }else{
                    cell.cellbtnInfoProduct.isHidden = false
                      cell.cellImageInfoProduct.isHidden = false
                }
                
                // check if Share  is not empty
                if(dynamicDashboardModel[indexPath.row].IsSharable == "Y" )
                {
                     cell.cellbtnShareProduct.isHidden = false
                     cell.cellImageShareProduct.isHidden = false
                  
                }else{
                     cell.cellbtnShareProduct.isHidden = true
                     cell.cellImageShareProduct.isHidden = true
                }
                
                // check New Product
                if(dynamicDashboardModel[indexPath.row].IsNewprdClickable == "Y" )
                {
                    cell.cellNewImage.isHidden = false
                    cell.cellNewImageConstant.constant = 26
                    cell.cellNewImage.loadGif(name: "newicon")
                    
                }else{
                    cell.cellNewImage.isHidden = true
                    cell.cellNewImageConstant.constant = 0
                }
                
            
               
                cell.cellTitleLbl.text! = dynamicDashboardModel[indexPath.row].menuname.uppercased()
                cell.celldetailTextLbl.text! = "\(dynamicDashboardModel[indexPath.row].dashdescription) \n"
            
                 let remoteImageURL = URL(string: dynamicDashboardModel[indexPath.row].iconimage)!
    
                 cell.cellImage.sd_setImage(with: remoteImageURL)        //SDWebImage
                

               
            }
            //***********************************************//
            // *******  Loan Module is Commented *******///
            //***********************************************//
            
//            else if(indexPath.section == 2)
//            {
//
//
//                /*********************************  Loan  *********************************************************/
//                // When Dashboard cell's share Icon Clicked
//                cell.tapShareProd = {
//
//                    let alertVC =  self.alertService.alert(title: self.loanModel[indexPath.row].title,
//                                                           body:self.loanModel[indexPath.row].popupmsg,
//                                                           buttonTitle: "SHARE")
//
//                    // When Alert Dialog Share Button Click
//                    alertVC.didClickShare = {
//                        print("share the Data 5 ")
//                        self.getShareData(prdID: self.loanModel[indexPath.row].ProdId)
//
//                    }
//                    self.present(alertVC, animated: true)
//
//
//                }
//
//                // When Alert Dialog Info Button Click
//                cell.tapInfoProd = {
//
//
//                    let alertWebVC = self.alertService.alertWebView(webURL: self.loanModel[indexPath.row].info)
//                    self.present(alertWebVC, animated: true)
//                }
//
//                /*************************************************************************************************/
//
//
//
//                cell.cellbtnInfoProduct.isHidden = true
//                cell.cellbtnShareProduct.isHidden = true
//
//                cell.cellImageInfoProduct.isHidden = true
//                cell.cellImageShareProduct.isHidden = true
//                cell.cellNewImage.isHidden = true
//
//                // check if Info  is not empty
//                if(loanModel[indexPath.row].info == "" )
//                {
//                    cell.cellbtnInfoProduct.isHidden = true
//                    cell.cellImageInfoProduct.isHidden = true
//                }else{
//                    cell.cellbtnInfoProduct.isHidden = false
//                    cell.cellImageInfoProduct.isHidden = false
//                }
//
//                // check if Share  is not empty
//                if(loanModel[indexPath.row].IsSharable == "Y" )
//                {
//                    cell.cellbtnShareProduct.isHidden = false
//                    cell.cellImageShareProduct.isHidden = false
//
//                }else{
//                    cell.cellbtnShareProduct.isHidden = true
//                    cell.cellImageShareProduct.isHidden = true
//                }
//
//
//                //loanModel
////                cell.cellTitleLbl.text! = loansArray[indexPath.row]
////                cell.celldetailTextLbl.text! = loansDetailArray[indexPath.row]
////                cell.cellImage.image = UIImage(named: loansImgArray[indexPath.row])
//
//                cell.cellTitleLbl.text! = loanModel[indexPath.row].menuname.uppercased()
//                cell.celldetailTextLbl.text! = loanModel[indexPath.row].dashdescription
//                cell.cellImage.image = UIImage(named: loanModel[indexPath.row].iconimage)
//
//            }
            
            
            //***********************************************//
            // *******  More Service Module is Commented *******///
            //***********************************************//
//        else if(indexPath.section == 2)
//            {
//                cell.cellbtnInfoProduct.isHidden = true
//                cell.cellbtnShareProduct.isHidden = true
//
//                cell.cellImageInfoProduct.isHidden = true
//                cell.cellImageShareProduct.isHidden = true
//                cell.cellNewImage.isHidden = true
//
//
//
//
//                cell.cellTitleLbl.text! = moreServiceModel[indexPath.row].menuname.uppercased()
//                cell.celldetailTextLbl.text! = moreServiceModel[indexPath.row].dashdescription
//               // cell.cellImage.image = UIImage(named: moreServiceModel[indexPath.row].iconimage)
//
//                let remoteImageURL = URL(string: moreServiceModel[indexPath.row].iconimage)!
//                cell.cellImage.sd_setImage(with: remoteImageURL)        //SDWebImage
//
//
//
//
//            }
            

           
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if(popUpbackgroundView.isHidden == false)
        {
            print("popup")
            
        }
        else{
            if(indexPath.section == 0)
            {
                //************** For Insurance Tap **********//
                
                switch Int(self.dynamicDashboardModel[indexPath.row].ProdId) {
                case 1  :  // car
                    

                    
                    callWebView(webfromScreen: "private", type: "CHILD")
                    
                    break
                case 2  :  // Health
                   
                      callWebView(webfromScreen: "HealthInsurance", type: "CHILD")
                    break
                    
                case 10 :  // TWO WHEELER
                 
                    callWebView(webfromScreen: "twoWheeler", type: "CHILD")
                    break
                    
                case 12  :   //COMMERCIAL VEHICLE
                   
                    callWebView(webfromScreen: "COMMERCIALVEHICLE", type: "CHILD")
                    break
                    
                case 18  :    // TermInsurance
                    
                    /*
                    let LifeInsurance : LifeInsuranceVC = self.storyboard?.instantiateViewController(withIdentifier: "stbLifeInsuranceVC") as! LifeInsuranceVC
               
                    
                     LifeInsurance.modalPresentationStyle = .fullScreen
                    LifeInsurance.addType = "CHILD"
                    
                    add(LifeInsurance)
                    deSelectDashboard()
                     */
                    
                    break
                    
                case 16 :    // Offline
                  
                    let msg = "Coming soon..."
                    let snackbar = TTGSnackbar.init(message: msg , duration: .long)
                    snackbar.show()
                    
                    break
                   
            
                default :
                    
                    if(Int(self.dynamicDashboardModel[indexPath.row].ProdId )!  < 100 ){
                        
                        if(self.dynamicDashboardModel[indexPath.row].IsNewprdClickable == "Y" ){
                            
                            var dynamicURL : String?
                            
                            for obj in userDashboardModel {
                              
                                if(obj.ProdId == self.dynamicDashboardModel[indexPath.row].ProdId ){
                                   dynamicURL = obj.url
                                    
                                    break
                                }
                            }
                            
                            
                            if let modelURL = dynamicURL {
                                
                                let ProdId = self.dynamicDashboardModel[indexPath.row].ProdId
                               // let pospNo = UserDefaults.standard.string(forKey: "POSPNo") ?? "0"
                                let appVersion = Configuration.appVersion
                                
                              
//                                let info =      "&ip_address=10.0.0.1&mac_address=10.0.0.1&app_version="+(appVersion)+"&product_id=\(ProdId)&login_ssid=\(pospNo)"
                                
                                let info = "&ip_address=10.0.0.1&mac_address=10.0.0.1&app_version="+(appVersion)+"&product_id=\(ProdId)&login_ssid="
                                
                                let finalURL = modelURL + info
                                print ("DYNAMIC URL",finalURL)
                                let commonWeb : commonWebVC = self.storyboard?.instantiateViewController(withIdentifier: "stbcommonWebVC") as! commonWebVC
                                commonWeb.webfromScreen = "Dynamic"
                                commonWeb.dynamicUrl = finalURL
                                commonWeb.dynamicName = self.dynamicDashboardModel[indexPath.row].menuname.uppercased()
                              
                                commonWeb.modalPresentationStyle = .fullScreen
                                commonWeb.addType = "CHILD"
                                commonWeb.delegateData = self
                                add(commonWeb)
                                deSelectDashboard()
                                
                                
                            }
                            
                        }
                        
                        
                       
                    }
                   else if(Int(self.dynamicDashboardModel[indexPath.row].ProdId )!  >= 100 ){
                        let commonWeb : commonWebVC = self.storyboard?.instantiateViewController(withIdentifier: "stbcommonWebVC") as! commonWebVC
                        commonWeb.webfromScreen = "Dynamic"
                        commonWeb.dynamicUrl = self.dynamicDashboardModel[indexPath.row].link
                        commonWeb.dynamicName = self.dynamicDashboardModel[indexPath.row].menuname.uppercased()
                       // present(commonWeb, animated: true, completion: nil)
                        commonWeb.modalPresentationStyle = .fullScreen
                        commonWeb.addType = "CHILD"
                         commonWeb.delegateData = self
                        add(commonWeb)
                        deSelectDashboard()
                        
                    }
                   
                }
                

                
                //************** End OF  Insurance Tap **********//
            }
            
            
            
            
 //           if(indexPath.section == 2)
//            {
//
//                switch Int(self.loanModel[indexPath.row].ProdId) {
//
//                case 23  :  // Kotak
//                    let msg = "Coming soon..."
//                    let snackbar = TTGSnackbar.init(message: msg , duration: .long)
//                    snackbar.show()
//                    break
//
//                case 4  :  // credit Loan
//
//                    let commonWeb : commonWebVC = self.storyboard?.instantiateViewController(withIdentifier: "stbcommonWebVC") as! commonWebVC
//                    commonWeb.modalPresentationStyle = .fullScreen
//                    commonWeb.webfromScreen = "credit"
//                    commonWeb.webTitle = self.loanModel[indexPath.row].menuname.uppercased()
//
//                    commonWeb.addType = "CHILD"
//                    add(commonWeb)
//                    deSelectDashboard()
//                    break
//                case 19  :  // personal Loan
//                    let commonWeb : commonWebVC = self.storyboard?.instantiateViewController(withIdentifier: "stbcommonWebVC") as! commonWebVC
//                    commonWeb.modalPresentationStyle = .fullScreen
//                    commonWeb.webfromScreen = "personal"
//                    commonWeb.webTitle = self.loanModel[indexPath.row].menuname.uppercased()
//                    // present(commonWeb, animated: true, completion: nil)
//                    commonWeb.addType = "CHILD"
//                    add(commonWeb)
//                    deSelectDashboard()
//
//
//                case 6  :  // "business Loan"
//                    let commonWeb : commonWebVC = self.storyboard?.instantiateViewController(withIdentifier: "stbcommonWebVC") as! commonWebVC
//                    commonWeb.modalPresentationStyle = .fullScreen
//                    commonWeb.webfromScreen = "business"
//                    commonWeb.webTitle = self.loanModel[indexPath.row].menuname.uppercased()
//                    // present(commonWeb, animated: true, completion: nil)
//                    commonWeb.addType = "CHILD"
//                    add(commonWeb)
//                    deSelectDashboard()
//
//
//
//                case 7  :  // home Loan
//                    let commonWeb : commonWebVC = self.storyboard?.instantiateViewController(withIdentifier: "stbcommonWebVC") as! commonWebVC
//                    commonWeb.modalPresentationStyle = .fullScreen
//                    commonWeb.webfromScreen = "home"
//                    commonWeb.webTitle = self.loanModel[indexPath.row].menuname.uppercased()
//                    // present(commonWeb, animated: true, completion: nil)
//                    commonWeb.addType = "CHILD"
//                    add(commonWeb)
//                    deSelectDashboard()
//
//
//
//                case 8  :  // lap Loan
//                    let commonWeb : commonWebVC = self.storyboard?.instantiateViewController(withIdentifier: "stbcommonWebVC") as! commonWebVC
//                    commonWeb.modalPresentationStyle = .fullScreen
//                    commonWeb.webfromScreen = "lap"
//                    commonWeb.webTitle = self.loanModel[indexPath.row].menuname.uppercased()
//                    // present(commonWeb, animated: true, completion: nil)
//                    commonWeb.addType = "CHILD"
//                    add(commonWeb)
//                    deSelectDashboard()
//
//
//
//                case 81  :  // car Loan
//                    let commonWeb : commonWebVC = self.storyboard?.instantiateViewController(withIdentifier: "stbcommonWebVC") as! commonWebVC
//                    commonWeb.modalPresentationStyle = .fullScreen
//                    commonWeb.webfromScreen = "car"
//                    commonWeb.webTitle = self.loanModel[indexPath.row].menuname.uppercased()
//                    // present(commonWeb, animated: true, completion: nil)
//                    commonWeb.addType = "CHILD"
//                    add(commonWeb)
//                    deSelectDashboard()
//                    break
//
//                default :
//                   print("Loan Clicked")
//
//
//                }
//
//
//            }
            
            
            
//            if(indexPath.section == 2)
//            {
//                if(indexPath.row == 0)
//                {
//                    let commonWeb : commonWebVC = self.storyboard?.instantiateViewController(withIdentifier: "stbcommonWebVC") as! commonWebVC
//                    commonWeb.modalPresentationStyle = .fullScreen
//                    commonWeb.webfromScreen = "otherInvestmentproductp2p"
//                    present(commonWeb, animated: true, completion: nil)
//                    deSelectDashboard()
//                }
//
//            }
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(popUpbackgroundView.isHidden == false)
        {
            return 160
        }
        else{
            return UITableView.automaticDimension //For Auto Height of cell decided by constrain
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(popUpbackgroundView.isHidden == false)
        {
            return 0
        }
        else{
            return 50
        }
        
    }
    
    
    
    @objc func buttonDisclTapped(_ button:UIButton){
        
        
        let commonWeb : commonWebVC = self.storyboard?.instantiateViewController(withIdentifier: "stbcommonWebVC") as! commonWebVC
     
        commonWeb.modalPresentationStyle = .fullScreen
        commonWeb.webfromScreen = "DISCLOSURE"
        commonWeb.addType = "CHILD"
        add(commonWeb)
        deSelectDashboard()
        
        
        
    }
    /////**************************************************//
   
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        if(popUpbackgroundView.isHidden == false)
        {
            print("popView")
            let headerView:UIView =  UIView()
            headerView.backgroundColor = UIColor.gray
            
            return headerView
        }
        else{
            let headerView:UIView =  UIView()
     
            headerView.backgroundColor = UIColor.gray
            
            let label = UILabel()
            label.numberOfLines = 0;
            label.frame = CGRect.init(x: 5, y: 0,  width: view.frame.width, height: 50)
            
            

//            let label2 = UILabel()
//            label2.frame = CGRect.init(x: view.frame.maxY, y: 10, width: 200, height: 30)
//
          
            if(section == 0)
            {
                label.text = "LANDMARK INSURANCE BROKERS PVT. LTD.\n(IRDAI CoR#216)"

                label.font = UIFont.boldSystemFont(ofSize: 16)
                label.textColor = UIColor.white
                headerView.addSubview(label)
         
            }
            else if(section == 1)  //05  Disclosure
            {
                
                
                headerView.backgroundColor = UIColor.init(red: 0.83, green: 0.83, blue: 0.83, alpha: 1.00)
                
                let button = UIButton(frame: CGRect(x: 0, y: 2, width: 300, height: 44))
                button.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin]
               // button.contentVerticalAlignment = .center
                button.setTitle("INSURANCE DISCLOSURE", for: .normal)
                button.backgroundColor = UIColor.init(red: 0/225.0, green: 125/225.0, blue: 213/225.0, alpha: 1)
                button.setTitleColor(UIColor.white, for: .normal)
                button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
                //button.contentHorizontalAlignment = .center
               
                button.tag = section  // important
                button.addTarget(self, action: #selector(self.buttonDisclTapped), for: .touchUpInside)
                
                // let headerView1:UIView =  UIView()
                // headerView1.backgroundColor = UIColor.blue
                
                headerView.addSubview(button)   // add the button to the view
            }

//            else if(section == 2)
//            {
//                label.text = "MORE SERVICES"
//            }
            
            
          
            
            
            

            
            return headerView
        }
        
        
        
        
    }
    

    /////**************************************************//
    
    // endtableView Datasource+Delegates
    
    
    //--<popUp>--
    @IBAction func femalepopUpBtnCliked(_ sender: Any)
    {
        //showpopUpView
        popUpbackgroundView.isHidden = false
//        managerNameLbl.text! = "Manager : " + self.managerName
        usercallingAPI()
    }
    
    
    @IBAction func knowpopUpBtnClicked(_ sender: Any) {
        
        popUpbackgroundView.isHidden = true
        
     let url = UserDefaults.standard.string(forKey: "notificationpopupurl")
        
        guard let popupUrl = url else {
            return
        }
        let alertWebVC = self.alertService.alertWebView(webURL: popupUrl)
        self.present(alertWebVC, animated: true)
        
    }
    
    @IBAction func popUpcancelBtnCliked(_ sender: Any)
    {
        //hidepopUpView
        popUpbackgroundView.isHidden = true
    }
    
    func callingshareBtnTapped(cell: callingRevampTVCell) {
        let indexPath = self.popUpTV.indexPath(for: cell)
       let   email = callingDashboardModel[indexPath!.row].EmailId
//
//        let text = "Dear Sir/Madam,"
//        let vc = UIActivityViewController(activityItems: [text], applicationActivities: [])
//        present(vc, animated: true)
        
        sendEmail(strReceipt: email)
        
    }
    
    func callingcallBtnTapped(cell: callingRevampTVCell) {
        let indexPath = self.popUpTV.indexPath(for: cell)
        mobNo = callingDashboardModel[indexPath!.row].MobileNo
        
        let phoneNumber = mobNo
        
//        if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
//
//            let application:UIApplication = UIApplication.shared
//            if (application.canOpenURL(phoneCallURL)) {
//                application.open(phoneCallURL, options: [:], completionHandler: nil)
//            }
//        }
        
        if let phoneCallURL = URL(string: "telprompt://\(phoneNumber)") {
            
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                if #available(iOS 10.0, *) {
                    application.open(phoneCallURL, options: [:], completionHandler: nil)
                } else {
                    // Fallback on earlier versions
                    application.openURL(phoneCallURL as URL)
                    
                }
            }
        }
    }
    
    // Default overide method of MFMailComposeViewControllerDelegate  (Belong to email)
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    func sendEmail(strReceipt : String ) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([strReceipt])
            mail.setSubject("PolicyBoss")
            mail.setMessageBody("<p>Dear Sir/Madam,</p>", isHTML: true)
            
            present(mail, animated: true)
        } else {
            // show failure alert
        }
        
    }
    
    //---<APICALL>---
    func userconstantAPI()
    {
        
        if Connectivity.isConnectedToInternet()
        {
            print("internet is available.")

            if(UserDefaults.exists(key: "FBAId") == true) {
                
                let FBAId = UserDefaults.standard.string(forKey: "FBAId")
                
                let params: [String: AnyObject] = ["fbaid":FBAId as AnyObject]
                
                let url = "user-constant-pb"
                
                FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
                    
                    // alertView.close()
                    
                    self.view.layoutIfNeeded()
                    
                    let jsonData = userObject as? NSDictionary
                    
                    guard let jsonString = jsonData else { return }
                    
                    let DashboardArray = jsonData?.value(forKey: "dashboardarray") as! NSArray
                    print("USERCONSTANT DATA",DashboardArray)
                    
                    if(DashboardArray.count > 0){
                        for index in 0...(DashboardArray.count)-1 {
                            let aObject = DashboardArray[index] as! [String : AnyObject]
                            
                            let model = UserConstDashboarddModel(
                                ProdId: aObject["ProdId"] as! String, url: aObject["url"] as! String)
                            
                            self.userDashboardModel.append(model)
                        }
                    }
                    
                    
                    
                    UserDefaults.standard.set(jsonString, forKey: "USERCONSTANT")     // set the data
                    
                    //            let dictData  =  UserDefaults.standard.dictionary(forKey: "USERCONSTANT") as? NSDictionary  // retreive the data
                    //
                    //            let muUID =  dictData?.value(forKey: "uid") as AnyObject
                    //            print("Fetchung Data" ,muUID)
                    
                    let uid = jsonData?.value(forKey: "uid") as AnyObject
                    let iosuid = jsonData?.value(forKey: "iosuid") as AnyObject
                    let emplat = jsonData?.value(forKey: "emplat") as AnyObject
                    let emplng = jsonData?.value(forKey: "emplng") as AnyObject
                    let loanselfemail = jsonData?.value(forKey: "loanselfemail") as AnyObject
                    let loanselfmobile = jsonData?.value(forKey: "loanselfmobile") as AnyObject
                    let loansendname = jsonData?.value(forKey: "loansendname") as AnyObject
                    let LoginID = jsonData?.value(forKey: "LoginID") as AnyObject
                    let ManagName = jsonData?.value(forKey: "ManagName") as AnyObject
                    self.managerName = ManagName as! String
                    let POSP_STATUS = jsonData?.value(forKey: "POSP_STATUS") as AnyObject
                    let MangEmail = jsonData?.value(forKey: "MangEmail") as AnyObject
                    let MangMobile = jsonData?.value(forKey: "MangMobile") as AnyObject
                    let SuppEmail = jsonData?.value(forKey: "SuppEmail") as AnyObject
                    let SuppMobile = jsonData?.value(forKey: "SuppMobile") as AnyObject
                    let FBAId = jsonData?.value(forKey: "FBAId") as AnyObject
                    let loanselfid = jsonData?.value(forKey: "loanselfid") as AnyObject
                    let loansendid = jsonData?.value(forKey: "loansendid") as AnyObject
                    let POSPNo = jsonData?.value(forKey: "POSPNo") as AnyObject
                    let ERPID = jsonData?.value(forKey: "ERPID") as AnyObject
                    let loanselfphoto = jsonData?.value(forKey: "loanselfphoto") as AnyObject
                    let TwoWheelerUrl = jsonData?.value(forKey: "TwoWheelerUrl") as AnyObject
                    let FourWheelerUrl = jsonData?.value(forKey: "FourWheelerUrl") as AnyObject
                    
                    let healthurl = jsonData?.value(forKey: "healthurl") as AnyObject
                    let CVUrl = jsonData?.value(forKey: "CVUrl") as AnyObject
                    let notificationpopupurl = jsonData?.value(forKey: "notificationpopupurl") as AnyObject
                    
                    /// posp
                    let pospsendname = jsonData?.value(forKey: "pospsendname") as AnyObject
                    let pospsendemail = jsonData?.value(forKey: "pospsendemail") as AnyObject
                    let pospsendmobile = jsonData?.value(forKey: "pospsendmobile") as AnyObject
                    let pospsenddesignation = jsonData?.value(forKey: "pospsenddesignation") as AnyObject
                    let pospsendphoto = jsonData?.value(forKey: "pospsendphoto") as AnyObject
                    
                    
                    /// loan
                    
                    let loansendemail = jsonData?.value(forKey: "loansendemail") as AnyObject
                    let loansendmobile = jsonData?.value(forKey: "loansendmobile") as AnyObject
                    let loansenddesignation = jsonData?.value(forKey: "loansenddesignation") as AnyObject
                    let loansendphoto = jsonData?.value(forKey: "loansendphoto") as AnyObject
                    
                    
                    let finperkurl = jsonData?.value(forKey: "finperkurl") as AnyObject
                    let finboxurl = jsonData?.value(forKey: "finboxurl") as AnyObject
                    let PBByCrnSearch = jsonData?.value(forKey: "PBByCrnSearch") as AnyObject
                    let LeadDashUrl = jsonData?.value(forKey: "LeadDashUrl") as AnyObject
                    let enableenrolasposp = jsonData?.value(forKey: "enableenrolasposp") as AnyObject
                    let showmyinsurancebusiness = jsonData?.value(forKey: "showmyinsurancebusiness") as AnyObject
                    
                    let fba_uid = jsonData?.value(forKey: "fba_uid") as AnyObject
                    let fba_campaign_id = jsonData?.value(forKey: "fba_campaign_id") as AnyObject
                    let fba_campaign_name = jsonData?.value(forKey: "fba_campaign_name") as AnyObject
                    
                    let iosversion = jsonData?.value(forKey: "iosversion") as AnyObject
                    
                    let referer_code = UserDefaults.standard.string(forKey: "referer_code") as AnyObject
                    
                    
                    
                    UserDefaults.standard.set(String(describing: uid), forKey: "uid")
                    UserDefaults.standard.set(String(describing: iosuid), forKey: "iosuid")
                    UserDefaults.standard.set(String(describing: emplat), forKey: "emplat")
                    UserDefaults.standard.set(String(describing: emplng), forKey: "emplng")
                    UserDefaults.standard.set(String(describing: loanselfemail), forKey: "loanselfemail")
                    UserDefaults.standard.set(String(describing: loanselfmobile), forKey: "loanselfmobile")
                    
                    UserDefaults.standard.set(String(describing: LoginID), forKey: "LoginID")
                    UserDefaults.standard.set(String(describing: ManagName), forKey: "ManagName")
                    UserDefaults.standard.set(String(describing: POSP_STATUS), forKey: "POSP_STATUS")
                    UserDefaults.standard.set(String(describing: MangEmail), forKey: "MangEmail")
                    UserDefaults.standard.set(String(describing: MangMobile), forKey: "MangMobile")
                    UserDefaults.standard.set(String(describing: SuppEmail), forKey: "SuppEmail")
                    UserDefaults.standard.set(String(describing: SuppMobile), forKey: "SuppMobile")
                    UserDefaults.standard.set(String(describing: FBAId), forKey: "FBAId")
                    UserDefaults.standard.set(String(describing: loanselfid), forKey: "loanselfid")
                    UserDefaults.standard.set(String(describing: loansendid), forKey: "loansendid")
                    UserDefaults.standard.set(String(describing: POSPNo), forKey: "POSPNo")
                    UserDefaults.standard.set(String(describing: ERPID), forKey: "ERPID")
                    UserDefaults.standard.set(String(describing: loanselfphoto), forKey: "loanselfphoto")
                    UserDefaults.standard.set(String(describing: TwoWheelerUrl), forKey: "TwoWheelerUrl")
                    UserDefaults.standard.set(String(describing: FourWheelerUrl), forKey: "FourWheelerUrl")
                    
                    UserDefaults.standard.set(String(describing: healthurl), forKey: "healthurl")
                    UserDefaults.standard.set(String(describing: CVUrl), forKey: "CVUrl")
                    UserDefaults.standard.set(String(describing: notificationpopupurl), forKey: "notificationpopupurl")
                    
                    UserDefaults.standard.set(String(describing: pospsendname), forKey: "pospsendname")
                    UserDefaults.standard.set(String(describing: pospsendemail), forKey: "pospsendemail")
                    UserDefaults.standard.set(String(describing: pospsendmobile), forKey: "pospsendmobile")
                    UserDefaults.standard.set(String(describing: pospsenddesignation), forKey: "pospsenddesignation")
                    UserDefaults.standard.set(String(describing: pospsendphoto), forKey: "pospsendphoto")
                    
                    UserDefaults.standard.set(String(describing: loansendname), forKey: "loansendname")
                    UserDefaults.standard.set(String(describing: loansendemail), forKey: "loansendemail")
                    UserDefaults.standard.set(String(describing: loansendmobile), forKey: "loansendmobile")
                    UserDefaults.standard.set(String(describing: loansenddesignation), forKey: "loansenddesignation")
                    UserDefaults.standard.set(String(describing: loansendphoto), forKey: "loansendphoto")
                    
                    UserDefaults.standard.set(String(describing: finperkurl), forKey: "finperkurl")
                    UserDefaults.standard.set(String(describing: finboxurl), forKey: "finboxurl")
                    UserDefaults.standard.set(String(describing: PBByCrnSearch), forKey: "PBByCrnSearch")
                    UserDefaults.standard.set(String(describing: LeadDashUrl), forKey: "LeadDashUrl")
                    UserDefaults.standard.set(String(describing: enableenrolasposp), forKey: "enableenrolasposp")
                    UserDefaults.standard.set(String(describing: showmyinsurancebusiness), forKey: "showmyinsurancebusiness")
                    
                    UserDefaults.standard.set(String(describing: fba_uid), forKey: "fba_uid")
                    UserDefaults.standard.set(String(describing: fba_campaign_id), forKey: "fba_campaign_id")
                    UserDefaults.standard.set(String(describing: fba_campaign_name), forKey: "fba_campaign_name")
                    
                    UserDefaults.standard.set(String(describing: iosversion), forKey: "iosversion")
                    
                    UserDefaults.standard.set(String(describing: referer_code), forKey: "referer_code")
                   
                     
                          ///////////////////////////      Verify  Build Version to  Server    /////////////////////////////////////////////////////////
                                            
                               self.verifyVersion()
                                          
                           ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                          
                          
                  
                    
                }, onError: { errorData in
                    // alertView.close()
                    //            let snackbar = TTGSnackbar.init(message: errorData.errorMessage, duration: .long)
                    //            snackbar.show()
                }, onForceUpgrade: {errorData in})
                
            }else{
                //            let snackbar = TTGSnackbar.init(message: Connectivity.message, duration: .middle )
                //            snackbar.show()
            }
            
        }
        
    }
    
   
    
   
    
    func getdynamicappAPI()
    {
        
        
        if Connectivity.isConnectedToInternet()
        {
            print("internet is available.")
            
            if(UserDefaults.exists(key: "FBAId") == true) {
                
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
                
                let params: [String: AnyObject] = ["fbaid":FBAId as AnyObject]
                
              
                let url = "get-dynamic-app-pb"
                
                FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
                    alertView.close()
                    
                    
                    self.view.layoutIfNeeded()
                    
                    
                    self.dynamicDashboardModel = [DynamicDashboardModel]()
                    
                    let jsonData = userObject as? NSDictionary
                    let Dashboard = jsonData?.value(forKey: "Dashboard") as! NSArray
                    
                    
                    print("MY DATA",Dashboard)
                    
                    for index in 0...(Dashboard.count)-1 {
                        let aObject = Dashboard[index] as! [String : AnyObject]
                        
                        
                        if(aObject["ProdId"] as! String != "16" && aObject["ProdId"] as! String != "18"  ){
                            
                            
                            if(aObject["dashboard_type"] as! String == "1"){
                                
                                let model = DynamicDashboardModel(menuid: aObject["menuid"] as! Int, menuname: aObject["menuname"] as! String,
                                                                  link: aObject["link"] as! String, iconimage:  aObject["iconimage"] as! String,
                                                                  isActive: aObject["isActive"] as! Int, dashdescription: aObject["description"] as! String,
                                                                  modalType: "INSURANCE" , dashboard_type: aObject["dashboard_type"] as! String,
                                                                  
                                                                  ProdId: aObject["ProdId"] as! String, ProductNameFontColor: aObject["ProductNameFontColor"] as! String, ProductDetailsFontColor: aObject["ProductDetailsFontColor"] as! String,
                                                                  ProductBackgroundColor: aObject["ProductBackgroundColor"] as! String,
                                                                  IsExclusive: aObject["IsExclusive"] as! String,
                                                                  IsNewprdClickable: aObject["IsNewprdClickable"] as! String,
                                                                  IsSharable: aObject["IsSharable"] as! String,
                                                                  popupmsg: aObject["popupmsg"] as! String,
                                                                  title: aObject["title"] as! String,
                                                                  info: aObject["info"] as! String)
                                
                                
                               
                                self.dynamicDashboardModel.append(model)
                                
                            }
                            /*   More Service Commented ...
                            else if(aObject["dashboard_type"] as! String == "3" ){
                                
                                let model = DynamicDashboardModel(menuid: aObject["menuid"] as! Int, menuname: aObject["menuname"] as! String,
                                                                  link: aObject["link"] as! String, iconimage:  aObject["iconimage"] as! String,
                                                                  isActive: aObject["isActive"] as! Int, dashdescription: aObject["description"] as! String,
                                                                  modalType: "MORESERVICE" , dashboard_type: aObject["dashboard_type"] as! String,
                                                                  
                                                                  ProdId: aObject["ProdId"] as! String, ProductNameFontColor: aObject["ProductNameFontColor"] as! String, ProductDetailsFontColor: aObject["ProductDetailsFontColor"] as! String,
                                                                  ProductBackgroundColor: aObject["ProductBackgroundColor"] as! String,
                                                                  IsExclusive: aObject["IsExclusive"] as! String,
                                                                  IsNewprdClickable: aObject["IsNewprdClickable"] as! String,
                                                                  IsSharable: aObject["IsSharable"] as! String,
                                                                  popupmsg: aObject["popupmsg"] as! String,
                                                                  title: aObject["title"] as! String,
                                                                  info: aObject["info"] as! String)
                                
                                
                                self.moreServiceModel.append(model)
                            }
                            */
                            
                            
                            
                            
                        }
                        
                        
                
                        
                        DispatchQueue.main.async {
                            self.mainTV.isHidden = false
                            self.mainTV.reloadData()
                        }
                        
                        
                    }
                    
                    
                }, onError: { errorData in
                    alertView.close()
                    let snackbar = TTGSnackbar.init(message: errorData.errorMessage, duration: .long)
                    snackbar.show()
                }, onForceUpgrade: {errorData in})
                
            }
            
        }else{
            let snackbar = TTGSnackbar.init(message: Connectivity.message, duration: .middle )
            snackbar.show()
        }
    }
    
    func getDeviceDetails(){
        
        if Connectivity.isConnectedToInternet()
        {
           
            
            let POSPNo = UserDefaults.standard.string(forKey: "POSPNo") as AnyObject
            
            let parameter  :[String: AnyObject] = [
                
                "ss_id": POSPNo as AnyObject,
                "device_id": getDeviceID() as AnyObject,
                "device_name": getDeviceName() as AnyObject,
                "os_detail": getDeviceOS() as AnyObject,
                "action_type": "active" as AnyObject,
                "device_info" : "" as AnyObject
                
            ]
            let endUrl = "/app_visitor/save_device_details"
            let url =  FinmartRestClient.baseURLROOT  + endUrl
    
            print("urlRequest= ",url)
            print("parameter= ",parameter)
            Alamofire.request(url, method: .post, parameters: parameter,encoding: JSONEncoding.default,headers: FinmartRestClient.headers).responseJSON(completionHandler: { (response) in
                switch response.result {
                    
                case .success(let value):
                    
                
                    guard let data = response.data else { return }
                    do {
                        let decoder = JSONDecoder()
                        let obj = try decoder.decode(DeviceDetailModel.self, from: data)
                        
                        print("response= ",obj)
                        
                        
                    } catch let error {
                        print(error)
                       
                    }
                    
                    
                case .failure(let error):
                    print(error)
                   
                    
                }
            })
            
        }
        
    }
    
    
    //////////////
    
   
    
    func usercallingAPI()
    {
        if Connectivity.isConnectedToInternet()
        {
            print("internet is available.")
            
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
        
        let params: [String: AnyObject] = ["fbaid":FBAId as AnyObject]
        
        let url = "user-calling"
        
        FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
            alertView.close()
            
            self.view.layoutIfNeeded()
            
            let jsonData = userObject as? NSArray
            let EmployeeName = jsonData?.value(forKey: "EmployeeName") as AnyObject
            self.EmployeeNameArray = EmployeeName as! [String]
            let Designation = jsonData!.value(forKey: "Designation") as AnyObject
            self.DesignationArray = Designation as! [String]
            let MobileNo = jsonData?.value(forKey: "MobileNo") as AnyObject
           
            self.MobileNoArray = (MobileNo) as! [String]
            print("CONTACT",self.MobileNoArray )
            let EmailId = jsonData!.value(forKey: "EmailId") as AnyObject
            self.EmailIdArry = EmailId as! [String]
             print("Email",self.EmailIdArry )
            
            self.callingDashboardModel.removeAll()
          //05
            self.popUpbackgroundView.isHidden = false
            for index in 0...(jsonData?.count ?? 0)-1 {
                let aObject = jsonData![index] as! [String : AnyObject]
                
               
                let model  = CallingDashboardModel(MobileNo: aObject["MobileNo"] as! String,
                                                EmailId: aObject["EmailId"] as! String,
                                                EmployeeName: aObject["EmployeeName"] as! String,
                                                Designation: aObject["Designation"] as! String)
            
                self.callingDashboardModel.append(model)

                }
            

            DispatchQueue.main.async {
              
                self.popUpTV.reloadData()
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
    
   
    
    func getShareData(prdID : String){
        
        if Connectivity.isConnectedToInternet()
        {
            print("internet is available.")
            
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
        let POSPNo = UserDefaults.standard.string(forKey: "POSPNo")
       
        let parameter  :[String: AnyObject] = [
            "ss_id": POSPNo as AnyObject,
            "fba_id": FBAId as AnyObject,
            "product_id": prdID as AnyObject,
            "sub_fba_id":"0" as AnyObject
        ]
         let endUrl = "GetShareUrl"
        let url =  FinmartRestClient.baseURLString  + endUrl
     Alamofire.request(url, method: .post, parameters: parameter,encoding: JSONEncoding.default,headers: FinmartRestClient.headers).responseJSON(completionHandler: { (response) in
        switch response.result {
                    
        
           case .success(_):
                
                alertView.close()
            
                self.view.layoutIfNeeded()
                guard let data = response.data else { return }
                do {
                    let decoder = JSONDecoder()
                    let shareModel = try decoder.decode(SharePrdModel.self, from: data)
                    
                    print("Share ",shareModel.MasterData.msg + shareModel.MasterData.url)
                   
                    let strbody = shareModel.MasterData.msg + "\n" + shareModel.MasterData.url
                    self.shareTextData(strBody: strbody)
                    
                } catch let error {
                    print(error)
                    alertView.close()
                    
                    let snackbar = TTGSnackbar.init(message: error as! String, duration: .long)
                    snackbar.show()
                }
                
                
            case .failure(let error):
                print(error)
                 alertView.close()
                let snackbar = TTGSnackbar.init(message: error as! String, duration: .long)
                snackbar.show()
            }
        })
        
        }else{
            let snackbar = TTGSnackbar.init(message: Connectivity.message, duration: .middle )
            snackbar.show()
        }
        
        
    }
    
    
    ///////////
    
    func shareTextData(strBody : String){
        
        
        let text = strBody
        
        // set up activity view controller
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
       
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
        
    }
    
    func getLoanStaticDashboard(){
        
        loanModel = [DynamicDashboardModel]()
        
//        loanModel.append(DynamicDashboardModel(menuid: 0, menuname: "KOTAK GROUP HEALTH CARE",
//                                               link: "", iconimage: "kotak_elite.png", isActive: 1,
//                                               dashdescription: "Exclusive Health Insurance plan for Elite Members. Best in class features @ lower premium.",
//                                               modalType: "LOAN", dashboard_type: "0",
//                                               ProdId: "23",
//                                               ProductNameFontColor: "", ProductDetailsFontColor: "",
//                                               ProductBackgroundColor: "",
//                                               IsExclusive: "Y", IsNewprdClickable: "Y", IsSharable: "Y",
//                                               popupmsg: "Exclusive Health Insurance plan for Elite Members. Best in class features @ lower premium.",
//                                               title: "Kotak Group health Care",
//                                               info: "http://origin-cdnh.policyboss.com/fmweb/GroupHealthCare/update.html"))
        
        
        loanModel.append(DynamicDashboardModel(modalType: "LOAN", ProdId: "4",
                                               menuname: "CREDIT CARD",
                                               dashdescription: "Get instant Credit card approvals with amazing offers & deals.",
                                               iconimage: "credit_card.png"))
        
        loanModel.append(DynamicDashboardModel(modalType: "LOAN", ProdId: "19",
                                               menuname: "PERSONAL LOAN",
                                               dashdescription: "Provide Instant approval for your customers at attractive interest rates.",
                                               iconimage: "personal_loan.png"))
        
        
        loanModel.append(DynamicDashboardModel(modalType: "LOAN", ProdId: "6",
                                               menuname: "BUSINESS LOAN",
                                               dashdescription: "Maximum loan amount at competitive interest rate.",
                                               iconimage: "balance_transfer.png"))
        
        
        loanModel.append(DynamicDashboardModel(modalType: "LOAN", ProdId: "7",
                                               menuname: "HOME LOAN",
                                               dashdescription: "Home loan at best interest rates from over 20+ banks & NBFCs.",
                                               iconimage: "home_loan.png"))
        
        loanModel.append(DynamicDashboardModel(modalType: "LOAN", ProdId: "8",
                                               menuname: "LOAN AGAINST PROPERTY",
                                               dashdescription: "Maximum loan amount at competitive interest rate against the property.",
                                               iconimage: "loan_against_property.png"))
        
        
        loanModel.append(DynamicDashboardModel(modalType: "LOAN", ProdId: "81",
                                               menuname: "CAR LOAN TOP UP",
                                               dashdescription: "Sell car loan Top-Up, upto 200% of the car value of your customer!",
                                               iconimage: "carloan.png"))
        
        
        
        
    }
    
    
    
    /////////
    
    func callWebView(webfromScreen : String ,type :String)  {
        let commonWeb : commonWebVC = self.storyboard?.instantiateViewController(withIdentifier: "stbcommonWebVC") as! commonWebVC
        commonWeb.modalPresentationStyle = .fullScreen
        commonWeb.webfromScreen = webfromScreen
        commonWeb.addType = type
        commonWeb.delegateData = self
        add(commonWeb)    // Adding in Parent View
        deSelectDashboard()
    }
    
    func callbackHomeDelegate() {
     
       // print("TTT  Call back to Parent ")
        self.userconstantAPI()
        self.getdynamicappAPI()
        self.verifyVersion()
        
       }

}

