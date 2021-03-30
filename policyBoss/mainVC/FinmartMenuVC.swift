//
//  FinmartMenuVC.swift
//  MagicFinmart
//
//  Created by Ashwini on 15/12/18.
//  Copyright © 2018 Ashwini. All rights reserved.
//

import UIKit
import CustomIOSAlertView
import TTGSnackbar
import WebKit
//import CobrowseIO
import SafariServices

class FinmartMenuVC: UIViewController,UITableViewDataSource,UITableViewDelegate,WKNavigationDelegate {
    
    //UIScrollViewDelegate
    
    @IBOutlet weak var menuTV: UITableView!
    @IBOutlet weak var menuprofileImgView: UIImageView!
    @IBOutlet weak var fullNameLbl: UILabel!
    @IBOutlet weak var fbaIdLbl: UILabel!
    @IBOutlet weak var refcodeLbl: UILabel!
    @IBOutlet weak var pospNoLbl: UILabel!
    @IBOutlet weak var erpIdLbl: UILabel!
    
    var addType = ""
    


   // @IBOutlet weak var MainScrollView: UIScrollView!
    @IBOutlet weak var versionLbl: UILabel!
   // var myFinItems = ["SHARE SCREEN","HOME","MY FINBOX","FINPERKS"]
      var myFinItems = ["HOME","MY FINBOX","FINPERKS"]
     var myFinImages = ["home.png","mps.png","ic_business_name.png"]
   
     var myaccountItems = ["My Profile","Enrol as POSP","Change Password"]    // 1
     var myaccountImages = ["vector_person.png","posp_enrollment.png","change_password.png"]
    
    
     var myaccountItems2 = ["My Profile","Change Password"]                  // 2
     var myaccountImages2 = ["vector_person.png","change_password.png"]
    
    var mydocumentItems = ["POSP Appointment Letter","POSP Application Form"]
    var mydocumentImges = ["agreemnet.png","agreemnet.png","agreemnet.png"]
    
    var transactionsItems = ["My Insurance Business","Get Policy by CRN"]
    var transactionImges = ["ic_business_name.png","insurance_policy_ic.png"]
    
    var transactionsItems2 = ["Get Policy by CRN"]
    var transactionImges2 = ["insurance_policy_ic.png"]
    
    
    var leadsItems = ["Lead Dashboard"]
    var leadsImges = ["insurance_policy_ic.png"]
    
    
    var loansItems = ["Referral Agreement","Free Credit Report"]
    var loansImges = ["agreemnet.png","agreemnet.png"]
    
    var otherutilitiesItems = ["MORE SERVICES","MY UTILITIES","LOG-OUT"]
    var otherImges = ["ic_business_name.png","posp_training.png","logout.png"]
    
    //    var earningtoolsItmes = ["Loan Agreement","Income Calculator","Income Potential"]
    
    
      var earningToolImges = ["mps.png","income_calculator_ic.png","income_potential_ic.png"]
    //"Loan Agreement",
   // var transactionsItems = ["My Insurance Business","My Transactions","My Messages","Get Policy by CRN"]
//    var earningtoolsItmes = ["Loan Agreement","Income Calculator","Income Potential"]
    
    // var myaccountItems = ["My Profile","Enrol as POSP","Raise a Ticket","Change Password"]
    //var myaccountItems2 = ["My Profile","Add Sub User","Raise a Ticket","Change Password"]
    
//     var leadsItems = ["Create Lead Contact","Generate Motor Leads","Generate Loan Leads","Lead Dashboard","Sms Templates"]
//     var leadsImges = ["sync_contact_ic.png","vehicledetail.png","share_data.png","insurance_policy_ic.png","mps.png"]
    
//    var pospItems = ["Enrol as POSP","Add Users"]
//    var requestItems = ["Offline Quotes","Request Policy by CRN"]
//    var otherutilitiesItems = ["MORE SERVICES","MY UTILITIES","WHAT'S NEW","LOG-OUT"]
//       var otherImges = ["ic_business_name.png","posp_training.png","whats_new.png","logout.png"]
    
    
    var attendanceItems = ["Add Attendance","My Location","Report"]
    //--<cellImages>--
  //  var myFinImages = ["","home.png","mps.png","ic_business_name.png"]
  
 
    //  var myaccountImages = ["vector_person.png","posp_enrollment.png","posp_enrollment.png","change_password.png"]
  
    
   // var transactionImges = ["ic_business_name.png","vector_date.png","sms.png","insurance_policy_ic.png"]
  
   
    var pospImges = ["posp_enrollment.png","posp_enrollment.png"]
    var requestImges = ["insurance_policy_ic.png","insurance_policy_ic.png"]
  //  var otherImges = ["income_potential_ic.png","ic_business_name.png","posp_training.png","whats_new.png","logout.png"]
    var fromScreen = ""
    var appaccessStatus = ""
    var isfirstLogin = Int()
    var enableenrolasPOSP = ""
    var showmyinsurancebusiness = ""
    
    // For AlertDialog
    let alertService = AlertService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        versionLbl.text = "Ver." + Configuration.appVersion
        
         // MainScrollView.isScrollEnabled = false
        
     
        //--<api>--
        userconstantAPI()
        //CheckAppAccessAPI()
        
        
  }
    
    
    func deSelectDashboard(){
        
        if let index = menuTV.indexPathForSelectedRow{
            self.menuTV.deselectRow(at: index, animated: true)
        }
    }
    
    
    
    
    @IBAction func menuViewBtnCliked(_ sender: Any)
    {
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.view.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
            self.view.layoutIfNeeded()
            self.view.backgroundColor = UIColor.clear
        }, completion: { (finished) -> Void in
            self.view.removeFromSuperview()
            self.removeFromParent()
        })
    }
    
    //--<roundImageView>--
    override func viewDidLayoutSubviews()
    {
        menuprofileImgView.layer.cornerRadius = menuprofileImgView.frame.size.width/2
        menuprofileImgView.clipsToBounds = true
    }
    
    @IBAction func knowUrFinmartBtnCliked(_ sender: Any)
    {
//        let notipopupurl : notipopupurlVC = self.storyboard?.instantiateViewController(withIdentifier: "stbnotipopupurlVC") as! notipopupurlVC
//        present(notipopupurl, animated: true, completion: nil)
//
      
        
        let url = UserDefaults.standard.string(forKey: "notificationpopupurl")

        guard let popupUrl = url else {
            return
        }
        let alertWebVC = self.alertService.alertWebView(webURL: popupUrl)
        self.present(alertWebVC, animated: true)

    }
   
    @IBAction func menuhomeBtnCliked(_ sender: Any)
    {
        
        let KYDrawer : KYDrawerController = self.storyboard?.instantiateViewController(withIdentifier: "stbKYDrawerController") as! KYDrawerController
        KYDrawer.modalPresentationStyle = .fullScreen
        present(KYDrawer, animated: true, completion: nil)
     
    }
    
    @IBAction func myFinboxBtnCliked(_ sender: Any)
    {
        let commonWeb : commonWebVC = self.storyboard?.instantiateViewController(withIdentifier: "stbcommonWebVC") as! commonWebVC
        commonWeb.webfromScreen = "myFinbox"
        commonWeb.modalPresentationStyle = .fullScreen

        present(commonWeb, animated: true, completion: nil)
        
        
    }
    
    @IBAction func myFinperksBtnCliked(_ sender: Any)
    {
        let commonWeb : commonWebVC = self.storyboard?.instantiateViewController(withIdentifier: "stbcommonWebVC") as! commonWebVC
        commonWeb.webfromScreen = "Finperks"
        commonWeb.modalPresentationStyle = .fullScreen
        present(commonWeb, animated: true, completion: nil)
    }
    
    
    //-----<tableView Datasource+Deleagtes>-----
    func numberOfSections(in tableView: UITableView) -> Int {
//        if(self.appaccessStatus == "Active"){
//            return 7
//        }
//        else{
//            return 6
//        }
        
        return 6
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(section == 0){
            return myFinItems.count
        }else if(section == 1){
            if(self.enableenrolasPOSP == "1"){
                return myaccountItems.count
            }
            else if(self.enableenrolasPOSP == "0"){
                return myaccountItems2.count
            }
             return myaccountItems2.count
        }
        else if(section == 2){
            return mydocumentItems.count
        }
        else if(section == 3){
            
            if(self.showmyinsurancebusiness == "1"){
                return transactionsItems.count
            }
            else if(self.showmyinsurancebusiness == "0"){
                return transactionsItems2.count
            }
            return transactionsItems2.count
        }
        else if(section == 4){
            return leadsItems.count
        }
//        else if(section == 5){
//            return loansItems.count
//        }
       else if(section == 5){
            return otherutilitiesItems.count
        }
        return 0
        
        
      //  loansItems
//        if(self.appaccessStatus == "Active")
//        {
//            if(section == 5){
//                return attendanceItems.count
//            }
//            else if(section == 6){
//                return otherutilitiesItems.count
//            }
//            else {
//                return 0
//            }
//        }
//        else{
//            if(section == 5){
//                return otherutilitiesItems.count
//            }
//            else{
//                return 0
//            }
//        }
        
      

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as! finmartMenuCell
        cell.textLabel?.textColor = UIColor.gray
        
        if(indexPath.section == 0){
            cell.cellLbl?.text = myFinItems[indexPath.row]
            cell.cellImgs.image = UIImage(named: myFinImages[indexPath.row])
        }
        else if(indexPath.section == 1){
            if(self.enableenrolasPOSP == "1"){
                cell.cellLbl?.text = myaccountItems[indexPath.row]
                cell.cellImgs.image = UIImage(named: myaccountImages[indexPath.row])
            }
            else if(self.enableenrolasPOSP == "0"){
                cell.cellLbl?.text = myaccountItems2[indexPath.row]
                cell.cellImgs.image = UIImage(named: myaccountImages2[indexPath.row])
            }
        }
        else if(indexPath.section == 2){
            cell.cellLbl?.text = mydocumentItems[indexPath.row]
            cell.cellImgs.image = UIImage(named: mydocumentImges[indexPath.row])
        }
        else if(indexPath.section == 3){
           
            
            if(self.showmyinsurancebusiness == "1"){
                cell.cellLbl?.text = transactionsItems[indexPath.row]
                cell.cellImgs.image = UIImage(named: transactionImges[indexPath.row])
                
            }
            else if(self.showmyinsurancebusiness == "0"){
                cell.cellLbl?.text = transactionsItems2[indexPath.row]
                cell.cellImgs.image = UIImage(named: transactionImges2[indexPath.row])
                
            }
        }
        else if(indexPath.section == 4){
            cell.cellLbl?.text = leadsItems[indexPath.row]
            cell.cellImgs.image = UIImage(named: leadsImges[indexPath.row])
        }
//        else if(indexPath.section == 5){
//            cell.cellLbl?.text = loansItems[indexPath.row]
//            cell.cellImgs.image = UIImage(named: loansImges[indexPath.row])
//        }
        else if(indexPath.section == 5){
            cell.cellLbl?.text = otherutilitiesItems[indexPath.row]
            cell.cellImgs.image = UIImage(named: otherImges[indexPath.row])
        }
            
//        else if(self.appaccessStatus == "Active")
//        {
//            if(indexPath.section == 5){
//                cell.cellLbl?.text = attendanceItems[indexPath.row]
//                cell.cellImgs.image = UIImage(named: earningToolImges[indexPath.row])
//            }
//            else if(indexPath.section == 6){
//                cell.cellLbl?.text = otherutilitiesItems[indexPath.row]
//                cell.cellImgs.image = UIImage(named: otherImges[indexPath.row])
//            }
//        }
//        else{
//            if(indexPath.section == 6){
//                cell.cellLbl?.text = otherutilitiesItems[indexPath.row]
//                cell.cellImgs.image = UIImage(named: otherImges[indexPath.row])
//            }
//        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
//    override func updateViewConstraints() {
//        tableHeightConstraint.constant = tableView.contentSize.height
//        super.updateViewConstraints()
//
//    }
    
    
 
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView:UIView =  UIView()
        headerView.backgroundColor = UIColor.white
    
        let label = UILabel()
        label.frame = CGRect.init(x: 15, y: 10, width: 200, height: 30)

        if(section == 0)
        {
            label.text = ""
        }
        else if(section == 1)
        {
            label.text = "MY ACCOUNT"
        }
        else if(section == 2)
        {
            label.text = "MY DOCUMENTS"
        }
        else if(section == 3)
        {
            label.text = "MY TRANSACTIONS"
        }
        else if(section == 4)
        {
            label.text = "MY LEADS"
        }
//        else if(section == 5)
//        {
//            label.text = "LOANS"
//        }
            
//        else if(self.appaccessStatus == "Active")
//        {
//           if(section == 5)
//            {
//                label.text = "ATTENDANCE"
//            }
//            else if(section == 6)
//            {
//                label.text = "OTHER UTILITIES"
//            }
//        }
        else
        {
            if(section == 5)
            {
                label.text = "OTHER UTILITIES"
            }
        }

        //        label.font = UIFont().futuraPTMediumFont(16) // my custom font
        label.font = UIFont.boldSystemFont(ofSize: 16)
        //        label.textColor = UIColor.charcolBlackColour() // my custom colour
        label.textColor = UIColor.gray
        headerView.addSubview(label)

        return headerView

    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section == 0)
        {
            return 0
        }else{
            return 40
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView:UIView =  UIView()
        footerView.backgroundColor = UIColor.lightGray
        
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // close the drawer
        if let drawerController = navigationController?.parent as? KYDrawerController {
            drawerController.setDrawerState(.closed, animated: false)
        }
      
      /***************************** Home SECTION ******************************/
        if(indexPath.section == 0)
        {
//            if(indexPath.row == 0)
//            {
//                let sessionController = CBIOViewController()
//                present(sessionController, animated: true, completion: nil)
////                self.navigationController?.pushViewController(sessionController, animated: true)
//            }
             if(indexPath.row == 0)
            {
                let KYDrawer : KYDrawerController = self.storyboard?.instantiateViewController(withIdentifier: "stbKYDrawerController") as! KYDrawerController
                  KYDrawer.modalPresentationStyle = .fullScreen
                present(KYDrawer, animated: true, completion: nil)
            }
            else if(indexPath.row == 1)     // FINBOX
            {
                
                // 05
                
                let commonWeb : commonWebVC = self.storyboard?.instantiateViewController(withIdentifier: "stbcommonWebVC") as! commonWebVC
                commonWeb.modalPresentationStyle = .fullScreen
                commonWeb.webfromScreen = "myFinbox"
                present(commonWeb, animated: true, completion: nil)
                
             
              
            }
            else if(indexPath.row == 2)
            {
                let commonWeb : commonWebVC = self.storyboard?.instantiateViewController(withIdentifier: "stbcommonWebVC") as! commonWebVC
                commonWeb.modalPresentationStyle = .fullScreen
                commonWeb.webfromScreen = "Finperks"
                present(commonWeb, animated: true, completion: nil)
            }
           
        }
        //myaccount
        /*****************************  MY ACCOUNT SECTION ******************************/
        if(indexPath.section == 1)
        {
            if(indexPath.row == 0)
            {
                let profile : profileVC = self.storyboard?.instantiateViewController(withIdentifier: "stbprofileVC") as! profileVC
                profile.modalPresentationStyle = .fullScreen
                present(profile, animated: true, completion: nil)
            }
            else if(indexPath.row == 1)
            {
                if(self.enableenrolasPOSP == "1")
                {
                    let enrolasPOSP : enrolasPOSPVC = self.storyboard?.instantiateViewController(withIdentifier: "stbenrolasPOSPVC") as! enrolasPOSPVC
                    enrolasPOSP.modalPresentationStyle = .fullScreen
                    present(enrolasPOSP, animated: true, completion: nil)
                }
                else
                {
                    // For myaccountItems2 array changePasswrdVC position is 2 ie index 1
                    // hence when enrolasPOSP = 0  than myaccountItems2 array will load
                    let changePasswrd : changePasswrdVC = self.storyboard?.instantiateViewController(withIdentifier: "stbchangePasswrdVC") as! changePasswrdVC
                     changePasswrd.modalPresentationStyle = .fullScreen
                    present(changePasswrd, animated: true, completion: nil)
                }
                
            }
//            else if(indexPath.row == 2)
//            {
//                let hnfraiseTickt : hnfraiseTicktVC = self.storyboard?.instantiateViewController(withIdentifier: "stbhnfraiseTicktVC") as! hnfraiseTicktVC
//                present(hnfraiseTickt, animated: true, completion: nil)
//            }
            else if(indexPath.row == 2)
            {
                let changePasswrd : changePasswrdVC = self.storyboard?.instantiateViewController(withIdentifier: "stbchangePasswrdVC") as! changePasswrdVC
                changePasswrd.modalPresentationStyle = .fullScreen
                present(changePasswrd, animated: true, completion: nil)
            }
        }
        //mydocument
            
     /*****************************  MY DOCUMENT SECTION ******************************/
        else if(indexPath.section == 2)
        {
//            if(indexPath.row == 0)
//            {
//
//                let commonWeb : commonWebVC = self.storyboard?.instantiateViewController(withIdentifier: "stbcommonWebVC") as! commonWebVC
//                commonWeb.webfromScreen = "loanAgreement"
//                present(commonWeb, animated: true, completion: nil)
//            }
             if(indexPath.row == 0)
            {
                let incmCalculatr : incmCalculatrVC = self.storyboard?.instantiateViewController(withIdentifier: "stbincmCalculatrVC") as! incmCalculatrVC
                incmCalculatr.modalPresentationStyle = .fullScreen
                incmCalculatr.fromScreen = "appoinLetter"
                present(incmCalculatr, animated: true, completion: nil)
            }
            else if(indexPath.row == 1)
            {
                let incmCalculatr : incmCalculatrVC = self.storyboard?.instantiateViewController(withIdentifier: "stbincmCalculatrVC") as! incmCalculatrVC
                incmCalculatr.modalPresentationStyle = .fullScreen
                incmCalculatr.fromScreen = "ApplictnForm"
                present(incmCalculatr, animated: true, completion: nil)
            }
        }
        //mytransactions
            
     /*****************************  MY TRANSACTION SECTION ******************************/
        else if(indexPath.section == 3)
        {
//            if(indexPath.row == 0)
//            {
////                let mpsV : mpsVC = self.storyboard?.instantiateViewController(withIdentifier: "stbmpsVC") as! mpsVC
////                present(mpsV, animated: true, completion: nil)
////                self.view.removeFromSuperview()
////                self.removeFromParent()
//                let commonWeb : commonWebVC = self.storyboard?.instantiateViewController(withIdentifier: "stbcommonWebVC") as! commonWebVC
//                commonWeb.webfromScreen = "myBusiness"
//                present(commonWeb, animated: true, completion: nil)
//            }
//            else if(indexPath.row == 1)
//            {
//                let transctionHistory : transctionHistoryVC = self.storyboard?.instantiateViewController(withIdentifier: "stbtransctionHistoryVC") as! transctionHistoryVC
//                present(transctionHistory, animated: true, completion: nil)
//            }
//            else if(indexPath.row == 2)
//            {
//                let commonWeb : commonWebVC = self.storyboard?.instantiateViewController(withIdentifier: "stbcommonWebVC") as! commonWebVC
//                commonWeb.webfromScreen = "messageCenter"
//                present(commonWeb, animated: true, completion: nil)
//            }
           
            if(indexPath.row == 0)
            {
              
              
                
                if(self.showmyinsurancebusiness == "1")
                {
                    let commonWeb : InsuranceBussWebVC = self.storyboard?.instantiateViewController(withIdentifier: "InsuranceBussWebVC") as! InsuranceBussWebVC
                    commonWeb.modalPresentationStyle = .fullScreen
                    commonWeb.webfromScreen = "InsuranceBusiness"
                    present(commonWeb, animated: true, completion: nil)
                }
                else
                {
                    // For transactionsItems2 array policyByCRN position is 1 ie index 0
                    // hence when showmyinsurancebusiness = 0  than transactionsItems2 array will load
                    let commonWeb : commonWebVC = self.storyboard?.instantiateViewController(withIdentifier: "stbcommonWebVC") as! commonWebVC
                    commonWeb.modalPresentationStyle = .fullScreen
                    commonWeb.webfromScreen = "policyByCRN"
                    present(commonWeb, animated: true, completion: nil)
                }
                            
                
            }
           else  if(indexPath.row == 1)
            {
//                let reqpolicy : reqpolicyVC = self.storyboard?.instantiateViewController(withIdentifier: "stbreqpolicyVC") as! reqpolicyVC
//                present(reqpolicy, animated: true, completion: nil)
                
                
           let commonWeb : commonWebVC = self.storyboard?.instantiateViewController(withIdentifier: "stbcommonWebVC") as! commonWebVC
                 commonWeb.modalPresentationStyle = .fullScreen
                  commonWeb.webfromScreen = "policyByCRN"
                  present(commonWeb, animated: true, completion: nil)
            }
        }
        //myleads
            
         /*****************************  MY LEADS SECTION ******************************/
        else if(indexPath.section == 4)
        {
            
            if(indexPath.row == 0)
            {
                let commonWeb : commonWebVC = self.storyboard?.instantiateViewController(withIdentifier: "stbcommonWebVC") as! commonWebVC
                commonWeb.modalPresentationStyle = .fullScreen
                commonWeb.webfromScreen = "leadDashboard"
                present(commonWeb, animated: true, completion: nil)
            }
//            if(indexPath.row == 0)
//            {
//                let syncContacts : syncContactsVC = self.storyboard?.instantiateViewController(withIdentifier: "stbsyncContactsVC") as! syncContactsVC
//                present(syncContacts, animated: true, completion: nil)
//            }
//            else if(indexPath.row == 1)
//            {
//                let motorInsurance : motorInsuranceVC = self.storyboard?.instantiateViewController(withIdentifier: "stbmotorInsuranceVC") as! motorInsuranceVC
//                present(motorInsurance, animated: true, completion: nil)
//            }
//            else if(indexPath.row == 2)
//            {
//                let loans_shareData : loans_shareData_VC = self.storyboard?.instantiateViewController(withIdentifier: "stbloans_shareData_VC") as! loans_shareData_VC
//                present(loans_shareData, animated: true, completion: nil)
//            }
//            else if(indexPath.row == 3)
//            {
//                let commonWeb : commonWebVC = self.storyboard?.instantiateViewController(withIdentifier: "stbcommonWebVC") as! commonWebVC
//                commonWeb.webfromScreen = "leadDashboard"
//                present(commonWeb, animated: true, completion: nil)
//            }
//            else if(indexPath.row == 4)
//            {
//                let smsTemplate : smsTemplateVC = self.storyboard?.instantiateViewController(withIdentifier: "stbsmsTemplateVC") as! smsTemplateVC
//                present(smsTemplate, animated: true, completion: nil)
//            }
            
            
        }
        
        
////////////////////////// Commented  ////////////////////////////
        
        
//        if(self.appaccessStatus == "Active")
//        {
//            attendance
//            if(indexPath.section == 5)
//            {
//                if(indexPath.row == 0)
//                {
//                    if(isfirstLogin == 1)
//                    {
//                        let attendenceRegistratn : attendenceRegistratnVC = self.storyboard?.instantiateViewController(withIdentifier: "stbattendenceRegistratnVC") as! attendenceRegistratnVC
//                        present(attendenceRegistratn, animated: true, completion: nil)
//                    }
//                    else{
//                        let addAttendance : addAttendanceVC = self.storyboard?.instantiateViewController(withIdentifier: "stbaddAttendanceVC") as! addAttendanceVC
//                        present(addAttendance, animated: true, completion: nil)
//                    }
//                }
//                else if(indexPath.row == 1)
//                {
//                    let myLocation : myLocationVC = self.storyboard?.instantiateViewController(withIdentifier: "stbmyLocationVC") as! myLocationVC
//                    present(myLocation, animated: true, completion: nil)
//                }
//                else if(indexPath.row == 2)
//                {
//                    let attenReport : attenReportVC = self.storyboard?.instantiateViewController(withIdentifier: "stbattenReportVC") as! attenReportVC
//                    present(attenReport, animated: true, completion: nil)
//                }
//            }
//
//            else if(indexPath.section == 6)
//            {
//                if(indexPath.row == 0)
//                {
//                    let addUsersV : addUsersVC = storyboard?.instantiateViewController(withIdentifier: "stbaddUsersVC") as! addUsersVC
//                    addUsersV.fromScreen = "otherloanProduct"
//                    present(addUsersV, animated: true, completion: nil)
//
//                }
//                else if(indexPath.row == 1)
//                {
//                                    let helpnfeedback : helpnfeedbackVC = self.storyboard?.instantiateViewController(withIdentifier: "stbhelpnfeedbackVC") as! helpnfeedbackVC
//                                    present(helpnfeedback, animated: true, completion: nil)
//                    let addUsersV : addUsersVC = storyboard?.instantiateViewController(withIdentifier: "stbaddUsersVC") as! addUsersVC
//                    addUsersV.fromScreen = "moreServices"
//                    present(addUsersV, animated: true, completion: nil)
//                }
//                else if(indexPath.row == 2)
//                {
//                                    let commonWeb : commonWebVC = self.storyboard?.instantiateViewController(withIdentifier: "stbcommonWebVC") as! commonWebVC
//                                    commonWeb.webfromScreen = "Training"
//                                    present(commonWeb, animated: true, completion: nil)
//                    let addUsersV : addUsersVC = storyboard?.instantiateViewController(withIdentifier: "stbaddUsersVC") as! addUsersVC
//                    addUsersV.fromScreen = "myUtilities"
//                    present(addUsersV, animated: true, completion: nil)
//                }
//                else if(indexPath.row == 3)
//                {
//                                    let commonWeb : commonWebVC = self.storyboard?.instantiateViewController(withIdentifier: "stbcommonWebVC") as! commonWebVC
//                                    commonWeb.webfromScreen = "leadDetails"
//                                    present(commonWeb, animated: true, completion: nil)
//                    let whatsNew : whatsNewVC = self.storyboard?.instantiateViewController(withIdentifier: "stbwhatsNewVC") as! whatsNewVC
//                    present(whatsNew, animated: true, completion: nil)
//                }
//                if(indexPath.row == 4)
//                {
//                    callAlertView()
//                }
//            }
//        }
            
        
        // End commented
            
    /*****************************  LOANS SECTION ******************************/
//        else  if(indexPath.section == 5)
//        {
//            if(indexPath.row == 0)
//            {
//                let StrURL = "http://erp.rupeeboss.com/FM/Franchise_Agreement.pdf"
//                let Url = NSURL(string: StrURL )
//                let svc = SFSafariViewController(url: Url! as URL)
//                 svc.modalPresentationStyle =  .fullScreen
//                self.present(svc, animated: true, completion: nil)
//
//
//            } else if(indexPath.row == 1)
//            {
//                 let FBAId = UserDefaults.standard.string(forKey: "FBAId")
//                let StrURL = "http://www.rupeeboss.com/equifax-finmart?fbaid=" + (FBAId!)
//                let Url = NSURL(string: StrURL )
//                let svc = SFSafariViewController(url: Url! as URL)
//                svc.modalPresentationStyle =  .fullScreen
//                self.present(svc, animated: true, completion: nil)
//            }
//
//        }
       
   /*****************************  OTHER SECTION ******************************/
       else  if(indexPath.section == 5)
            {
//                if(indexPath.row == 0)
//                {
//                    let addUsersV : addUsersVC = storyboard?.instantiateViewController(withIdentifier: "stbaddUsersVC") as! addUsersVC
//                    addUsersV.fromScreen = "otherloanProduct"
//                    present(addUsersV, animated: true, completion: nil)
//
//                }
                 if(indexPath.row == 0)
                {
                    //                let helpnfeedback : helpnfeedbackVC = self.storyboard?.instantiateViewController(withIdentifier: "stbhelpnfeedbackVC") as! helpnfeedbackVC
                    //                present(helpnfeedback, animated: true, completion: nil)
                    let addUsersV : addUsersVC = storyboard?.instantiateViewController(withIdentifier: "stbaddUsersVC") as! addUsersVC
                    addUsersV.modalPresentationStyle = .fullScreen
                    addUsersV.fromScreen = "moreServices"
                    present(addUsersV, animated: true, completion: nil)
                }
                else if(indexPath.row == 1)
                {
        
                    let addUsersV : addUsersVC = storyboard?.instantiateViewController(withIdentifier: "stbaddUsersVC") as! addUsersVC
                    addUsersV.modalPresentationStyle = .fullScreen
                    addUsersV.fromScreen = "myUtilities"
                    present(addUsersV, animated: true, completion: nil)
                }
//                else if(indexPath.row == 2)
//                {
//                    //                let commonWeb : commonWebVC = self.storyboard?.instantiateViewController(withIdentifier: "stbcommonWebVC") as! commonWebVC
//                    //                commonWeb.webfromScreen = "leadDetails"
//                    //                present(commonWeb, animated: true, completion: nil)
//                    let whatsNew : whatsNewVC = self.storyboard?.instantiateViewController(withIdentifier: "stbwhatsNewVC") as! whatsNewVC
//                    present(whatsNew, animated: true, completion: nil)
//                }
                if(indexPath.row == 2)
                {
                    callAlertView()
                }
            }
        
        
        
    }
    //-----<end tableView Datasource+Deleagtes>-----
    
    
    //---<APICALL>---
    func CheckAppAccessAPI()
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
        
        let iosuid = UserDefaults.standard.string(forKey: "iosuid")
//        print("iosuid=",iosuid!)
        let deviceID = UIDevice.current.identifierForVendor?.uuidString
        
        let params: [String: AnyObject] = ["uid": iosuid as AnyObject,
                                           "DeviceId": deviceID as AnyObject,
                                           "DeviceToken":"t2" as AnyObject]
        
        let url = "/AttendanceDetails.svc/CheckAppAccess_IOS"
        
        FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
            alertView.close()
            
            self.view.layoutIfNeeded()
            
            let jsonData = userObject as? NSDictionary
            
            let empstatus = jsonData?.value(forKey: "empstatus") as AnyObject
            self.appaccessStatus = empstatus as! String
            let isfirstlogin = jsonData?.value(forKey: "isfirstlogin") as AnyObject
            self.isfirstLogin = isfirstlogin as! Int
           // let lat = jsonData?.value(forKey: "lat") as AnyObject
           // let lng = jsonData?.value(forKey: "lng") as AnyObject
            let hrmsid = jsonData?.value(forKey: "hrmsid") as AnyObject
            UserDefaults.standard.set(String(describing: hrmsid), forKey: "hrmsid")
            
            self.menuTV.reloadData()
            
        }, onError: { errorData in
            alertView.close()
            let snackbar = TTGSnackbar.init(message: errorData.errorMessage, duration: .long)
            snackbar.show()
        }, onForceUpgrade: {errorData in},service: true)
            
        
        }else{
            let snackbar = TTGSnackbar.init(message: Connectivity.message, duration: .middle )
            snackbar.show()
        }
        
    }
    
    func bindMenuData(){
        
      
        if(UserDefaults.exists(key: "FBAId") == false) {
            
            userconstantAPI()
            print("User Constant Called")
        }else{
            
            let FBAId = UserDefaults.standard.string(forKey: "FBAId")
            let loansendname = UserDefaults.standard.string(forKey: "loansendname")
            let POSPNo = UserDefaults.standard.string(forKey: "POSPNo")
            let ERPID = UserDefaults.standard.string(forKey: "ERPID")
            
            let loanselfphoto = UserDefaults.standard.string(forKey: "loanselfphoto")
            let enableenrolasposp = UserDefaults.standard.string(forKey: "enableenrolasposp")
            let showmyinsurancebusiness = UserDefaults.standard.string(forKey: "showmyinsurancebusiness")
            let referer_code = UserDefaults.standard.string(forKey: "referer_code")
            
            self.fullNameLbl.text! = loansendname?.uppercased() ?? ""
            self.fbaIdLbl.text! = FBAId!
            self.pospNoLbl.text! = POSPNo!
            self.erpIdLbl.text! = ERPID ?? "0"
            self.refcodeLbl.text! = referer_code ?? ""
            
            self.enableenrolasPOSP = enableenrolasposp!
            self.showmyinsurancebusiness = showmyinsurancebusiness!
            
            if(loanselfphoto != ""){
                //loadimages
                let imgURL = NSURL(string: loanselfphoto! )
                if imgURL != nil {
                    let data = NSData(contentsOf: (imgURL as URL?)!)
                    
                    self.menuprofileImgView.sd_setImage(with: imgURL as URL?)
                    // self.menuprofileImgView.image = UIImage(data: data! as Data)    // 05 error
                }
            }
            
            self.menuTV.reloadData()
        }
        
    }
    
    func userconstantAPI()
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
        
        let params: [String: AnyObject] = ["fbaid":FBAId as AnyObject]
        
        let url = "/api/user-constant"
    //  let url = "/api/user-constant-pb"
        
        FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
            alertView.close()
            
            self.view.layoutIfNeeded()
            
            let jsonData = userObject as? NSDictionary
            
            let loansendname = jsonData?.value(forKey: "loansendname") as AnyObject
            let FBAId = jsonData?.value(forKey: "FBAId") as AnyObject
            let POSPNo = jsonData?.value(forKey: "POSPNo") as AnyObject
            let ERPID = jsonData?.value(forKey: "ERPID") as AnyObject
            let loanselfphoto = jsonData?.value(forKey: "loanselfphoto") as AnyObject
            let referer_code = UserDefaults.standard.string(forKey: "referer_code")
           
            let enableenrolasposp = jsonData?.value(forKey: "enableenrolasposp") as AnyObject
            let showmyinsurancebusiness = jsonData?.value(forKey: "showmyinsurancebusiness") as AnyObject
            
            self.enableenrolasPOSP = enableenrolasposp as! String
            self.showmyinsurancebusiness = showmyinsurancebusiness as! String
            
            UserDefaults.standard.set(String(describing: ERPID), forKey: "ERPID")
            
                self.fullNameLbl.text! = loansendname.uppercased
                self.fbaIdLbl.text! = FBAId as! String
                self.pospNoLbl.text! = POSPNo as! String
                self.erpIdLbl.text! = ERPID as! String
                self.refcodeLbl.text! = referer_code as! String
            
            if(loanselfphoto as! String != ""){
                //loadimages
                let imgURL = NSURL(string: loanselfphoto as! String)
                if imgURL != nil {
                    let data = NSData(contentsOf: (imgURL as URL?)!)
                  
                    self.menuprofileImgView.sd_setImage(with: imgURL as URL?)
                   // self.menuprofileImgView.image = UIImage(data: data! as Data)    // 05 error
                }
            }
            
            self.menuTV.reloadData()
            
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
    
    
    //--<callAlert>--
    func callAlertView()
    {
        // Create the alert controller
        let alertController = UIAlertController(title: "", message: "Do you really want to logout?", preferredStyle: .alert)
        // Create the actions
        let okAction = UIAlertAction(title: "Logout", style: UIAlertAction.Style.default) {
            UIAlertAction in
            NSLog("OK Pressed")
            
            
        

            let Login : LoginVC = self.storyboard?.instantiateViewController(withIdentifier: "stbLoginVC") as! LoginVC
            Login.resetDefaults()
            UserDefaults.standard.set(String(describing: "0"), forKey: "IsFirstLogin")
            Login.modalPresentationStyle = .fullScreen
            self.present(Login, animated: true, completion: nil)
            
            
//              self.resetDefaults()
//             UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: true, completion: nil)
//            
            
          //  In Swift 5.3: When we use stack Navigation
            //self.navigationController?.popToRootViewController(animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default) {
            UIAlertAction in
            NSLog("Cancel Pressed")
        }
        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
    }
    
    func resetDefaults() {
          let defaults = UserDefaults.standard
          // let dictionary = defaults.dictionaryRepresentation()
          defaults.dictionaryRepresentation().keys.forEach(defaults.removeObject(forKey:))
          Core.shared.setNewUser()
           
      }
    
    
        
}


