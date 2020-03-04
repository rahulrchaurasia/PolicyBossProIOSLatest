//
//  cmnloancityDetailsVC.swift
//  MagicFinmart
//
//  Created by iOS Developer on 19/07/19.
//  Copyright © 2019 Ashwini. All rights reserved.
//

import UIKit
import CustomIOSAlertView
import TTGSnackbar

class cmnloancityDetailsVC: UIViewController,UITableViewDataSource,UITableViewDelegate,loanDetailsDelegates,closeDetailsDelegates {
  
    @IBOutlet weak var viewTitleLbl: UILabel!
    @IBOutlet weak var homeLView: UIView!
    @IBOutlet weak var homeLViewHeight: NSLayoutConstraint!//90
    @IBOutlet weak var personlLView: UIView!
    @IBOutlet weak var persnlLViewHeight: NSLayoutConstraint!//120
    @IBOutlet weak var businessLView: UIView!
    @IBOutlet weak var bisnessLViewHeight: NSLayoutConstraint!//80
    @IBOutlet weak var loanTV: UITableView!
    @IBOutlet weak var selectloanamountTf: ACFloatingTextfield!
    @IBOutlet weak var tenureInyearTf: ACFloatingTextfield!
    @IBOutlet weak var perloanAmountTf: ACFloatingTextfield!
    @IBOutlet weak var busiloanAmountTf: ACFloatingTextfield!
    @IBOutlet weak var homeLyrSlider: UISlider!
    @IBOutlet weak var persnlLyrSlider: UISlider!
    @IBOutlet weak var tenurepnt6Btn: UIButton!
    @IBOutlet weak var tenure1Btn: UIButton!
    @IBOutlet weak var tenure2Btn: UIButton!
    @IBOutlet weak var tenure3Btn: UIButton!
    @IBOutlet weak var tenure4Btn: UIButton!
    @IBOutlet weak var tenure5Btn: UIButton!
    @IBOutlet weak var slcttenure1Btn: UIButton!
    @IBOutlet weak var slcttenure2Btn: UIButton!
    @IBOutlet weak var slcttenure3Btn: UIButton!
    //-<tableView>-
    private let headerIdentifier = "headerCell"
    private let cellIdentifier = "contentCell"
    private var sectionIsExpanded = [Bool]()
    private var numberOfActualRowsForSection = Int()
    var fbestroiArray = [String]()
    var femiArray = [String]()
    var fprocessingArray = [String]()
    var fbankImgArray = [String]()
    var ssegmentArray = [String]()
    var sproductArray = [String]()
    var sproductTypeArray = [String]()
    var sbestroiArray = [String]()
    var sperlacEmiArray = [String]()
    var sloanAmountArray = [String]()
    var stenureArray = [String]()
    var sageArray = [String]()
    var sminsalryArray = [String]()
    var sminwrokexpArray = [String]()
    var sprocessingfeeArray = [String]()
    var smincibilscoreArray = [String]()
    var sforecloArray = [String]()
    var sprepaymentArray = [String]()
    var bankURLArray = [String]()
    var bankNameArray = [String]()
    var citiesId = ""
    var titlLabel = ""
    var productID = ""
    var lstCityProdBank = [AnyObject]()
//    var emiValue = ""
    var ROI = ""
    var monthlyPay = Int()
    var pltenureInyear = Int(5)
    var bltenureInyear = Int(3)
    var pltenureInyearFloat = Float()
    var loanTenureVal = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        if(titlLabel == "PERSONAL LOAN")
        {
            viewTitleLbl.text! = "PERSONAL LOAN"
            homeLView.isHidden = true
            homeLViewHeight.constant = 0
            personlLView.isHidden = false
            persnlLViewHeight.constant = 120
            businessLView.isHidden = true
            bisnessLViewHeight.constant = 0
        }
        else if(titlLabel == "BUSINESS LOAN")
        {
            viewTitleLbl.text! = "BUSINESS LOAN"
            homeLView.isHidden = true
            homeLViewHeight.constant = 0
            personlLView.isHidden = true
            persnlLViewHeight.constant = 0
            businessLView.isHidden = false
            bisnessLViewHeight.constant = 80
        }
        else if(titlLabel == "HOME LOAN" || titlLabel == "LAP LOAN")
        {
            if(titlLabel == "HOME LOAN"){
                viewTitleLbl.text! = "HOME LOAN"
                tenureInyearTf.text! = "20"
                homeLyrSlider.value = 20
            }
            else if(titlLabel == "LAP LOAN"){
                viewTitleLbl.text! = "LAP LOAN"
                tenureInyearTf.text! = "15"
                homeLyrSlider.value = 15
            }
            homeLView.isHidden = false
            homeLViewHeight.constant = 90
            personlLView.isHidden = true
            persnlLViewHeight.constant = 0
            businessLView.isHidden = true
            bisnessLViewHeight.constant = 0
        }
        selectloanamountTf.text! = "2500000"
        perloanAmountTf.text! = "100000"
        busiloanAmountTf.text! = "500000"
        roundBtnColorBlue(btn:tenure5Btn)
        roundBtnColorGray(btn:tenure4Btn)
        roundBtnColorGray(btn:tenure3Btn)
        roundBtnColorGray(btn:tenure2Btn)
        roundBtnColorGray(btn:tenure1Btn)
        roundBtnColorGray(btn:tenurepnt6Btn)
        roundBtnColorBlue(btn:slcttenure3Btn)
        roundBtnColorGray(btn:slcttenure1Btn)
        roundBtnColorGray(btn:slcttenure2Btn)
        
        //apiCALL
        GetCitywiseBankListAPI()
    }

    //--personlloantenureBtnCliked---
    @IBAction func tenurepnt6BtnCliked(_ sender: Any)
    {
        roundBtnColorBlue(btn:tenurepnt6Btn)
        roundBtnColorGray(btn: tenure1Btn)
        roundBtnColorGray(btn: tenure2Btn)
        roundBtnColorGray(btn: tenure3Btn)
        roundBtnColorGray(btn: tenure4Btn)
        roundBtnColorGray(btn: tenure5Btn)
        self.pltenureInyearFloat = Float(0.6)
        self.loanTV.reloadData()
    }
    @IBAction func tenure1Btn(_ sender: Any)
    {
        roundBtnColorBlue(btn:tenure1Btn)
        roundBtnColorGray(btn:tenurepnt6Btn)
        roundBtnColorGray(btn: tenure2Btn)
        roundBtnColorGray(btn: tenure3Btn)
        roundBtnColorGray(btn: tenure4Btn)
        roundBtnColorGray(btn: tenure5Btn)
        self.pltenureInyear = Int(1)
        self.pltenureInyearFloat = Float()
        self.loanTV.reloadData()
    }
    @IBAction func tenure2BtnCliked(_ sender: Any)
    {
        roundBtnColorBlue(btn:tenure2Btn)
        roundBtnColorGray(btn:tenure1Btn)
        roundBtnColorGray(btn:tenurepnt6Btn)
        roundBtnColorGray(btn: tenure3Btn)
        roundBtnColorGray(btn: tenure4Btn)
        roundBtnColorGray(btn: tenure5Btn)
        self.pltenureInyear = Int(2)
        self.pltenureInyearFloat = Float()
        self.loanTV.reloadData()
    }
    @IBAction func tenure3btnCliked(_ sender: Any)
    {
        roundBtnColorBlue(btn:tenure3Btn)
        roundBtnColorGray(btn:tenure2Btn)
        roundBtnColorGray(btn:tenure1Btn)
        roundBtnColorGray(btn:tenurepnt6Btn)
        roundBtnColorGray(btn: tenure4Btn)
        roundBtnColorGray(btn: tenure5Btn)
        self.pltenureInyear = Int(3)
        self.pltenureInyearFloat = Float()
        self.loanTV.reloadData()
    }
    @IBAction func tenure4BtnCliked(_ sender: Any)
    {
        roundBtnColorBlue(btn:tenure4Btn)
        roundBtnColorGray(btn:tenure3Btn)
        roundBtnColorGray(btn:tenure2Btn)
        roundBtnColorGray(btn:tenure1Btn)
        roundBtnColorGray(btn:tenurepnt6Btn)
        roundBtnColorGray(btn: tenure5Btn)
        self.pltenureInyear = Int(4)
        self.pltenureInyearFloat = Float()
        self.loanTV.reloadData()
    }
    @IBAction func tenure5BtnCliked(_ sender: Any)
    {
        roundBtnColorBlue(btn:tenure5Btn)
        roundBtnColorGray(btn:tenure4Btn)
        roundBtnColorGray(btn:tenure3Btn)
        roundBtnColorGray(btn:tenure2Btn)
        roundBtnColorGray(btn:tenure1Btn)
        roundBtnColorGray(btn:tenurepnt6Btn)
        self.pltenureInyear = Int(5)
        self.pltenureInyearFloat = Float()
        self.loanTV.reloadData()
    }
    //--businessLoan--
    @IBAction func slcttenure1BtnCliked(_ sender: Any)
    {
        roundBtnColorBlue(btn:slcttenure1Btn)
        roundBtnColorGray(btn:slcttenure2Btn)
        roundBtnColorGray(btn:slcttenure3Btn)
        self.bltenureInyear = Int(1)
        self.loanTV.reloadData()
    }
    @IBAction func slcttenure2BtnCliked(_ sender: Any)
    {
        roundBtnColorBlue(btn:slcttenure2Btn)
        roundBtnColorGray(btn:slcttenure1Btn)
        roundBtnColorGray(btn:slcttenure3Btn)
        self.bltenureInyear = Int(2)
        self.loanTV.reloadData()
    }
    @IBAction func slcttenure3BtnCliked(_ sender: Any)
    {
        roundBtnColorBlue(btn:slcttenure3Btn)
        roundBtnColorGray(btn:slcttenure1Btn)
        roundBtnColorGray(btn:slcttenure2Btn)
        self.bltenureInyear = Int(3)
        self.loanTV.reloadData()
    }
    func roundBtnColorBlue(btn:UIButton)
    {
        btn.backgroundColor = UIColor.init(red: 0/255.0, green: 125/255.0, blue: 213/255.0, alpha: 1)
        btn.setTitleColor(UIColor.white, for: UIControl.State.normal)
    }
    func roundBtnColorGray(btn:UIButton)
    {
        btn.backgroundColor = UIColor.white
        btn.setTitleColor(UIColor.black, for: UIControl.State.normal)
    }
    
    @IBAction func backBtnCliked(_ sender: Any)
    {
        let cmnloanselectCity : cmnloanselectCityVC = self.storyboard?.instantiateViewController(withIdentifier: "stbcmnloanselectCityVC") as! cmnloanselectCityVC
        if(viewTitleLbl.text! == "PERSONAL LOAN")
        {
            cmnloanselectCity.titlLbl = "PERSONAL LOAN"
        }
        else if(viewTitleLbl.text! == "BUSINESS LOAN")
        {
            cmnloanselectCity.titlLbl = "BUSINESS LOAN"
        }
        else if(viewTitleLbl.text! == "HOME LOAN")
        {
            cmnloanselectCity.titlLbl = "HOME LOAN"
        }
        else if(viewTitleLbl.text! == "LAP LOAN")
        {
            cmnloanselectCity.titlLbl = "LAP LOAN"
        }
        present(cmnloanselectCity, animated:true, completion: nil)
    }
    
    @IBAction func homeBtnCliked(_ sender: Any)
    {
        let KYDrawer : KYDrawerController = self.storyboard?.instantiateViewController(withIdentifier: "stbKYDrawerController") as! KYDrawerController
        present(KYDrawer, animated: true, completion: nil)
    }
    
    //---<Slider>--
    @IBAction func homeLSlidervalueChanged(_ sender: Any)
    {
        let stringValue = Int(homeLyrSlider.value)
        tenureInyearTf.text = String(stringValue)
        
//        emiValue = String(monthlyPay)
        self.loanTV.reloadData()
        
    }
    
    @IBAction func persnlLSlidervalueChanged(_ sender: Any)
    {
        let stringValue = Int(persnlLyrSlider.value)
        perloanAmountTf.text! = String(stringValue)
        
        self.loanTV.reloadData()
    }
    
    func applyNowBtnTapped(cell: detailsTVCell) {
        let indexPath = self.loanTV.indexPath(for: cell)
        let bnkurl = self.bankURLArray[(indexPath!.section)]
        let bankNme = self.bankNameArray[indexPath!.section]
        let commonWeb : commonWebVC = self.storyboard?.instantiateViewController(withIdentifier: "stbcommonWebVC") as! commonWebVC
        commonWeb.webfromScreen = "homeLoanapplyNow"
        commonWeb.bankUrl = bnkurl
        commonWeb.bankName = bankNme
        self.present(commonWeb, animated: true, completion: nil)
    }
    
    func readMoreBtnTapped(cell: detailsTVCell) {
        let indexPath = self.loanTV.indexPath(for: cell)
        
        for i in 0..<fbankImgArray.count {
            if indexPath!.section == i {
                sectionIsExpanded[i].toggle()
            } else {
                sectionIsExpanded[i] = false
            }
        }
        
        if indexPath!.row == 0 {
            let dict = self.lstCityProdBank[(indexPath?.section)!]
            let Seqment = (dict as AnyObject).value(forKey: "Seqment") as! NSArray
            self.numberOfActualRowsForSection = Seqment.count
            //sectionIsExpanded[indexPath!.section] = !sectionIsExpanded[indexPath!.section]
            loanTV.reloadData()
            //loanTV.reloadSections([indexPath!.section], with: .automatic)
        }
        
    }
    
    func readmoreCloseBtnTapped(cell: detailscontentTVCell) {
//        rowcounter = 0
//        print("readMoreClose*")
//        let indexPath = self.loanTV.indexPath(for: cell)
//        print("indexPath!.row",indexPath!.row)
////        if indexPath!.row == 0 {
//            sectionIsExpanded[indexPath!.section] = !sectionIsExpanded[indexPath!.section]
//            loanTV.reloadSections([indexPath!.section], with: .automatic)
//        }
    }
    
    //--<tableview Datasource + Deleagtes>--
    func numberOfSections(in tableView: UITableView) -> Int {
        return fbankImgArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // First will always be header
        print("sectionIsExpanded",sectionIsExpanded[section])
        return sectionIsExpanded[section] ? (1+numberOfActualRowsForSection) : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: headerIdentifier, for: indexPath) as! detailsTVCell
            let imgURL = NSURL(string: fbankImgArray[indexPath.section])
            if (imgURL != nil){
                let data = NSData(contentsOf: (imgURL as URL?)!)
                cell.fbankimgView.image = UIImage(data: data! as Data)
            }
            
            let dict1 = self.lstCityProdBank[indexPath.section] as! NSArray
            let fBest_ROI = (dict1[0] as AnyObject).value(forKey: "Best_ROI") as! String
            let fProcessing_Fees = (dict1[0] as AnyObject).value(forKey: "Processing_Fees") as! String
            
            cell.fbestroiLbl.text! = fBest_ROI
            cell.fprocessingfeeLbl.text! = fProcessing_Fees
            
            if(titlLabel == "HOME LOAN" || titlLabel == "LAP LOAN")
            {
                //--<MONTHLY EMI CALCULATION>--
                let loanAmount = Double(selectloanamountTf.text!)
                if(titlLabel == "LAP LOAN"){
                    let roi = String(fBest_ROI.dropLast())
                    ROI = String(roi.dropLast())
                }
                else{
                    ROI = String(fBest_ROI.dropLast())
                }
                let interestRateVal = (Double(ROI))! / 1200
                let loanTenureVal = Double(Int(tenureInyearTf.text!)! * 12)
                let monthlyPaymnt = loanAmount! * interestRateVal / (1 - (pow(1/(1 + interestRateVal), loanTenureVal)))
                monthlyPay = Int(round(monthlyPaymnt))
                print("monthlyPay=",monthlyPay)
                
                //            if(emiValue == ""){
                cell.femiLbl.text! = "₹"+String(monthlyPay)
                //            }
                //            else{
                //                cell.femiLbl.text! = "₹"+String(monthlyPay)
                //            }
            }
            else if(titlLabel == "PERSONAL LOAN")
            {
                do {
                    
                
                //--<MONTHLY EMI CALCULATION>--
                let loanAmount = try Double(perloanAmountTf.text!)
                    ROI =  String(fBest_ROI.dropLast().split(separator: "%")[0])
                    print(ROI)
                let interestRateVal = (Double(ROI))! / 1200
                if(pltenureInyearFloat == Float(0.6))
                {
                    loanTenureVal = Double(pltenureInyearFloat * 12)
                }else{
                    loanTenureVal = Double(pltenureInyear * 12)
                }
                let monthlyPaymnt = loanAmount! * interestRateVal / (1 - (pow(1/(1 + interestRateVal), loanTenureVal)))
                monthlyPay = Int(round(monthlyPaymnt))
                print("monthlyPay=",monthlyPay)
                cell.femiLbl.text! = "₹"+String(monthlyPay)
                }
            catch let error as NSError {
                    print(error)
                }
            }
            else if(titlLabel == "BUSINESS LOAN")
            {
                //--<MONTHLY EMI CALCULATION>--
                let loanAmount = Double(busiloanAmountTf.text!)
                ROI = String(fBest_ROI.dropLast())
                let interestRateVal = (Double(ROI))! / 1200
                let loanTenureVal = Double(bltenureInyear * 12)
                let monthlyPaymnt = loanAmount! * interestRateVal / (1 - (pow(1/(1 + interestRateVal), loanTenureVal)))
                monthlyPay = Int(round(monthlyPaymnt))
                print("monthlyPay=",monthlyPay)
                cell.femiLbl.text! = "₹"+String(monthlyPay)
            }
            
            if sectionIsExpanded[indexPath.section] {
                cell.setExpanded()
            } else {
                cell.setCollapsed()
            }
            
            cell.loandelegate = self
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! detailscontentTVCell
            
            let dict1 = self.lstCityProdBank[indexPath.section] as! NSArray
            
            let Seqment1 = (dict1[indexPath.row-1] as AnyObject).value(forKey: "Seqment") as! String
            cell.ssegmentLbl.text! = Seqment1
            print("Seqment1",Seqment1)
            
            let Best_ROI = (dict1[indexPath.row-1] as AnyObject).value(forKey: "Best_ROI") as! String
            let Processing_Fees = (dict1[indexPath.row-1] as AnyObject).value(forKey: "Processing_Fees") as! String
            let Product_Name = (dict1[indexPath.row-1] as AnyObject).value(forKey: "Product_Name") as! String
            let Product_Type = (dict1[indexPath.row-1] as AnyObject).value(forKey: "Product_Type") as! String
            let Per_Lac_EMI = (dict1[indexPath.row-1] as AnyObject).value(forKey: "Per_Lac_EMI") as! String
            let Loan_Amt = (dict1[indexPath.row-1] as AnyObject).value(forKey: "Loan_Amt") as! String
            let Tenure = (dict1[indexPath.row-1] as AnyObject).value(forKey: "Tenure") as! String
            let Age = (dict1[indexPath.row-1] as AnyObject).value(forKey: "Age") as! String
            let Min_Salary = (dict1[indexPath.row-1] as AnyObject).value(forKey: "Min_Salary") as! String
            let Min_Work_Exp = (dict1[indexPath.row-1] as AnyObject).value(forKey: "Min_Work_Exp") as! String
            let Min_Cibil_Score = (dict1[indexPath.row-1] as AnyObject).value(forKey: "Min_Cibil_Score") as! String
            let Foreclosure_charges = (dict1[indexPath.row-1] as AnyObject).value(forKey: "Foreclosure_charges") as! String
            let Prepayment_charges = (dict1[indexPath.row-1] as AnyObject).value(forKey: "Prepayment_charges") as! String

            cell.sproductLbl.text! = Product_Name
            cell.sproductTypeLbl.text! = Product_Type
            cell.sbestroiLbl.text! = Best_ROI
            cell.sperlacemiLbl.text! = Per_Lac_EMI
            cell.sloanamountLbl.text! = Loan_Amt
            cell.stenureLbl.text! = Tenure
            cell.sageLbl.text! = Age
            cell.sminsalaryLbl.text! = Min_Salary
            cell.sminworkexpLbl.text! = Min_Work_Exp
            cell.sprocessingfeeLbl.text! = Processing_Fees
            cell.sminicibilLbl.text! = Min_Cibil_Score
            cell.sprepayLbl.text! = Prepayment_charges
            cell.sforechargeLbl.text! = Foreclosure_charges
            
            cell.londelegate = self
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 120
        }else{
            return UITableView.automaticDimension;
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
     
    }
   

    //---<APICALL>---
    func GetCitywiseBankListAPI()
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
        
        let params: [String: AnyObject] = ["cityId": citiesId as AnyObject,
                                           "prodId": productID as AnyObject]
        
        let url = "/LoginDtls.svc/XMLService/GetCitywiseBankList"
        
        FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
            alertView.close()
            
            self.view.layoutIfNeeded()
            
            let jsonData = userObject as? NSArray
            let Bank_URL = jsonData?.value(forKey: "Bank_URL") as AnyObject
            self.fbankImgArray = Bank_URL as! [String]
            let Bank_Form_URL = jsonData?.value(forKey: "Bank_Form_URL") as AnyObject
            self.bankURLArray = Bank_Form_URL as! [String]
            let Bank_Name = jsonData?.value(forKey: "Bank_Name") as AnyObject
            self.bankNameArray = Bank_Name as! [String]
            
            self.lstCityProdBank = (jsonData?.value(forKey: "lstCityProdBank") as! NSArray) as [AnyObject]
            print("lstCityProdBank= ", self.lstCityProdBank)
            
            for i in 0..<self.lstCityProdBank.count {
                self.sectionIsExpanded.append(false)
                let dict = self.lstCityProdBank[i]
                print("i=",i)
                print("dict=",dict)
                
                /*
                 
                let Best_ROI = (dict as AnyObject).value(forKey: "Best_ROI") as AnyObject
                self.fbestroiArray = Best_ROI as! [String]
                self.sbestroiArray = Best_ROI as! [String]
                let Processing_Fees = (dict as AnyObject).value(forKey: "Processing_Fees") as AnyObject
                self.fprocessingArray = Processing_Fees as! [String]
                let Seqment = (dict as AnyObject).value(forKey: "Seqment") as AnyObject
                self.ssegmentArray = Seqment as! [String]
                print("ssegmentArray=",self.ssegmentArray)
                let Product_Name = (dict as AnyObject).value(forKey: "Product_Name") as AnyObject
                self.sproductArray = Product_Name as! [String]
                let Product_Type = (dict as AnyObject).value(forKey: "Product_Type") as AnyObject
                self.sproductTypeArray = Product_Type as! [String]
                let Per_Lac_EMI = (dict as AnyObject).value(forKey: "Per_Lac_EMI") as AnyObject
                self.sperlacEmiArray = Per_Lac_EMI as! [String]
                let Loan_Amt = (dict as AnyObject).value(forKey: "Loan_Amt") as AnyObject
                self.sloanAmountArray = Loan_Amt as! [String]
                let Tenure = (dict as AnyObject).value(forKey: "Tenure") as AnyObject
                self.stenureArray = Tenure as! [String]
                let Age = (dict as AnyObject).value(forKey: "Age") as AnyObject
                self.sageArray = Age as! [String]
                //print("sageArray=",self.sageArray)
                let Min_Salary = (dict as AnyObject).value(forKey: "Min_Salary") as AnyObject
                self.sminsalryArray = Min_Salary as! [String]
                //print("sminsalryArray=",self.sminsalryArray)
                let Min_Work_Exp = (dict as AnyObject).value(forKey: "Min_Work_Exp") as AnyObject
                self.sminwrokexpArray = Min_Work_Exp as! [String]
                //print("sminwrokexpArray=",self.sminwrokexpArray)
                let MinCibilScore = (dict as AnyObject).value(forKey: "Min_Cibil_Score") as AnyObject
                self.smincibilscoreArray = MinCibilScore as! [String]
                //print("smincibilscoreArray=",self.smincibilscoreArray)
                let Foreclosure_charges = (dict as AnyObject).value(forKey: "Foreclosure_charges") as AnyObject
                self.sforecloArray = Foreclosure_charges as! [String]
                //print("sforecloArray=",self.sforecloArray)
                let Prepayment_charges = (dict as AnyObject).value(forKey: "Prepayment_charges") as AnyObject
                self.sprepaymentArray = Prepayment_charges as! [String]
                //print("sprepaymentArray=",self.sprepaymentArray)
                
                */
                
                self.sectionIsExpanded.append(false)
                //print("sectionIsExpanded=?",self.sectionIsExpanded)
                
                self.numberOfActualRowsForSection = self.ssegmentArray.count
                //print("numberOfActualRowsForSection=?",self.numberOfActualRowsForSection)
                
            }
            
            self.loanTV.reloadData()
            
        }, onError: { errorData in
            alertView.close()
            let snackbar = TTGSnackbar.init(message: errorData.errorMessage, duration: .long)
            snackbar.show()
        }, onForceUpgrade: {errorData in},checkLead: true)
        
    }
    
    
}

@IBDesignable class RoundButton : UIButton{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }
    override func prepareForInterfaceBuilder() {
        sharedInit()
    }
    func sharedInit() {
        refreshCorners(value: cornerRadius)
    }
    func refreshCorners(value: CGFloat) {
        layer.cornerRadius = value
        let borderColor = UIColor.init(red: 0/255.0, green: 125/255.0, blue: 213/255.0, alpha: 1)
        layer.borderColor=borderColor.cgColor;
        layer.borderWidth=1.0;
        
    }
    @IBInspectable var cornerRadius: CGFloat = 15 {
        didSet {
            refreshCorners(value: cornerRadius)
        }
    }
}

