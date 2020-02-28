//
//  attenReportVC.swift
//  MagicFinmart
//
//  Created by Admin on 14/01/19.
//  Copyright © 2019 Ashwini. All rights reserved.
//

import UIKit
import CustomIOSAlertView
import TTGSnackbar

class attenReportVC: UIViewController,SelectedDateDelegate,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var fromDateTf: ACFloatingTextfield!
    @IBOutlet weak var toDateTf: ACFloatingTextfield!
    @IBOutlet weak var reportTView: UITableView!
    
    var Dates = ""
    var fromDate : Int64 = 0
    var toDate : Int64 = 0
    var attendancemodel = [AttendanceModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currentDateTime = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy";
        fromDateTf.text! = "\(dateFormatter.string(from: currentDateTime))"
        toDateTf.text! = "\(dateFormatter.string(from: currentDateTime))"
        let curDate = dateFormatter.date(from: fromDateTf.text!)
        let curDate2 = dateFormatter.date(from: fromDateTf.text!)
        let intDate = Int64(curDate!.timeIntervalSince1970*1000)
        let intDate2 = Int64(curDate2!.timeIntervalSince1970*1000)
        fromDate = intDate
        toDate = intDate2

    }
    
    @IBAction func backBtnCliked(_ sender: Any)
    {
        let KYDrawer : KYDrawerController = self.storyboard?.instantiateViewController(withIdentifier: "stbKYDrawerController") as! KYDrawerController
        self.present(KYDrawer, animated: true, completion: nil)
    }
    
    @IBAction func fromDateBtnCliked(_ sender: Any)
    {
        self.view.endEditing(true)
        let DatePicker : DatePickerVC = storyboard?.instantiateViewController(withIdentifier: "stbDatePickerVC") as! DatePickerVC
        self.addChild(DatePicker)
        self.view.addSubview(DatePicker.view)
        DatePicker.dateDelegate = self
        Dates = "fromDate"
    }
    
    @IBAction func toDateBtnCliked(_ sender: Any)
    {
        self.view.endEditing(true)
        let DatePicker : DatePickerVC = storyboard?.instantiateViewController(withIdentifier: "stbDatePickerVC") as! DatePickerVC
        self.addChild(DatePicker)
        self.view.addSubview(DatePicker.view)
        DatePicker.dateDelegate = self
        Dates = "toDate"
    }
    
    
    func getDateData(currDate: String, fromScreen: String)
    {
        print(currDate)
        if(Dates == "fromDate")
        {
            fromDateTf.text = currDate
            fromDateTf.textColor = UIColor.black
        }
        else{
            toDateTf.text = currDate
            toDateTf.textColor = UIColor.black
        }
        
    }
    
    func getintData(indata:Int)
    {
        print("indata=",indata)
        if(Dates == "fromDate")
        {
            fromDate = Int64(indata)
            print(fromDate)
        }else{
            toDate = Int64(indata)
            print(toDate)
        }
    }
    
    @IBAction func genrateBtnCliked(_ sender: Any)
    {
        if(fromDateTf.text == ""){
            TTGSnackbar.init(message: "Please Enter From Date", duration: .long).show()
        }
        else if(toDateTf.text == ""){
            TTGSnackbar.init(message: "Please Enter To Date", duration: .long).show()
        }
        else if(fromDate > toDate){
            TTGSnackbar.init(message: "From date should be less than to date", duration: .long).show()
        }
        else if (fromDateTf.text != "" && toDateTf.text != ""){
            attendancemodel = [AttendanceModel]()
            getPreviousAttendanceData()
        }
    }
    
    
    func getPreviousAttendanceData() {
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
//        let defaults=UserDefaults.standard
//        let userCode = defaults.string(forKey: FinmartUserDefault.USER_CODE)
        let iosuid = UserDefaults.standard.string(forKey: "iosuid")
        
        let params: [String: AnyObject] = [LoginAPI.USERS_POST_KEY_CODE: iosuid as AnyObject,LoginAPI.POST_FROM_DATE : fromDate as AnyObject, LoginAPI.POST_TO_DATE : toDate as AnyObject]
        
        FinmartRestClient.sharedInstance.authorisedPost(LoginAPI.USERS_SWIPE_DETAIL, parameters: params, onSuccess: { (userObject, metadata) in
            let jsonData = userObject as? NSArray
            alertView.close()
            if (jsonData?.count)! > 0{
                for index in 0...(jsonData?.count)!-1 {
                    let aObject = jsonData?[index] as! [String : AnyObject]
                    let model1 = AttendanceModel(date: aObject["datetime"] as! String, type: aObject["entrytype"] as! String,location: aObject["location"] as! String, city: aObject["city"] as! String )
                    
                    self.attendancemodel.append(model1)//+=[model1]
                }
                DispatchQueue.main.async {
                    self.reportTView.reloadData()
                }
            }
        }, onError: { errorData in
            alertView.close()
            let snackbar = TTGSnackbar.init(message: errorData.errorMessage, duration: .long)
            snackbar.show()
            DispatchQueue.main.async {
                self.reportTView.reloadData()
            }
            
        }, onForceUpgrade: {errorData in},service: true)
        
        
    }
    
    
    //--<TableViewDatasource+Delegate>--
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attendancemodel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! attenReportTVCell
        
        let mod = attendancemodel[indexPath.row]
        cell.rdateLbl.text = mod.date
        cell.rtypeLbl.text = mod.type
        cell.rcityLbl.text = mod.city
        
        cell.selectionStyle = UITableViewCell.SelectionStyle.none;
        
        //cell.mainview.layer.cornerRadius = 10
        //tableView.rowHeight = UITableViewAutomaticDimension
        //        tableView.estimatedRowHeight = 44.0
        cell.rlocationLbl.text = mod.location
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}
