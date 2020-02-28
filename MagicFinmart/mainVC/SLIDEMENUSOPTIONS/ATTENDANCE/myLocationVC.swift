//
//  myLocationVC.swift
//  MagicFinmart
//
//  Created by Admin on 14/01/19.
//  Copyright © 2019 Ashwini. All rights reserved.
//

import UIKit
import CoreLocation
import PopupDialog
import TTGSnackbar
import CustomIOSAlertView

class myLocationVC: UIViewController {

    @IBOutlet weak var LocationdetailsView: UIView!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var latiLbl: UILabel!
    @IBOutlet weak var longiLbl: UILabel!
    
    let locManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LocationdetailsView.isHidden = true

    }
    
    @IBAction func backBtnCliked(_ sender: Any)
    {
        let KYDrawer : KYDrawerController = self.storyboard?.instantiateViewController(withIdentifier: "stbKYDrawerController") as! KYDrawerController
        self.present(KYDrawer, animated: true, completion: nil)
    }
    
    @IBAction func getLocationBtnCliked(_ sender: Any)
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
    
    func getAddress(lng: String,lat: String) {
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
                        self.LocationdetailsView.isHidden = false
                        self.latiLbl.text = emplat! + "      " + emplng!
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
                            if(distanceInMeters>480){
                                self.typeLbl.text = "Outdoor"
                            }
                            else{
                                self.typeLbl.text = "Indoor"
                                
                            }
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
    
    
    
}
