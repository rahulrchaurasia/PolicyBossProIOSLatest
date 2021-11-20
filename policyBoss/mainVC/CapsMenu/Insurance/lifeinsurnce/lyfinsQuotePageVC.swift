//
//  lyfinsQuotePageVC.swift
//  MagicFinmart
//
//  Created by Admin on 07/03/19.
//  Copyright © 2019 Ashwini. All rights reserved.
//

import UIKit
import CustomIOSAlertView
import TTGSnackbar

class lyfinsQuotePageVC: UIViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,SelectedDateDelegate,getPickerDataDelegate,lyfhdfccellDelegates{
   
    @IBOutlet weak var quotedetailsView: UIView!
    @IBOutlet weak var compQuotesTV: UITableView!
    @IBOutlet var compQuotesTVHeight: NSLayoutConstraint!//380
    //    @IBOutlet var qtopfrstView: UIView!
//    @IBOutlet var qtopfrstViewHeight: NSLayoutConstraint!//80
    @IBOutlet var qquoteplanView: UIView!
    @IBOutlet var qquoteplanViewHeight: NSLayoutConstraint!//145
    @IBOutlet var qbankimageView: UIView!
    @IBOutlet var qplaneView: UIView!
    @IBOutlet var qsharecartView: UIView!
    @IBOutlet var qcoverView: UIView!
    @IBOutlet var qpolicyTermView: UIView!
    @IBOutlet var quptoageView: UIView!
    @IBOutlet var qfirstlastNameView: UIView!
    @IBOutlet var qfirstlastNameViewHeight: NSLayoutConstraint!//60
    @IBOutlet var qmobdobView: UIView!
    @IBOutlet var qmobdobViewHeight: NSLayoutConstraint!//60
    @IBOutlet var qgendersmokerView: UIView!
    @IBOutlet var qgendersmokerViewHeight: NSLayoutConstraint!//60
    @IBOutlet weak var qcompView: UIView!
    @IBOutlet weak var qcompViewHeight: NSLayoutConstraint!//140
    @IBOutlet weak var qhdfcView: UIView!
    @IBOutlet weak var qhdfcViewHeight: NSLayoutConstraint!//655
    @IBOutlet weak var qiciciView: UIView!
    @IBOutlet weak var qiciciViewHeight: NSLayoutConstraint!//703
    @IBOutlet weak var qicicisaIncreaView: UIView!
    @IBOutlet weak var qicicisaIncreasHeight: NSLayoutConstraint!//50
    @IBOutlet weak var qicicaccdentlView: UIView!
    @IBOutlet weak var qicicaccdenViewHeight: NSLayoutConstraint!
    @IBOutlet weak var qiciciAccDeathViewTop: NSLayoutConstraint!
    @IBOutlet weak var qiciclumpSumView: UIView!
    @IBOutlet weak var qiciclumpsumViewHeight: NSLayoutConstraint!
    @IBOutlet weak var qicicipolicyTermViewTop: NSLayoutConstraint!
    @IBOutlet weak var qiciciprePaymntView: UIView!
    @IBOutlet weak var qicicipremiPayLbl: UILabel!
    @IBOutlet weak var qhdfcADBView: UIView!
    @IBOutlet weak var qhdfcADBViewHeight: NSLayoutConstraint!//50
    @IBOutlet weak var qhdfcADBViewTop: NSLayoutConstraint!
    @IBOutlet weak var qhdfcmothlyIncomeVIew: UIView!
    @IBOutlet weak var qhdfcmonthIcomeViewHeight: NSLayoutConstraint!
    @IBOutlet weak var qhdfcIncomePeriodView: UIView!
    @IBOutlet weak var qhdfcIncomePeriViewHeight: NSLayoutConstraint!
    @IBOutlet weak var qhdfcincreView: UIView!
    @IBOutlet weak var qhdfcIncreViewHeight: NSLayoutConstraint!
    @IBOutlet weak var qhdfcincreViewTop: NSLayoutConstraint!
    @IBOutlet weak var qmaleBtn: UIButton!
    @IBOutlet weak var qfemaleBtn: UIButton!
    @IBOutlet weak var qsYesBtn: UIButton!
    @IBOutlet weak var qsNoBtn: UIButton!
    @IBOutlet weak var qlumpSumBtn: UIButton!
    @IBOutlet weak var qreguIncomeBtn: UIButton!
    @IBOutlet weak var qincreIncomeBtn: UIButton!
    @IBOutlet weak var qlumpnreguIncomeBtn: UIButton!
    @IBOutlet weak var qcomppolicytermLbl: UILabel!
    @IBOutlet weak var qpremtermLbl: UILabel!
    @IBOutlet weak var qpremFrqLbl: UILabel!
    @IBOutlet weak var qhdfcOptionLbl: UILabel!
    @IBOutlet weak var qicicipaytermLbl: UILabel!
    @IBOutlet weak var qicicpreFrqLbl: UILabel!
    @IBOutlet weak var qicicioptionLbl: UILabel!
    @IBOutlet var qsumLbl: UILabel!
    @IBOutlet var qageLbl: UILabel!
    @IBOutlet var qcrnLbl: UILabel!
    @IBOutlet var qmalesmkerLbl: UILabel!
    @IBOutlet var qtermLbl: UILabel!
    @IBOutlet var qqimgView: UIImageView!
    @IBOutlet var qqplanLbl: UILabel!
    @IBOutlet var qqRsLbl: UILabel!
    @IBOutlet var qqCoverLbl: UILabel!
    @IBOutlet var qqpolicyTermLbl: UILabel!
    @IBOutlet var qquptoageLbl: UILabel!
    
    @IBOutlet weak var qfirstNameTf: ACFloatingTextfield!
    @IBOutlet weak var qlastNameTf: ACFloatingTextfield!
    @IBOutlet weak var qmobNoTf: ACFloatingTextfield!
    @IBOutlet weak var qdobTf: ACFloatingTextfield!
    @IBOutlet weak var qcompPincodeTf: ACFloatingTextfield!
    @IBOutlet weak var qcompsumAssuredTf: ACFloatingTextfield!
    @IBOutlet weak var qhdfcPincodeTf: ACFloatingTextfield!
    @IBOutlet weak var qicicPincodeTf: ACFloatingTextfield!
    @IBOutlet weak var qhdfcsumAssuredTf: ACFloatingTextfield!
    @IBOutlet weak var qhdfcpolicyTermTf: ACFloatingTextfield!
    @IBOutlet weak var qhdfcpreTermAssuredTf: ACFloatingTextfield!
    @IBOutlet weak var qhdfcsaIncreTf: ACFloatingTextfield!
    @IBOutlet weak var qicicisumAssuredTf: ACFloatingTextfield!
    @IBOutlet weak var qicicilumpsumTf: ACFloatingTextfield!
    @IBOutlet weak var qicicipolicyTermTf: ACFloatingTextfield!
    @IBOutlet weak var qicicipreTermAssuredTf: ACFloatingTextfield!
    @IBOutlet weak var qicicicritiillTf: ACFloatingTextfield!
    @IBOutlet weak var qicicacceDeathTf: ACFloatingTextfield!
    @IBOutlet weak var qhdfcADBLbl: ACFloatingTextfield!
    @IBOutlet weak var qhdfcmonthincomLbl: ACFloatingTextfield!
    @IBOutlet weak var qhdfcincomperiLbl: ACFloatingTextfield!
    @IBOutlet weak var qhdfcincresLbl: ACFloatingTextfield!
    
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
    var deathBenefit = ""
    var payTermText = ""
    var InsurerID = ""
    var isclick = Bool()
    //-<tableView>-
    private let headerIdentifier = "headerCell"
    private let cellIdentifier = "contentCell"
    private var sectionTitles = ["One", "Two"]
    private let Titles = ["First", "Second"]
    private var sectionIsExpanded = [false, false, false]
    private let numberOfActualRowsForSection = 1
    
    private var ProductPlanNameArr = [String]()
    private var CustomerReferenceIDArr = [String]()
    private var PolicyTermYearArr = [String]()
    private var NetPremiumArr = [String]()
    private var SumAssuredArr = [String]()
    private var InsurerLogoNameArr : [String] = ["ezgif.com-webp-to-png (1).png","ezgif.com-webp-to-png (2).png"]
    private var ProposerPageUrlArray = [String]()
    private var KeyFeaturesArray = [String]()
    var ProposerPageUrlString = ""
    
    
    //--<hdfcIncrementDecreValues>--
    var hdfcsumAssuredTfValue: Int = 0 {
        didSet {
            qhdfcsumAssuredTf.text! = "\(hdfcsumAssuredTfValue)"
        }
    }
    var hdfcpolicyTermTfValue: Int = 0 {
        didSet {
            qhdfcpolicyTermTf.text! = "\(hdfcpolicyTermTfValue)"
        }
    }
    var hdfcpreTermTfValue: Int = 0 {
        didSet {
            qhdfcpreTermAssuredTf.text! = "\(hdfcpreTermTfValue)"
        }
    }
    var hdfcsaIncreTfValue: Int = 0 {
        didSet {
            qhdfcsaIncreTf.text! = "\(hdfcsaIncreTfValue)"
        }
    }
    var hdfcADBTfValue: Int = 0 {
        didSet {
            qhdfcADBLbl.text! = "\(hdfcADBTfValue)"
        }
    }
    var hdfcmonthincomTfValue: Int = 0 {
        didSet {
            qhdfcmonthincomLbl.text! = "\(hdfcmonthincomTfValue)"
        }
    }
    var hdfcincomperiTfValue: Int = 0 {
        didSet {
            qhdfcincomperiLbl.text! = "\(hdfcincomperiTfValue)"
        }
    }
    var hdfcincresTfValue: Int = 0 {
        didSet {
            qhdfcincresLbl.text! = "\(hdfcincresTfValue)"
        }
    }
    //--<iciciIncrementDecreValues>--
    var icicisumAssuredTfValue: Int = 0 {
        didSet {
            qicicisumAssuredTf.text! = "\(icicisumAssuredTfValue)"
        }
    }
    var icicilumpsumTfValue: Int = 0 {
        didSet {
            qicicilumpsumTf.text! = "\(icicilumpsumTfValue)"
        }
    }
    var icicipolicyTermTfValue: Int = 0 {
        didSet {
            qicicipolicyTermTf.text! = "\(icicipolicyTermTfValue)"
        }
    }
    var icicipreTermAssuredTfValue: Int = 0 {
        didSet {
            qicicipreTermAssuredTf.text! = "\(icicipreTermAssuredTfValue)"
        }
    }
    var icicicritiillTfValue: Int = 0 {
        didSet {
            qicicicritiillTf.text! = "\(icicicritiillTfValue)"
        }
    }
    var icicacceDeathTfValue: Int = 0 {
        didSet {
            qicicacceDeathTf.text! = "\(icicacceDeathTfValue)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        let borderColr = UIColor.lightGray
        quotedetailsView.layer.cornerRadius=2.0;
        quotedetailsView.layer.borderWidth=1.0;
        quotedetailsView.layer.borderColor=borderColr.cgColor;
    
        //btn
        btnColorChangeBlue(Btn: qmaleBtn)
        btnColorChangeGray(Btn: qfemaleBtn)
        btnColorChangeBlue(Btn: qsNoBtn)
        btnColorChangeGray(Btn: qsYesBtn)
        btnColorChangeBlue(Btn: qlumpSumBtn)
        btnColorChangeGray(Btn: qreguIncomeBtn)
        btnColorChangeGray(Btn: qincreIncomeBtn)
        btnColorChangeGray(Btn: qlumpnreguIncomeBtn)
        //views
        viewColorGray(view:qbankimageView)
        viewColorGray(view:qplaneView)
        viewColorGray(view:qsharecartView)
        viewColorGray(view:qcoverView)
        viewColorGray(view:qpolicyTermView)
        viewColorGray(view:quptoageView)
        
        //--<HideViews>--
        qhdfcmothlyIncomeVIew.isHidden = true
        qhdfcmonthIcomeViewHeight.constant = 0
        qhdfcIncomePeriodView.isHidden = true
        qhdfcIncomePeriViewHeight.constant = 0
        qhdfcincreView.isHidden = true
        qhdfcIncreViewHeight.constant = 0
        qhdfcADBView.isHidden = true
        qhdfcADBViewHeight.constant = 0
        //        icicisaIncreaView.isHidden = true
        //        icicisaIncreasHeight.constant = 0
        qiciciprePaymntView.isHidden = true
        qicicipolicyTermViewTop.constant = 0
        qiciclumpSumView.isHidden = true
        qiciclumpsumViewHeight.constant = 0
        qicicisaIncreaView.isHidden = true
        qicicisaIncreasHeight.constant = 0
        qicicaccdentlView.isHidden = true
        qicicaccdenViewHeight.constant = 0
        compQuotesTV.isHidden = true
        compQuotesTVHeight.constant = 0
        
        //apiCall
        storesmarttermlifeAPI()
        
        //--<Quotes>--
        if(fromScreen == "compQuote"){
            compQuotesTV.isHidden = false
            compQuotesTVHeight.constant = 380
            qquoteplanView.isHidden = true
            qquoteplanViewHeight.constant = 0
            qcompView.isHidden = true
            qcompViewHeight.constant = 0
            qfirstlastNameView.isHidden = true
            qfirstlastNameViewHeight.constant = 0
            qmobdobView.isHidden = true
            qmobdobViewHeight.constant = 0
            qgendersmokerView.isHidden = true
            qgendersmokerViewHeight.constant = 0
            qhdfcView.isHidden = true
            qhdfcViewHeight.constant = 0
            qiciciView.isHidden = true
            qiciciViewHeight.constant = 0
            pincodeText = qcompPincodeTf.text!
            
            let smoker = UserDefaults.standard.string(forKey: "smoker")
            var comppolicytermLbl = UserDefaults.standard.string(forKey: "comppolicytermLbl")
            let compsumAssuredTf = UserDefaults.standard.string(forKey: "compsumAssuredTf")
            let Age = UserDefaults.standard.string(forKey: "Age")
//            let CustomerReferenceID = UserDefaults.standard.string(forKey: "CustomerReferenceID")
//            print("CustomerReferenceID=",CustomerReferenceID!)
            
            if(smoker == "false"){
                self.qmalesmkerLbl.text! = "NON-SMOKER"
            }else{
                self.qmalesmkerLbl.text! = "SMOKER"
            }
            self.qsumLbl.text! = compsumAssuredTf!
//            self.qcrnLbl.text! = CustomerReferenceID!
            if(comppolicytermLbl == ""){
                comppolicytermLbl = "20"
            }
            self.qtermLbl.text! = comppolicytermLbl! + " Years"
//            self.qqplanLbl.text! = ProductPlanName!
//            self.qqCoverLbl.text! = "₹ " + sumAssuredString!
//            self.qqpolicyTermLbl.text! = comppolicytermLbl! + " Yrs."
            self.qageLbl.text! = Age!
//            self.qqRsLbl.text! = "₹ " + NetPremiumArr
//            var sumofuptoage = Int()
//            sumofuptoage = Int(Age!)! + Int(comppolicytermLbl!)!
//            self.qquptoageLbl.text! = String(sumofuptoage) + " Yrs."
            
            //apiCall
//            storesmarttermlifeAPI()
            
        }
        if(fromScreen == "hdfcQuote"){
            compQuotesTV.isHidden = true
            compQuotesTVHeight.constant = 0
            qquoteplanView.isHidden = false
            qquoteplanViewHeight.constant = 145
            qfirstlastNameView.isHidden = true
            qfirstlastNameViewHeight.constant = 0
            qcompView.isHidden = true
            qcompViewHeight.constant = 0
            qhdfcView.isHidden = false
            qhdfcViewHeight.constant = 655
            qiciciView.isHidden = true
            qiciciViewHeight.constant = 0
//            pincodeText = qhdfcPincodeTf.text!
            
            //<userDefaultvalue>
            let CustomerReferenceIDString = UserDefaults.standard.string(forKey: "CustomerReferenceIDString")
            var ProductPlanName = UserDefaults.standard.string(forKey: "ProductPlanName")
            let sumAssuredString = UserDefaults.standard.string(forKey: "sumAssuredString")
            let PolicyTermYearString = UserDefaults.standard.string(forKey: "PolicyTermYearString")
            let Age = UserDefaults.standard.string(forKey: "Age")
            let NetPremium = UserDefaults.standard.string(forKey: "NetPremium")
//            print("NetPremium=",NetPremium!)
            let smoker = UserDefaults.standard.string(forKey: "smoker")
            if(smoker == "false"){
                self.qmalesmkerLbl.text! = "NON-SMOKER"
            }else{
                self.qmalesmkerLbl.text! = "SMOKER"
            }
            self.qsumLbl.text! = sumAssuredString!
            self.qcrnLbl.text! = CustomerReferenceIDString!
            self.qtermLbl.text! = PolicyTermYearString! + " Years"
//            self.qqplanLbl.text! = ProductPlanName!
            self.qqCoverLbl.text! = "₹ " + sumAssuredString!
            self.qqpolicyTermLbl.text! = PolicyTermYearString! + " Yrs."
            self.qageLbl.text! = Age!
//            self.qqRsLbl.text! = "₹ " + NetPremium!
            var sumofuptoage = Int()
            sumofuptoage = Int(Age!)! + Int(PolicyTermYearString!)!
            self.qquptoageLbl.text! = String(sumofuptoage) + " Yrs."
            
        }
        if(fromScreen == "iciciQuote"){
            compQuotesTV.isHidden = true
            compQuotesTVHeight.constant = 0
            qquoteplanView.isHidden = false
            qquoteplanViewHeight.constant = 145
            qcompView.isHidden = true
            qcompViewHeight.constant = 0
            qhdfcView.isHidden = true
            qhdfcViewHeight.constant = 0
            qfirstlastNameView.isHidden = true
            qfirstlastNameViewHeight.constant = 0
            qmobdobView.isHidden = true
            qmobdobViewHeight.constant = 0
            qgendersmokerView.isHidden = true
            qgendersmokerViewHeight.constant = 0
            qiciciView.isHidden = false
            qiciciViewHeight.constant = 732
//            pincodeText = qicicPincodeTf.text!
            
            //<userDefaultvalue>
            let CustomerReferenceIDString = UserDefaults.standard.string(forKey: "CustomerReferenceIDString")
            let ProductPlanName = UserDefaults.standard.string(forKey: "ProductPlanName")
            let sumAssuredString = UserDefaults.standard.string(forKey: "sumAssuredString")
            let PolicyTermYearString = UserDefaults.standard.string(forKey: "PolicyTermYearString")
            let Age = UserDefaults.standard.string(forKey: "Age")
            let NetPremium = UserDefaults.standard.string(forKey: "NetPremium")
            let smoker = UserDefaults.standard.string(forKey: "smoker")
            if(smoker == "false"){
                self.qmalesmkerLbl.text! = "NON-SMOKER"
            }else{
                self.qmalesmkerLbl.text! = "SMOKER"
            }
            self.qsumLbl.text! = sumAssuredString!
            self.qcrnLbl.text! = CustomerReferenceIDString!
            self.qtermLbl.text! = PolicyTermYearString! + " Years"
//            self.qqplanLbl.text! = ProductPlanName!
            self.qqCoverLbl.text! = "₹ " + sumAssuredString!
            self.qqpolicyTermLbl.text! = PolicyTermYearString! + " Yrs."
            self.qageLbl.text! = Age!
//            self.qqRsLbl.text! = "₹ " + NetPremium!
            var sumofuptoage = Int()
            sumofuptoage = Int(Age!)! + Int(PolicyTermYearString!)!
            self.qquptoageLbl.text! = String(sumofuptoage) + " Yrs."
        }
        
        //--<hdfcIncrementDecreValues>--
        hdfcsumAssuredTfValue = 10000000 // didSet is called when the variable is changed, not upon initialization.
        hdfcpolicyTermTfValue = 20
        hdfcpreTermTfValue = 20
        hdfcsaIncreTfValue = 10
        hdfcADBTfValue = 100
        hdfcmonthincomTfValue = 25000
        hdfcincomperiTfValue = 20
        hdfcincresTfValue = 5
        //--<iciciIncrementDecreValues>--
        icicisumAssuredTfValue = 10000000
        icicilumpsumTfValue = 50
        icicipolicyTermTfValue = 20
        icicipreTermAssuredTfValue = 20
        icicicritiillTfValue = 1000000
        icicacceDeathTfValue = 10000000
        
    }
    
    
    //---<textFieldRange>---
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if(textField == qmobNoTf)
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
    
    
    //--<tableViewDatasource+Delegates>--
    func numberOfSections(in tableView: UITableView) -> Int {
        return ProductPlanNameArr.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // First will always be header
        return sectionIsExpanded[section] ? (1+numberOfActualRowsForSection) : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: headerIdentifier, for: indexPath) as! lyfinsQuotesPageTVCell

            let Age = UserDefaults.standard.string(forKey: "Age")
            self.qcrnLbl.text! = CustomerReferenceIDArr[0]
            cell.complanLbl.text! = ProductPlanNameArr[indexPath.section]
            cell.comCoverLbl.text! = "₹ " + SumAssuredArr[indexPath.section]
            cell.comPolicytermLbl.text! = PolicyTermYearArr[indexPath.section] + " Yrs."
//            cell.comuptoAgeLbl.text! = [Age!][indexPath.section]
            cell.comtermreqRsLbl.text! = "₹ " + NetPremiumArr[indexPath.section]
//            var sumofuptoage = String()
//            sumofuptoage = qageLbl.text! + cell.comPolicytermLbl.text!
//            cell.comuptoAgeLbl.text! = [String(sumofuptoage)][indexPath.section] + " Yrs."
            var sumofuptoage = Int()
            sumofuptoage = Int(Age!)!
            var sumofuptoage2 = String()
            sumofuptoage2 = qtermLbl.text!.components(separatedBy: " ").dropLast().joined(separator: " ")
            var upToage = Int()
            upToage = Int(sumofuptoage) + Int(sumofuptoage2)!
            var upToageString = String()
            upToageString = String(upToage)
            cell.comuptoAgeLbl.text! = upToageString + " Yrs."
            
            cell.comimgView?.image = UIImage(named: InsurerLogoNameArr[indexPath.section])
            
//            cell.headerLbl.text = sectionTitles[indexPath.section]
            
            if sectionIsExpanded[indexPath.section] {
                cell.setExpanded()
            } else {
                cell.setCollapsed()
            }
            
            //--buttonRow--
            cell.delegateb = self
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! lyfinsQuotesPage2TVCell
            print("KeyFeaturesArray=",KeyFeaturesArray)
            
            let spliteStr = KeyFeaturesArray[0].components(separatedBy: "|")
            print("spliteStr=",spliteStr)
            
            let spliteStr2 = KeyFeaturesArray[1].components(separatedBy: "|")
            print("spliteStr2=",spliteStr2)
            
            let spliteString = [spliteStr,spliteStr2]
            
            //005
            cell.cellLbl.attributedText = NSAttributedStringHelper.createBulletedList(fromStringArray: spliteString[indexPath.section])
            
            
//            let spliteString = spliteStr + spliteStr2
//            print("spliteString=",spliteString)
            
//            cell.cellLbl.text = KeyFeaturesArray[indexPath.section]
//            cell.cellLbl.attributedText = add(stringList: [spliteStr[0]], font: cell.cellLbl.font, bullet: " • ")
            
//            cell.cellLbl.attributedText = add(stringList: [spliteStr2], font: cell.cellLbl.font, bullet: " • ")

            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 150
        }else{
            return 400
        }
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        // Expand/hide the section if tapped its header
        if indexPath.row == 0 {
            sectionIsExpanded[indexPath.section] = !sectionIsExpanded[indexPath.section]
            compQuotesTV.reloadSections([indexPath.section], with: .automatic)
        }
        
    }
    
    
    func netpreBtnTapped(cell: lyfinsQuotesPageTVCell) {
        //Get the indexpath of cell where button was tapped
        let indexPath = self.compQuotesTV.indexPath(for: cell)
        ProposerPageUrlString = ProposerPageUrlArray[indexPath!.row]
        
        if(ProposerPageUrlString != ""){
            let commonWeb : commonWebVC = self.storyboard?.instantiateViewController(withIdentifier: "stbcommonWebVC") as! commonWebVC
            commonWeb.webfromScreen = "lyfinshdfcnetPremium"
            commonWeb.ProposerPageUrl = ProposerPageUrlString
            present(commonWeb, animated: true, completion: nil)
        }
        
    }
    
    func customiseBtnTapped(cell: lyfinsQuotesPageTVCell) {
        //Get the indexpath of cell where button was tapped
        let indexPath = self.compQuotesTV.indexPath(for: cell)
        if(indexPath!.section == 1){
            compQuotesTV.isHidden = true
            compQuotesTVHeight.constant = 0
            qquoteplanView.isHidden = false
            qquoteplanViewHeight.constant = 145
            qfirstlastNameView.isHidden = true
            qfirstlastNameViewHeight.constant = 0
            qcompView.isHidden = true
            qcompViewHeight.constant = 0
            qhdfcView.isHidden = false
            qhdfcViewHeight.constant = 655
            qiciciView.isHidden = true
            qiciciViewHeight.constant = 0
            
        }
        if(indexPath!.section == 0){
            compQuotesTV.isHidden = true
            compQuotesTVHeight.constant = 0
            qquoteplanView.isHidden = false
            qquoteplanViewHeight.constant = 145
            qcompView.isHidden = true
            qcompViewHeight.constant = 0
            qhdfcView.isHidden = true
            qhdfcViewHeight.constant = 0
            qiciciView.isHidden = false
            qiciciViewHeight.constant = 732
            //            pincodeText = qicicPincodeTf.text!
        }
        
    }

    //--<endtableViewDatasource+Delegates>--
    
    
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
        qdobTf.text = currDate
        qdobTf.textColor = UIColor.black
        
        let dateYear = currDate.components(separatedBy: "-").dropFirst().joined(separator: "-")
        let yearOnly = dateYear.components(separatedBy: "-").dropFirst().joined(separator: "-")
        
        var year = Int()
        year = Int(yearOnly)!
        let Age = 2019 - year
        if(qhdfcOptionLbl.text! == "LIFE LONG PROTECTION" || qhdfcOptionLbl.text! == "3D LIFE LONG PROTECTION")
        {
            let policyTermValue = 100 - Age
            qhdfcpolicyTermTf.text! = String(policyTermValue)
            let premiumTermValue = 65 - Age
            qhdfcpreTermAssuredTf.text! = String(premiumTermValue)
        }
        if(qicicipaytermLbl.text! == "LIMITED PAY")
        {
            let policyTermValue = 60 - Age
            qicicipolicyTermTf.text! = String(policyTermValue)
            let premiumTermValue = 60 - Age
            qicicipreTermAssuredTf.text! = String(premiumTermValue)
        }
        if(qicicipaytermLbl.text! == "WHOLE LIFE")
        {
            let policyTermValue = 99 - Age
            qicicipolicyTermTf.text! = String(policyTermValue)
            let premiumTermValue = 99 - Age
            qicicipreTermAssuredTf.text! = String(premiumTermValue)
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
        let commonWeb : commonWebVC = self.storyboard?.instantiateViewController(withIdentifier: "stbcommonWebVC") as! commonWebVC
        commonWeb.webfromScreen = "lyfinsQuote"
        commonWeb.ProposerPageUrl = ProposerPageUrlString
        present(commonWeb, animated: true, completion: nil)
    }
    
    @IBAction func qCartBtnCliked(_ sender: Any)
    {
        let commonWeb : commonWebVC = self.storyboard?.instantiateViewController(withIdentifier: "stbcommonWebVC") as! commonWebVC
        commonWeb.webfromScreen = "lyfinsQuote"
        commonWeb.ProposerPageUrl = ProposerPageUrlString
        present(commonWeb, animated: true, completion: nil)
    }
    
    @IBAction func qmaleBtnCliked(_ sender: Any)
    {
        btnColorChangeBlue(Btn: qmaleBtn)
        btnColorChangeGray(Btn: qfemaleBtn)
        gender = "M"
    }
    
    @IBAction func qfemaleBtnCliked(_ sender: Any)
    {
        btnColorChangeBlue(Btn: qfemaleBtn)
        btnColorChangeGray(Btn: qmaleBtn)
        gender = "F"
    }
    
    @IBAction func qyesBtnCliked(_ sender: Any)
    {
        btnColorChangeBlue(Btn: qsYesBtn)
        btnColorChangeGray(Btn: qsNoBtn)
        smoker = "true"
    }
    
    @IBAction func qNoBtnCliked(_ sender: Any)
    {
        btnColorChangeBlue(Btn: qsNoBtn)
        btnColorChangeGray(Btn: qsYesBtn)
        smoker = "false"
    }
    
    @IBAction func icicilumpsumBtnCliked(_ sender: Any)
    {
        btnColorChangeBlue(Btn: qlumpSumBtn)
        btnColorChangeGray(Btn: qreguIncomeBtn)
        btnColorChangeGray(Btn: qincreIncomeBtn)
        btnColorChangeGray(Btn: qlumpnreguIncomeBtn)
        deathBenefit = "lump-sum"
        
        qicicipolicyTermViewTop.constant = 0
        qiciclumpSumView.isHidden = true
        qiciclumpsumViewHeight.constant = 0
        //        icicisaIncreaView.isHidden = false
        //        icicisaIncreasHeight.constant = 50
        //        icicaccdentlView.isHidden = false
        //        icicaccdenViewHeight.constant = 50
    }
    
    @IBAction func icicireguincomeBtnCliked(_ sender: Any)
    {
        btnColorChangeBlue(Btn: qreguIncomeBtn)
        btnColorChangeGray(Btn: qlumpSumBtn)
        btnColorChangeGray(Btn: qincreIncomeBtn)
        btnColorChangeGray(Btn: qlumpnreguIncomeBtn)
        deathBenefit = "regular-income"
        
        qicicipolicyTermViewTop.constant = 0
        qiciclumpSumView.isHidden = true
        qiciclumpsumViewHeight.constant = 0
        //        icicisaIncreaView.isHidden = false
        //        icicisaIncreasHeight.constant = 50
        //        icicaccdentlView.isHidden = false
        //        icicaccdenViewHeight.constant = 50
    }
    
    @IBAction func iciciincreincmBtnCliked(_ sender: Any)
    {
        btnColorChangeBlue(Btn: qincreIncomeBtn)
        btnColorChangeGray(Btn: qlumpSumBtn)
        btnColorChangeGray(Btn: qreguIncomeBtn)
        btnColorChangeGray(Btn: qlumpnreguIncomeBtn)
        deathBenefit = "increasing-income"
        
        qicicipolicyTermViewTop.constant = 0
        qiciclumpSumView.isHidden = true
        qiciclumpsumViewHeight.constant = 0
        //        icicisaIncreaView.isHidden = false
        //        icicisaIncreasHeight.constant = 50
        //        icicaccdentlView.isHidden = false
        //        icicaccdenViewHeight.constant = 50
    }
    
    @IBAction func icicilumpplusincmBtnCliked(_ sender: Any)
    {
        btnColorChangeBlue(Btn: qlumpnreguIncomeBtn)
        btnColorChangeGray(Btn: qlumpSumBtn)
        btnColorChangeGray(Btn: qincreIncomeBtn)
        btnColorChangeGray(Btn: qreguIncomeBtn)
        deathBenefit = "lump-sum+regular-income"
        
        qicicipolicyTermViewTop.constant = 10
        qiciclumpSumView.isHidden = false
        qiciclumpsumViewHeight.constant = 50
        //        icicisaIncreaView.isHidden = false
        //        icicisaIncreasHeight.constant = 50
        //        icicaccdentlView.isHidden = false
        //        icicaccdenViewHeight.constant = 50
    }
    
    @IBAction func comppolicytermBtnCliked(_ sender: Any)
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
    
    @IBAction func comppretermBtnCliked(_ sender: Any)
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
    
    @IBAction func hdfcpreFrqBtnCliked(_ sender: Any)
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
    
    @IBAction func hdfcoptionBtnCliked(_ sender: Any)
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
    
    @IBAction func icicpaytermBtnCliked(_ sender: Any)
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
   
    @IBAction func icicipreFrqBtnCliked(_ sender: Any)
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
    
    @IBAction func iciciprepaymtBtnCliked(_ sender: Any)
    {
        self.view.endEditing(true)
        let Picker : PickerViewVC! = storyboard?.instantiateViewController(withIdentifier: "stbPickerViewVC") as? PickerViewVC
        Picker.fromScreen = "icicipremiumPayment"
        if(qicicipaytermLbl.text! == "LIMITED PAY"){
            Picker.pickerData = iciciprePayArray
        }
        if(qicicipaytermLbl.text! == "WHOLE LIFE"){
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
            self.qcomppolicytermLbl.text = pickerSelectedData
            self.qpremtermLbl.text = pickerSelectedData
            //            self.sourceId = pickerSelectedId
            break
        case "compPremiumTerm":
            self.qpremtermLbl.text = pickerSelectedData
            //            self.sourceId = pickerSelectedId
            break
        case "hdfcPremiumTerm":
            self.qpremFrqLbl.text = pickerSelectedData
            //            self.sourceId = pickerSelectedId
            if(self.qpremFrqLbl.text == "SINGLE"){
                qhdfcpreTermAssuredTf.text! = "1"
                qhdfcsaIncreTf.text! = "0"
            }
            break
        case "hdfcOption":
            self.qhdfcOptionLbl.text = pickerSelectedData
            //            self.sourceId = pickerSelectedId
            if(qhdfcOptionLbl.text == "EXTRA LIFE")
            {
                qhdfcmothlyIncomeVIew.isHidden = true
                qhdfcmonthIcomeViewHeight.constant = 0
                qhdfcIncomePeriodView.isHidden = true
                qhdfcIncomePeriViewHeight.constant = 0
                qhdfcincreView.isHidden = true
                qhdfcIncreViewHeight.constant = 0
                qhdfcADBView.isHidden = false
                qhdfcADBViewHeight.constant = 50
                qhdfcADBViewTop.constant = -20
            }
            else if(qhdfcOptionLbl.text == "EXTRA LIFE INCOME")
            {
                qhdfcmothlyIncomeVIew.isHidden = false
                qhdfcmonthIcomeViewHeight.constant = 50
                qhdfcIncomePeriodView.isHidden = false
                qhdfcIncomePeriViewHeight.constant = 50
                qhdfcincreView.isHidden = false
                qhdfcIncreViewHeight.constant = 50
                qhdfcADBView.isHidden = false
                qhdfcADBViewHeight.constant = 50
                qhdfcADBViewTop.constant = 10
            }
            else if(qhdfcOptionLbl.text == "INCOME OPTION")
            {
                qhdfcmothlyIncomeVIew.isHidden = false
                qhdfcmonthIcomeViewHeight.constant = 50
                qhdfcIncomePeriodView.isHidden = false
                qhdfcIncomePeriViewHeight.constant = 50
                qhdfcincreView.isHidden = false
                qhdfcIncreViewHeight.constant = 50
                qhdfcincreViewTop.constant = 10
                qhdfcADBView.isHidden = true
                qhdfcADBViewHeight.constant = 0
            }
            else if(qhdfcOptionLbl.text == "INCOME REPLACEMENT")
            {
                qhdfcmothlyIncomeVIew.isHidden = false
                qhdfcmonthIcomeViewHeight.constant = 50
                qhdfcIncomePeriodView.isHidden = true
                qhdfcIncomePeriViewHeight.constant = 0
                qhdfcincreView.isHidden = false
                qhdfcIncreViewHeight.constant = 50
                qhdfcincreViewTop.constant = 0
                qhdfcADBView.isHidden = true
                qhdfcADBViewHeight.constant = 0
            }
            else{
                qhdfcmothlyIncomeVIew.isHidden = true
                qhdfcmonthIcomeViewHeight.constant = 0
                qhdfcIncomePeriodView.isHidden = true
                qhdfcIncomePeriViewHeight.constant = 0
                qhdfcincreView.isHidden = true
                qhdfcIncreViewHeight.constant = 0
                qhdfcADBView.isHidden = true
                qhdfcADBViewHeight.constant = 0
            }
            break
        case "icicipayTerm":
            self.qicicipaytermLbl.text = pickerSelectedData
            //            self.sourceId = pickerSelectedId
            if(qicicipaytermLbl.text! == "LIMITED PAY")
            {
                self.qicicipremiPayLbl.text = "PAY TILL AGE 60"
                qiciciprePaymntView.isHidden = false
            }
            else if(qicicipaytermLbl.text! == "WHOLE LIFE")
            {
                self.qicicipremiPayLbl.text = "PAY TILL AGE 99"
                qiciciprePaymntView.isHidden = false
            }
            else{
                qiciciprePaymntView.isHidden = true
            }
            break
        case "icicipreFrq":
            self.qicicpreFrqLbl.text = pickerSelectedData
            //            self.sourceId = pickerSelectedId
            break
        case "iciciOption":
            self.qicicioptionLbl.text = pickerSelectedData
            //            self.sourceId = pickerSelectedId
            if(qicicioptionLbl.text == "LIFE"){
                qicicipolicyTermViewTop.constant = 0
                qiciclumpSumView.isHidden = true
                qiciclumpsumViewHeight.constant = 0
                qicicisaIncreaView.isHidden = true
                qicicisaIncreasHeight.constant = 0
                qicicaccdentlView.isHidden = true
                qicicaccdenViewHeight.constant = 0
            }
            else if(qicicioptionLbl.text == "LIFE PLUS"){
                qicicipolicyTermViewTop.constant = 0
                qiciciAccDeathViewTop.constant = 0
                qiciclumpSumView.isHidden = true
                qiciclumpsumViewHeight.constant = 0
                qicicisaIncreaView.isHidden = true
                qicicisaIncreasHeight.constant = 0
                qicicaccdentlView.isHidden = false
                qicicaccdenViewHeight.constant = 50
            }
            else if(qicicioptionLbl.text == "LIFE AND HEALTH"){
                qicicipolicyTermViewTop.constant = 0
                qiciclumpSumView.isHidden = true
                qiciclumpsumViewHeight.constant = 0
                qicicisaIncreaView.isHidden = false
                qicicisaIncreasHeight.constant = 50
                qicicaccdentlView.isHidden = true
                qicicaccdenViewHeight.constant = 0
            }
            else if(qicicioptionLbl.text == "ALL IN ONE"){
                qicicipolicyTermViewTop.constant = 0
                qiciciAccDeathViewTop.constant = 10
                qiciclumpSumView.isHidden = true
                qiciclumpsumViewHeight.constant = 0
                qicicisaIncreaView.isHidden = false
                qicicisaIncreasHeight.constant = 50
                qicicaccdentlView.isHidden = false
                qicicaccdenViewHeight.constant = 50
            }
            else{
                qiciclumpSumView.isHidden = true
                qiciclumpsumViewHeight.constant = 0
                qicicisaIncreaView.isHidden = true
                qicicisaIncreasHeight.constant = 0
                qicicaccdentlView.isHidden = true
                qicicaccdenViewHeight.constant = 0
            }
            break
        case "icicipremiumPayment":
            self.qicicipremiPayLbl.text = pickerSelectedData
            //            self.sourceId = pickerSelectedId
            break
        default:
            break
        }
        
    }
    
    
    //--<hdfcIncrementDecreValueBtns>--
    //hdfc
    @IBAction func hdfcsumassleftBtnCliked(_ sender: Any)
    {
        if(hdfcsumAssuredTfValue == 2500000)
        {
            hdfcsumAssuredTfValue = 2500000
        }else{
            hdfcsumAssuredTfValue -= 500000
        }
    }
    
    @IBAction func hdfcsumassrightBtnCliked(_ sender: Any)
    {
        //        if(hdfcsumAssuredTfValue == 10000000)
        //        {
        //            hdfcsumAssuredTfValue = 10000000
        //        }else{
        hdfcsumAssuredTfValue += 500000
        //        }
    }
    
    @IBAction func hdfcpolicytermleftBtnCliked(_ sender: Any)
    {
        if(hdfcpolicyTermTfValue == 0)
        {
            hdfcpolicyTermTfValue = 0
        }else{
            hdfcpolicyTermTfValue -= 1
        }
    }
    
    @IBAction func hdfcplcytermrightBtnCliked(_ sender: Any)
    {
        if(hdfcpolicyTermTfValue == 20)
        {
            hdfcpolicyTermTfValue = 20
        }else{
            hdfcpolicyTermTfValue += 1
        }
    }
    
    @IBAction func hdfcpretermleftBtnCliked(_ sender: Any)
    {
        if(self.qpremFrqLbl.text == "SINGLE")
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
    
    @IBAction func hdfcpretrmrightBtnCliked(_ sender: Any)
    {
        if(self.qpremFrqLbl.text == "SINGLE")
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
    
    @IBAction func hdfcsaincrleftBtnCliked(_ sender: Any)
    {
        if(hdfcsaIncreTfValue == 0)
        {
            hdfcsaIncreTfValue = 0
        }else{
            hdfcsaIncreTfValue -= 1
        }
    }
    
    @IBAction func hdfcsaincrrightBtnCliked(_ sender: Any)
    {
        if(self.qpremFrqLbl.text == "SINGLE")
        {
            hdfcsaIncreTfValue = 0
        }
        else if(hdfcsaIncreTfValue == 10){
            hdfcsaIncreTfValue = 10
        }else{
            hdfcsaIncreTfValue += 1
        }
        
    }
    
    @IBAction func hdfcmnthlyincLeftBtnClikd(_ sender: Any)
    {
        //        if(hdfcADBTfValue == 100)
        //        {
        //            hdfcADBTfValue = 100
        //        }else{
        hdfcmonthincomTfValue -= 1
        //        }
    }
    
    @IBAction func hdfcmnthlyincrightBtnCliked(_ sender: Any)
    {
        hdfcmonthincomTfValue += 1
    }
    
    @IBAction func hdfcincperileftBtnCliked(_ sender: Any)
    {
        if(hdfcincomperiTfValue == 0)
        {
            hdfcincomperiTfValue = 0
        }else{
            hdfcincomperiTfValue -= 1
        }
    }
    
    @IBAction func hdfcincperirightCliked(_ sender: Any)
    {
        if(hdfcincomperiTfValue == 20)
        {
            hdfcincomperiTfValue = 20
        }else{
            hdfcincomperiTfValue += 1
        }
    }
    
    @IBAction func hdfcincrleftBtnCliked(_ sender: Any)
    {
        if(hdfcsaIncreTfValue == 0)
        {
            hdfcsaIncreTfValue = 0
        }else{
            hdfcsaIncreTfValue -= 1
        }
    }
    
    @IBAction func hdfcincrerightBtnCliked(_ sender: Any)
    {
        if(self.qpremFrqLbl.text == "SINGLE")
        {
            hdfcsaIncreTfValue = 0
        }
        else if(hdfcsaIncreTfValue == 10){
            hdfcsaIncreTfValue = 10
        }else{
            hdfcsaIncreTfValue += 1
        }
    }
    
    @IBAction func hdfcadbleftBtnCliked(_ sender: Any)
    {
        if(hdfcADBTfValue == 0)
        {
            hdfcADBTfValue = 0
        }else{
            hdfcADBTfValue -= 1
        }
    }
    
    @IBAction func hdfcadbrightBtnCliked(_ sender: Any)
    {
        if(hdfcADBTfValue == 100)
        {
            hdfcADBTfValue = 100
        }else{
            hdfcADBTfValue += 1
        }
    }
    
    //icici
    @IBAction func icicisumassurdleftBtnCliked(_ sender: Any)
    {
        if(icicisumAssuredTfValue == 100000)
        {
            icicisumAssuredTfValue = 100000
        }else{
            icicisumAssuredTfValue -= 500000
        }
    }
    
    @IBAction func icicisumassuredrightCliked(_ sender: Any)
    {
        icicisumAssuredTfValue += 500000
    }
   
    @IBAction func icicilumpsumleftBtnCliked(_ sender: Any)
    {
        if(icicilumpsumTfValue == 0)
        {
            icicilumpsumTfValue = 0
        }else{
            icicilumpsumTfValue -= 5
        }
    }
    
    @IBAction func lumpsumrightBtnCliked(_ sender: Any)
    {
        if(icicilumpsumTfValue == 95)
        {
            icicilumpsumTfValue = 95
        }else{
            icicilumpsumTfValue += 5
        }
    }
    
    @IBAction func icicpolicytrmleftBtnCliked(_ sender: Any)
    {
        icicipolicyTermTfValue -= 1
    }
    
    @IBAction func icicipolicytermrightBtnCliked(_ sender: Any)
    {
        icicipolicyTermTfValue += 1
    }
    
    @IBAction func icicipretrmleftBtnCliked(_ sender: Any)
    {
        icicipreTermAssuredTfValue -= 1
    }
    
    @IBAction func icicipretrmrightBtnCliked(_ sender: Any)
    {
        icicipreTermAssuredTfValue += 1
    }
    
    @IBAction func iciccriticlillleftBtnCliked(_ sender: Any)
    {
        icicicritiillTfValue -= 100000
    }
    
    @IBAction func icicicritiillrightBtnCliked(_ sender: Any)
    {
        icicicritiillTfValue += 100000
    }
    
    @IBAction func iciciaccdethleftBtnCliked(_ sender: Any)
    {
        icicacceDeathTfValue -= 100000
    }
    
    @IBAction func iciciaccdeathrightBtnCliked(_ sender: Any)
    {
        icicacceDeathTfValue += 100000
    }
    
    @IBAction func updateQuotesBtnCliked(_ sender: Any)
    {
//        if(qmobNoTf.text! != "" && qmobNoTf.text!.count == 10)
//        {
            smarttermlifeAPI()
//        }
//        else if(qmobNoTf.text! == ""){
//            TTGSnackbar.init(message: "Enter Mobile Number", duration: .long).show()
//        }
//        else if(qmobNoTf.text!.count != 10){
//            TTGSnackbar.init(message: "Enter 10 digit Mobile Number", duration: .long).show()
//        }
        
    }
    
    
    //---<APICALL>---
    //getDataforQuotes
    func storesmarttermlifeAPI()
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
        let smoker = UserDefaults.standard.string(forKey: "smoker")
        let compPincode = UserDefaults.standard.string(forKey: "compPincode")
        let frstName = UserDefaults.standard.string(forKey: "frstName")
        let lstName = UserDefaults.standard.string(forKey: "lstName")
        let dobTf = UserDefaults.standard.string(forKey: "dobTf")
        let gender = UserDefaults.standard.string(forKey: "gender")
        let mobNoTf = UserDefaults.standard.string(forKey: "mobNoTf")
        let premtermLbl = UserDefaults.standard.string(forKey: "premtermLbl")
        let comppolicytermLbl = UserDefaults.standard.string(forKey: "comppolicytermLbl")
        let compsumAssuredTf = UserDefaults.standard.string(forKey: "compsumAssuredTf")
        
        var params:  [String: Any] = [ "NetPremium": "null","fba_id": FBAId!,"insImage": "null","quote": "null","statusProgress": "0","termRequestId": "0"]
        params["termRequestEntity"] = ["ADBPercentage": "0",
                                       "ADBSA": nil,
                                       "ADHB": "",
                                       "ATPDSA": nil,
                                       "CIBenefit": "",
                                       "CISA": nil,
                                       "CityName": "Mumbai",
                                       "ContactEmail": "finmarttest@gmail.com",
                                       "ContactMobile": mobNoTf,
                                       "ContactName": frstName! + " " + lstName!,
                                       "DeathBenefitOption": "",
                                       "Existing_ProductInsuranceMapping_Id": nil,
                                       "FBAID": FBAId!,
                                       "Frequency": "Yearly",
                                       "HCBSA": nil,
                                       "IncomeTerm": "0",
                                       "IncreaseIncomePercentage": "",
                                       "IncreaseSAPercentage": "",
                                       "InsuredDOB": dobTf,
                                       "InsuredGender": gender,
                                       "InsurerId": "0",
                                       "Is_TabaccoUser": smoker,
                                       "LumpsumAmount": "10000000",
                                       "LumpsumBSAProp": nil,
                                       "LumpsumPercentage": "0",
                                       "MaritalStatus": "",
                                       "MonthlyIncome": "0",
                                       "PPT": premtermLbl,
                                       "PaymentModeValue": "1",
                                       "PaymentOptn": nil,
                                       "PlanTaken": "Life",
                                       "PolicyCommencementDate": dobTf,
                                       "PolicyTerm": comppolicytermLbl,
                                       "PremiumPaymentOption": "",
                                       "ServiceTaxNotApplicable": "",
                                       "SessionID": "",
                                       "State": "Maharashtra",
                                       "SumAssured": compsumAssuredTf,
                                       "SupportsAgentID": "2335",
                                       "TypeOfLife": nil,
                                       "WOP": nil,
                                       "comment": nil,
                                       "created_date": nil,
                                       "crn": nil,
                                       "pincode": compPincode]
        
        let url = "smart-term-life"
        
        FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params as [String : AnyObject], onSuccess: { (userObject, metadata) in
            alertView.close()
            
            self.view.layoutIfNeeded()
            
            let jsonData = userObject as? NSDictionary
            let LifeTermRequestID = jsonData?.value(forKey: "LifeTermRequestID") as AnyObject
            let Response = jsonData?.value(forKey: "Response") as! NSArray
            
            for i in 0..<Response.count {
                
                let dict = Response[i]
                
                let CustomerReferenceID = Response.value(forKey: "CustomerReferenceID") as AnyObject
                let CustomerReferenceIDArr = CustomerReferenceID as! [Int]
                let CustomerReferenceIDArray = CustomerReferenceIDArr.map { String($0) }
                self.CustomerReferenceIDArr = CustomerReferenceIDArray
                
                let ProductPlanName = Response.value(forKey: "ProductPlanName") as AnyObject
                let ProductPlanNameArr = ProductPlanName as! [String]
                let ProductPlanNameArray = ProductPlanNameArr.map { String($0) }
                self.ProductPlanNameArr = ProductPlanNameArray
                
                let SumAssured = Response.value(forKey: "SumAssured") as AnyObject
                let SumAssuredArr = SumAssured as! [Int]
                let SumAssuredArray = SumAssuredArr.map { String($0) }
                self.SumAssuredArr = SumAssuredArray
                
                let PolicyTermYear = Response.value(forKey: "PolicyTermYear") as AnyObject
                let PolicyTermYearArr = PolicyTermYear as! [Int]
                let PolicyTermYearArray = PolicyTermYearArr.map { String($0) }
                self.PolicyTermYearArr = PolicyTermYearArray
                
                let NetPremium = Response.value(forKey: "NetPremium") as AnyObject
                let NetPremiumArr = NetPremium as! [Int]
                let NetPremiumArray = NetPremiumArr.map { String($0) }
                
                let KeyFeatures = Response.value(forKey: "KeyFeatures") as AnyObject
                self.KeyFeaturesArray = KeyFeatures as! [String]
                
                let ProposerPageUrl = Response.value(forKey: "ProposerPageUrl") as AnyObject
                let ProposerPageUrlarr = ProposerPageUrl as! [String]
                self.ProposerPageUrlArray = ProposerPageUrlarr.map { String($0) }
                
                let InsurerLogoName = Response.value(forKey: "InsurerLogoName") as AnyObject
//                let InsurerLogoNameArray = InsurerLogoName as! [String]
//                self.InsurerLogoNameArr = InsurerLogoNameArray.map { String($0) }
//                print("InsurerLogoNameArr=",self.InsurerLogoNameArr)
            
                self.NetPremiumArr = NetPremiumArray
                if(self.fromScreen == "hdfcQuote"){
                    self.qqplanLbl.text! = self.ProductPlanNameArr[1]
                    self.qqRsLbl.text! = "₹ " + self.NetPremiumArr[1]
                    self.ProposerPageUrlString = self.ProposerPageUrlArray[1]
                }
                if(self.fromScreen == "iciciQuote"){
                    self.qqplanLbl.text! = self.ProductPlanNameArr[0]
                    self.qqRsLbl.text! = "₹ " + self.NetPremiumArr[0]
                    self.ProposerPageUrlString = self.ProposerPageUrlArray[0]
                }
                
                
                self.compQuotesTV.reloadData()
                
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
    
    //submitInput
    func smarttermlifeAPI()
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
        
        //--<Quotes>--
        if(fromScreen == "compQuote"){
            compQuotesTV.isHidden = false
            compQuotesTVHeight.constant = 380
            qquoteplanView.isHidden = true
            qquoteplanViewHeight.constant = 0
            qcompView.isHidden = true
            qcompViewHeight.constant = 0
            qfirstlastNameView.isHidden = true
            qfirstlastNameViewHeight.constant = 0
            qmobdobView.isHidden = true
            qmobdobViewHeight.constant = 0
            qgendersmokerView.isHidden = true
            qgendersmokerViewHeight.constant = 0
            qhdfcView.isHidden = true
            qhdfcViewHeight.constant = 0
            qiciciView.isHidden = true
            qiciciViewHeight.constant = 0
            pincodeText = qcompPincodeTf.text!
        }
        if(fromScreen == "hdfcQuote"){
            compQuotesTV.isHidden = true
            compQuotesTVHeight.constant = 0
            qquoteplanView.isHidden = false
            qquoteplanViewHeight.constant = 145
            qfirstlastNameView.isHidden = true
            qfirstlastNameViewHeight.constant = 0
            qcompView.isHidden = true
            qcompViewHeight.constant = 0
            qhdfcView.isHidden = false
            qhdfcViewHeight.constant = 655
            qiciciView.isHidden = true
            qiciciViewHeight.constant = 0
            //            pincodeText = qhdfcPincodeTf.text!
        }
        if(fromScreen == "iciciQuote"){
            compQuotesTV.isHidden = true
            compQuotesTVHeight.constant = 0
            qquoteplanView.isHidden = false
            qquoteplanViewHeight.constant = 145
            qcompView.isHidden = true
            qcompViewHeight.constant = 0
            qhdfcView.isHidden = true
            qhdfcViewHeight.constant = 0
            qiciciView.isHidden = false
            qiciciViewHeight.constant = 732
            //            pincodeText = qicicPincodeTf.text!
        }
        
        let FBAId = UserDefaults.standard.string(forKey: "FBAId")
        let compPincode = UserDefaults.standard.string(forKey: "compPincode")
        let frstName = UserDefaults.standard.string(forKey: "frstName")
        let lstName = UserDefaults.standard.string(forKey: "lstName")
        let mobNoTf = UserDefaults.standard.string(forKey: "mobNoTf")
        
        var params:  [String: Any] = [ "NetPremium": "null","fba_id": FBAId!,"insImage": "null","quote": "null","statusProgress": "0","termRequestId": "0"]
        params["termRequestEntity"] = ["ADBPercentage": nil,
                                       "ADBSA": nil,
                                       "ADHB": "",
                                       "ATPDSA": nil,
                                       "CIBenefit": "",
                                       "CISA": nil,
                                       "CityName": "Mumbai",
                                       "ContactEmail": "finmarttest@gmail.com",
                                       "ContactMobile": mobNoTf,
                                       "ContactName": frstName! + " " + lstName!,
                                       "DeathBenefitOption": deathBenefit,
                                       "Existing_ProductInsuranceMapping_Id": nil,
                                       "FBAID": FBAId!,
                                       "Frequency": qpremFrqLbl.text!,
                                       "HCBSA": nil,
                                       "IncomeTerm": "0",
                                       "IncreaseIncomePercentage": nil,
                                       "IncreaseSAPercentage": nil,
                                       "InsuredDOB": qdobTf.text!,
                                       "InsuredGender": gender,
                                       "InsurerId": InsurerID,
                                       "Is_TabaccoUser": smoker,
                                       "LumpsumAmount": nil,
                                       "LumpsumBSAProp": nil,
                                       "LumpsumPercentage": "0",
                                       "MaritalStatus": "",
                                       "MonthlyIncome": nil,
                                       "PPT": qhdfcpreTermAssuredTf.text!,
                                       "PaymentModeValue": "1",
                                       "PaymentOptn": nil,
//                                       "PlanTaken": "Life",
                                       "PlanTaken": qhdfcOptionLbl.text!.localizedCapitalized,
                                       "PolicyCommencementDate": "01-10-1982",
                                       "PolicyTerm": qhdfcpolicyTermTf.text!,
                                       "PremiumPaymentOption": "Regular Pay",
                                       "ServiceTaxNotApplicable": "",
                                       "SessionID": "",
                                       "State": "Maharashtra",
                                       "SumAssured": qhdfcsumAssuredTf.text!,
                                       "SupportsAgentID": "3422",
                                       "TypeOfLife": nil,
                                       "WOP": nil,
                                       "comment": nil,
                                       "created_date": nil,
                                       "crn": nil,
                                       "pincode": compPincode]
        
        let url = "smart-term-life"
        
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
                UserDefaults.standard.set(String(describing: CustomerReferenceIDString), forKey: "CustomerReferenceIDString")
                UserDefaults.standard.set(String(describing: ProductPlanName), forKey: "ProductPlanName")
                UserDefaults.standard.set(String(describing: sumAssuredString), forKey: "sumAssuredString")
                UserDefaults.standard.set(String(describing: PolicyTermYearString), forKey: "PolicyTermYearString")
                UserDefaults.standard.set(String(describing: NetPremium), forKey: "NetPremium")
                UserDefaults.standard.set(String(describing: ProposerPageUrl), forKey: "ProposerPageUrl")
                
            }
            
            TTGSnackbar.init(message: "Record saved successfully.", duration: .long).show()
            
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


//<addBulletPoints>
class NSAttributedStringHelper {
    static func createBulletedList(fromStringArray strings: [String], font: UIFont? = nil, bullet: String = "\u{2022}") -> NSAttributedString {
        
        let fullAttributedString = NSMutableAttributedString()
        let attributesDictionary: [NSAttributedString.Key: Any]
        
        if font != nil {
            attributesDictionary = [NSAttributedString.Key.font: font!]
        } else {
            attributesDictionary = [NSAttributedString.Key: Any]()
        }
        
        for index in 0..<strings.count {
//            let bulletPoint: String = ""
            var formattedString: String = "\(bullet) \(strings[index])"
            
            if index < strings.count - 1 {
                formattedString = "\(formattedString)\n\n"
            }
            
            let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: formattedString, attributes: attributesDictionary)
            let paragraphStyle = NSAttributedStringHelper.createParagraphAttribute()
            attributedString.addAttributes([NSAttributedString.Key.paragraphStyle: paragraphStyle], range: NSMakeRange(0, attributedString.length))
            fullAttributedString.append(attributedString)
        }
        
        return fullAttributedString
    }
    
    private static func createParagraphAttribute() -> NSParagraphStyle {
        let paragraphStyle: NSMutableParagraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        paragraphStyle.tabStops = [NSTextTab(textAlignment: .left, location: 15, options: NSDictionary() as! [NSTextTab.OptionKey : Any])]
        paragraphStyle.defaultTabInterval = 15
        paragraphStyle.firstLineHeadIndent = 0
        paragraphStyle.headIndent = 11
        return paragraphStyle
    }
    
    //umesh
}
