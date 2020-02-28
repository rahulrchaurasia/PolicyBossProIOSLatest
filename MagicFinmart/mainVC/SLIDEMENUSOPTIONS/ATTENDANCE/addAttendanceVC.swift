//
//  addAttendanceVC.swift
//  MagicFinmart
//
//  Created by Admin on 14/01/19.
//  Copyright © 2019 Ashwini. All rights reserved.
//

import UIKit
import CustomIOSAlertView
import TTGSnackbar
import CoreLocation
import PopupDialog

class addAttendanceVC: UIViewController,UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate {
    
    @IBOutlet weak var loginhistoryLbl: UILabel!
    @IBOutlet weak var loginHistoryTblView: UITableView!
    
    var timer = Timer()
    var seconds = 10
    var attendancemodel = [AttendanceModel]()
    let locManager = CLLocationManager()
    var locationLat: Double = 0
    var locationLong: Double = 0
    var popupPunch = PopupDialog(title: "", message: "")
    var userLocation = CLLocation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let borderColor = UIColor.lightGray
        self.loginhistoryLbl.layer.cornerRadius=4.0;
        self.loginhistoryLbl.layer.borderWidth=2.0;
        self.loginhistoryLbl.layer.borderColor=borderColor.cgColor;
        
//        loginHistoryTblView.isHidden = true
//        self.loginHistoryTblView.reloadData()
        
        self.locManager.requestWhenInUseAuthorization()
        self.locManager.requestAlwaysAuthorization()
        if (CLLocationManager.locationServicesEnabled())
        {
            locManager.delegate = self
            locManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locManager.requestAlwaysAuthorization()
            locManager.startUpdatingLocation()
        }
        
        //Print out location after viewDidLoad()
        print("on viewDidLoad Location is \(locationLat) and \(locationLong)")
        
    }
    
    @IBAction func backBtnCliked(_ sender: Any)
    {
        let KYDrawer : KYDrawerController = self.storyboard?.instantiateViewController(withIdentifier: "stbKYDrawerController") as! KYDrawerController
        self.present(KYDrawer, animated: true, completion: nil)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse{
            getPreviousAttendanceData()
            //            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
            //                if CLLocationManager.isRangingAvailable() {
            //                    // do stuff
            //                }
            //            }
        }
        else if(status == .denied){
            //showSettingPopup()
            
            //print("else executed")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let locValue:CLLocationCoordinate2D = locManager.location!.coordinate
        
        locationLat = locValue.latitude
        locationLong = locValue.longitude
        
    }

    
    @IBAction func attendanceBtnCliked(_ sender: Any)
    {
        //Crashlytics.sharedInstance().crash()
        //RnD
        if( CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways)
        {
//            let longitude = locationLat
//            let latitude = locationLong
            let longitude = Float64((locManager.location?.coordinate.longitude)!)
            let latitude = Float64((locManager.location?.coordinate.latitude)!)
            
//            let defaults=UserDefaults.standard
//            let loggedlat = defaults.string(forKey: FinmartUserDefault.USER_DEFAULT_LAT)
//            let loggedlng = defaults.string(forKey: FinmartUserDefault.USER_DEFAULT_LNG)
            let loggedlat : String = FinmartUserDefault.USER_DEFAULT_LAT
            let loggedlng : String = FinmartUserDefault.USER_DEFAULT_LNG
       
            let coordinate0 = CLLocation(latitude: latitude, longitude: longitude)
            let coordinate1 = CLLocation(latitude: Float64(loggedlat)!, longitude: Float64(loggedlng)!)
            
            let distanceInMeters = coordinate0.distance(from: coordinate1) // result is in meters
            print("Distance=" + String(distanceInMeters))
            if(distanceInMeters > 500){
                manageAttendance(type: "OUT")
            }
            else{
                manageAttendance(type: "IN")
            }
        }
        else{
            showSettingPopup()
        }
        
    }
    
    func manageAttendance(type: String) {
        
        if( CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){
            let longitude = Float64((locManager.location?.coordinate.longitude)!)
            let latitude = Float64((locManager.location?.coordinate.latitude)!)
            
            if(type == "IN"){
                self.markINAttendance(lng:String(longitude), lat: String(latitude))
            }
            else{
                getAddress(lng: String(longitude), lat: String(latitude), type: "OUT")
                //self.markOUTAttendance(lng:String(longitude), lat: String(latitude))
            }
        }
        else{
            showSettingPopup()
        }
        
    }
    
    func showSettingPopup() {
        let title = "Location Services Off"
        //let message = "Turn on Location Services in Settings > Privacy to allow app to determine current location."
        let message = "1) Turn ON the GPS location." + "\n \n 2) Select 'Always allow' in location access for this app."
        
        let popup = PopupDialog(title: title, message: message)
        
        // Create buttons
        let buttonTwo = CancelButton(title: "OK") {
            print("You canceled the dialog.")
        }
        
        let buttonOne = DefaultButton(title: "Settings") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
            } else {
                // [[UIApplication sharedApplication] openURL : [NSURL URLWithString:UIApplicationOpenSettingsURLString]]
                
                // Fallback on earlier versions
            }
            //self.markAttendance(punch: type, lng: lng, lat: lat)
        }
        popup.buttonAlignment = .horizontal
        popup.addButtons([buttonOne, buttonTwo])
        
        // Present dialog
        self.present(popup, animated: true, completion: nil)
    }
    
    func markOUTAttendance(lng: String,lat: String) {
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
        
        let deviceID = UIDevice.current.identifierForVendor?.uuidString
//        let userid = UserDefaults.standard.string(forKey: "uid")
        let iosuid = UserDefaults.standard.string(forKey: "iosuid")
        let emplat = UserDefaults.standard.string(forKey: "emplat")
        let emplng = UserDefaults.standard.string(forKey: "emplng")
        let loanselfemail = UserDefaults.standard.string(forKey: "loanselfemail")
        let loanselfmobile = UserDefaults.standard.string(forKey: "loanselfmobile")
        let loansendname = UserDefaults.standard.string(forKey: "loansendname")
        let hrmsId = UserDefaults.standard.string(forKey: "hrmsid")
//        let params: [String: AnyObject] = [LoginAPI.USERS_POST_KEY_CODE: "12456" as AnyObject, LoginAPI.USERS_POST_KEY_LNG: lng as AnyObject, LoginAPI.USERS_POST_KEY_ALT: lat as AnyObject,LoginAPI.USERS_POST_KEY_DEVID : deviceID as AnyObject,LoginAPI.USERS_POST_KEY_ENTRYTYPE : "Outdoor" as AnyObject,LoginAPI.POST_HRMS_ID: "123456" as AnyObject,"emailid": "shaikhdani26@gmail.com" as AnyObject,"dept" : "" as AnyObject,"mobileno": "9687554545" as AnyObject,"name": "TESTpl Test DATACOMP" as AnyObject,"password": "123456" as AnyObject,"DeviceToken": "" as AnyObject]
        
        let params: [String: AnyObject] = ["uid": iosuid as AnyObject,
                                           "hrmsid": hrmsId as AnyObject,
                                           "emailid": loanselfemail as AnyObject,
                                           "dept": "" as AnyObject,
                                           "mobileno": loanselfmobile as AnyObject,
                                           "name": loansendname as AnyObject,
                                           "password": "20181206" as AnyObject,
                                           "lat": emplat as AnyObject,
                                           "lng": emplng as AnyObject,
                                           "entrytype": "Outdoor" as AnyObject,
                                           "DeviceId": deviceID! as AnyObject,
                                           "DeviceToken": "" as AnyObject]
        
        FinmartRestClient.sharedInstance.authorisedPost(LoginAPI.USERS_ATTENDANCE_EMPLOYEE_SWIPE_OUTDOOR, parameters: params, onSuccess: { (userObject, metadata) in
            let jsonData = userObject as? NSArray
            alertView.close()
            if (jsonData?.count)! > 0{
                self.attendancemodel = [AttendanceModel]()
                for index in 0...(jsonData?.count)!-1 {
                    let aObject = jsonData?[index] as! [String : AnyObject]
                    let model1 = AttendanceModel(date: aObject["datetime"] as! String, type: aObject["entrytype"] as! String,location: aObject["location"] as! String,city: aObject["city"] as! String )
                    
                    self.attendancemodel.append(model1)//+=[model1]
                }
                DispatchQueue.main.async {
                    self.loginHistoryTblView.isHidden = false
                    self.loginHistoryTblView.reloadData()
                }
            }
            
          TTGSnackbar.init(message: "Your outdoor attendance is marked successfully.", duration: .long).show()
        }, onError: { errorData in
            alertView.close()
            let snackbar = TTGSnackbar.init(message: errorData.errorMessage, duration: .long)
            snackbar.show()
        }, onForceUpgrade: {errorData in},service: true)
        
    }
    
    func markINAttendance(lng: String,lat: String) {
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
//        let hrmsid = defaults.string(forKey: FinmartUserDefault.USER_HRMSID)
        let deviceID = UIDevice.current.identifierForVendor?.uuidString
        let iosuid = UserDefaults.standard.string(forKey: "iosuid")
        let emplat = UserDefaults.standard.string(forKey: "emplat")
        let emplng = UserDefaults.standard.string(forKey: "emplng")
        let hrmsId = UserDefaults.standard.string(forKey: "hrmsid")
//        let params: [String: AnyObject] = [LoginAPI.USERS_POST_KEY_CODE: "12456" as AnyObject, LoginAPI.USERS_POST_KEY_LNG: lng as AnyObject, LoginAPI.USERS_POST_KEY_ALT: lat as AnyObject,LoginAPI.USERS_POST_KEY_DEVID : deviceID as AnyObject]
        
        let params: [String: AnyObject] = ["uid": iosuid as AnyObject,
                                           "hrmsid": hrmsId as AnyObject,
                                           "lat": emplat as AnyObject,
                                           "lng": emplng as AnyObject,
                                           "DeviceId": deviceID! as AnyObject,
                                           "DeviceToken": "" as AnyObject]
        
        FinmartRestClient.sharedInstance.authorisedPost(LoginAPI.USERS_ATTENDANCE_EMPLOYEE_SWIPE, parameters: params, onSuccess: { (userObject, metadata) in
            let jsonData = userObject as? NSArray
            alertView.close()
            if (jsonData?.count)! > 0{
                self.attendancemodel = [AttendanceModel]()
                for index in 0...(jsonData?.count)!-1 {
                    let aObject = jsonData?[index] as! [String : AnyObject]
                    let model1 = AttendanceModel(date: aObject["datetime"] as! String, type: aObject["entrytype"] as! String,location: aObject["location"] as! String,city: aObject["city"] as! String )
                    
                    self.attendancemodel.append(model1)//+=[model1]
                }
                DispatchQueue.main.async {
                    self.loginHistoryTblView.isHidden = false
                    self.loginHistoryTblView.reloadData()
                }
            }
            
            TTGSnackbar.init(message: "Your indoor attendance is marked successfully.", duration: .long).show()
        }, onError: { errorData in
            alertView.close()
            let snackbar = TTGSnackbar.init(message: errorData.errorMessage, duration: .long)
            snackbar.show()
        }, onForceUpgrade: {errorData in},service: true)
        
    }
    
    func getPreviousAttendanceData() {
        
        self.loginHistoryTblView.isHidden = false
        
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
        
        let params: [String: AnyObject] = [LoginAPI.USERS_POST_KEY_CODE: iosuid as AnyObject]
        
        FinmartRestClient.sharedInstance.authorisedPost(LoginAPI.USERS_ATTENDANCE_REGISTRATION, parameters: params, onSuccess: { (userObject, metadata) in
            let jsonData = userObject as? NSArray
            alertView.close()
            if (jsonData?.count)! > 0{
                for index in 0...(jsonData?.count)!-1 {
                    let aObject = jsonData?[index] as! [String : AnyObject]
                    let model1 = AttendanceModel(date: aObject["datetime"] as! String, type: aObject["entrytype"] as! String,location: aObject["location"] as! String, city: aObject["city"] as! String )
                    
                    self.attendancemodel.append(model1)//+=[model1]
                }
                DispatchQueue.main.async {
                    self.loginHistoryTblView.isHidden = false
                    self.loginHistoryTblView.reloadData()
                }
            }
            TTGSnackbar.init(message: "Swipe Records available. Please Update your app from playstore.", duration: .long).show()
        }, onError: { errorData in
            alertView.close()
            let snackbar = TTGSnackbar.init(message: errorData.errorMessage, duration: .long)
            snackbar.show()
        }, onForceUpgrade: {errorData in},service: true)
        
    }
    
    func runTimer() {
        timer.invalidate()
        seconds = 10
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(self.updateTimer)), userInfo: nil, repeats: true)
    }
    //
    //
    //
    
    func invalidateTimer() {
        timer.invalidate()
        seconds = 10
    }
    
    @objc func updateTimer() {
        seconds = seconds - 1
        if(seconds < 1){
            popupPunch.dismiss()
            invalidateTimer()
            // PopupDialog.dismiss(popupPunch)
        }
        print(seconds)
    }
    
    func attributedText(data : String)->String{
        
        var myString:NSString = data as NSString// "I AM KIRIT MODI"
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedString.Key.font:UIFont(name: "Georgia", size: 18.0)!])
        myMutableString.addAttribute(NSAttributedString.Key.font, value: UIFont(name: "AmericanTypewriter-Bold", size: 18.0)!, range: NSRange(location:0,length:myString.length))
        
        //        var attributedString = NSMutableAttributedString(string: data as String, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 15.0)])
        //
        //        let boldFontAttribute = [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 15.0)]
        //
        //        // Part of string to be bold
        //        //attributedString.addAttributes(boldFontAttribute, range: data.range(of: "TERMS OF SERVICE"))
        //        attributedString.addAttributes(boldFontAttribute, range: data.range(of: data)))//, range: data.range(of: data as String))
        
        // 4
        return myMutableString.string
    }
    
    func getAddress(lng: String,lat: String,type: String) {
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
        
//        let userId : String = FinmartUserDefault.USER_ID
        let iosuid = UserDefaults.standard.string(forKey: "iosuid")
        
        let params: [String: AnyObject] = [LoginAPI.USERS_POST_KEY_LNG: lng as AnyObject, LoginAPI.USERS_POST_KEY_ALT: lat as AnyObject, LoginAPI.USERS_POST_KEY_CODE: iosuid as AnyObject]
        
        FinmartRestClient.sharedInstance.authorisedPost(LoginAPI.USERS_DISPLAY_LOCATION, parameters: params, onSuccess: { (userObject, metadata) in
            let jsonData = userObject as! NSArray
            if (jsonData.count) > 0{
                self.runTimer()
                for index in 0...(jsonData.count)-1 {
                    let aObject = jsonData[index] as! [String : AnyObject]
                    let title = type + " Punch"
                    var message = "Location: "
                    message += aObject["location"] as! String  + "\n \n "
                    message += "Do you want to mark " + type + " attendance?"
                    // message += self.attributedText(data: "Do you want to mark " + type + " attendance?")
                    self.popupPunch = PopupDialog(title: title, message: message)
                    self.popupPunch.dismiss({
                        self.timer.invalidate()
                        print("dismissed")
                    })
                    // Create buttons
                    let buttonTwo = CancelButton(title: "NO") {
                        self.invalidateTimer()
                        print("You canceled the dialog.")
                    }
                    
                    let buttonOne = DefaultButton(title: "YES") {
                        self.invalidateTimer()
                        self.markOUTAttendance(lng: lng, lat: lat)
                        //self.markAttendance(punch: type, lng: lng, lat: lat)
                    }
                    
                    self.popupPunch.addButtons([buttonOne, buttonTwo])
                    self.popupPunch.buttonAlignment = .horizontal
                    // Present dialog
                    self.present(self.popupPunch, animated: true, completion: nil)
                    
                    
                }
            }
            
            alertView.close()
        }, onError: { errorData in
            alertView.close()
            let snackbar = TTGSnackbar.init(message: errorData.errorMessage, duration: .long)
            snackbar.show()
        }, onForceUpgrade: {errorData in},service: true)
        
    }
    
    
    //--<tableViewDelegate+Datasource>--
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attendancemodel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! addAttenTVCell
        
        let mod = attendancemodel[indexPath.row]
        cell.dateLbl.text = mod.date
        cell.typeLbl.text = mod.type
        cell.cityLbl.text = mod.city
        
        cell.selectionStyle = UITableViewCell.SelectionStyle.none;
        
        cell.mask?.layer.cornerRadius = 10
        //tableView.rowHeight = UITableViewAutomaticDimension
        //        tableView.estimatedRowHeight = 44.0
        cell.locationLbl.text = mod.location
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    

}
