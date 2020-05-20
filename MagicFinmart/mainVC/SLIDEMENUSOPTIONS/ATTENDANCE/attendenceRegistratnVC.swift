//
//  attendenceRegistratnVC.swift
//  MagicFinmart
//
//  Created by iOS Developer on 12/07/19.
//  Copyright © 2019 Ashwini. All rights reserved.
//

import UIKit
import CustomIOSAlertView
import TTGSnackbar
import CoreLocation
import PopupDialog

class attendenceRegistratnVC: UIViewController {

    @IBOutlet weak var aregmobNoTf: ACFloatingTextfield!
    @IBOutlet weak var aregemailIDTf: ACFloatingTextfield!
    @IBOutlet weak var aregLatLongLbl: UILabel!
    
    let locManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboardWhenTappedAround()
        
    }
   
    @IBAction func areggetLocatnBtnCliked(_ sender: Any)
    {
        if( CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){
            let longitude = Float64((locManager.location?.coordinate.longitude)!)
            let latitude = Float64((locManager.location?.coordinate.latitude)!)
            getAddress(lng:String(longitude), lat:String(latitude))
            //getAddress(lng: "72.888313293457031", lat: "19.085813522338867")
            
        }
        else{
            showSettingPopup()
            //            UIApplication.shared.open(URL(string:UIApplicationOpenSettingsURLString)!)
            //locManager.requestAlwaysAuthorization()//.requestWhenInUseAuthorization()requestAlwaysAuthorization
        }
    
    }
    
    @IBAction func aregSubmitBtnCliked(_ sender: Any)
    {
        if(aregmobNoTf.text! != "" && aregemailIDTf.text! != "" && aregLatLongLbl.text! != "")
        {
            updateEmployeeProfile_IOSAPI()
        }
        else if(aregmobNoTf.text! == ""){
            TTGSnackbar.init(message: "Please enter Mobile No", duration: .long).show()
        }
        else if(aregemailIDTf.text! == ""){
            TTGSnackbar.init(message: "Please enter Email ID", duration: .long).show()
        }
        else if(aregLatLongLbl.text! == ""){
            TTGSnackbar.init(message: "Please get Location", duration: .long).show()
        }
        
    }
    
    //---<APICALL>---
    func getAddress(lng: String,lat: String) {
        
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
        
        let emplat = UserDefaults.standard.string(forKey: "emplat")
        let emplng = UserDefaults.standard.string(forKey: "emplng")
        
        let params: [String: AnyObject] = ["lat": emplat as AnyObject, "lng": emplng as AnyObject]
        
        FinmartRestClient.sharedInstance.authorisedPost(LoginAPI.USERS_DISPLAY_LOCATION, parameters: params, onSuccess: { (userObject, metadata) in
            if let jsonData = userObject as? NSArray{
                if (jsonData.count) > 0{
                    for index in 0...(jsonData.count)-1 {
                        let aObject = jsonData[index] as! [String : AnyObject]
                        let location = aObject["location"] as! String
                        //                        self.lblAddress.text = location
                        self.aregLatLongLbl.text = emplat! + "      " + emplng!
                        //                        self.typeLbl.isHidden = false
                        //                        self.latiLbl.isHidden = false
                        //                        self.lblTypeDisplay.isHidden = false
                        //                        self.lblLine.isHidden = false
                        //                        self.lblLatLngDisplay.isHidden = false
                        //                        self.lblAddressDisplay.isHidden = false
                        //                        self.lblAddress.isHidden = false
                        
                        let defaults = UserDefaults.standard
                        if let latitude = defaults.string(forKey: emplat!) , let longitude = defaults.string(forKey: emplng!){
                            let coordinate0 = CLLocation(latitude: Double(lat)!, longitude: Double(lng)!)
                            let coordinate1 = CLLocation(latitude: Double(latitude)!, longitude : Double(longitude)!)
                            let distanceInMeters = coordinate0.distance(from: coordinate1)
//                            if(distanceInMeters>480){
//                                self.typeLbl.text = "Outdoor"
//                            }
//                            else{
//                                self.typeLbl.text = "Indoor"
//
//                            }
                        }
                        else{
                            TTGSnackbar.init(message: "Default location missing", duration: .long).show()
                        }
                        
                        //                        let coordinate0 = CLLocation(latitude: lat, longitude: lng)
                        
                        //                        let coordinate1 = CLLocation(latitude: 19.186214, longitude:72.816745)
                        //
                        //        let distanceInMeters = coordinate0.distance(from: coordinate1) // result is in meters
                        //        print("Distance" + String(distanceInMeters))
                        
                    }
                }
            }
            
            alertView.close()
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
    
    
    func showSettingPopup()   {
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

    
    func updateEmployeeProfile_IOSAPI()
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
        
        let deviceID = UIDevice.current.identifierForVendor?.uuidString
//        let UID = UserDefaults.standard.string(forKey: "uid")
//        print("UID=",UID!)
        let iosuid = UserDefaults.standard.string(forKey: "iosuid")
        let emplat = UserDefaults.standard.string(forKey: "emplat")
        let emplng = UserDefaults.standard.string(forKey: "emplng")
        
        let params: [String: AnyObject] = ["DeviceId":deviceID! as AnyObject,
                                           "DeviceToken":"" as AnyObject,
                                           "uid":iosuid as AnyObject,
                                           "emailid":aregemailIDTf.text! as AnyObject,
                                           "lat":emplat as AnyObject,
                                           "lng":emplng as AnyObject,
                                           "mobileno":aregmobNoTf.text! as AnyObject]
        
        let url = "/AttendanceDetails.svc/UpdateEmployeeProfile_IOS"
        
        FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
            alertView.close()
            
            self.view.layoutIfNeeded()
            
            let jsonData = userObject as? NSDictionary
            
            let Message = jsonData?.value(forKey: "Message") as AnyObject
            let Status = jsonData?.value(forKey: "Status") as! String
            if(Status == "success")
            {
                let addAttendance : addAttendanceVC = self.storyboard?.instantiateViewController(withIdentifier: "stbaddAttendanceVC") as! addAttendanceVC
                self.present(addAttendance, animated: true, completion: nil)
                
                TTGSnackbar.init(message: "Profile Updated Successfully.", duration: .long).show()
            }
            
            
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
    

}
