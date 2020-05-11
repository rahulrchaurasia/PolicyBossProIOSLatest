//
//  PaymentMainController.swift
//  MagicFinmart
//
//  Created by iOS Developer on 09/05/20.
//  Copyright © 2020 Ashwini. All rights reserved.
//

import UIKit
import Razorpay
import CustomIOSAlertView
import TTGSnackbar
import Alamofire

class PaymentMainController: UIViewController ,RazorpayPaymentCompletionProtocol {
   
    
  

    let razorpaykeyLive = "rzp_live_b7vQ8lyFs69syy"
    let rupee = "\u{20B9}"
    
    var razorpay: Razorpay!
   
    
    @IBOutlet weak var btnCancel: UIButton!
    
    @IBOutlet weak var btnPayment: UIButton!
    
    @IBOutlet weak var cardview: UIView!
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var lblCustomerName: UILabel!
    
    
    @IBOutlet weak var lblProductName: UILabel!
    
    @IBOutlet weak var lblAmount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        razorpay = Razorpay.initWithKey(razorpaykeyLive, andDelegate: self)
        
       initialize()
    
         getPaymentDetail()
    }
    
    
    func initialize()
    {
        mainView.backgroundColor = .white

        mainView.layer.cornerRadius = 10.0

        mainView.layer.shadowColor = UIColor.gray.cgColor

        mainView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)

        mainView.layer.shadowRadius = 6.0

        mainView.layer.shadowOpacity = 0.7
     
        
       
        
    }
    
    
    @IBAction func btnPayment(_ sender: Any) {
        
       
        showPaymentForm()
    }
    
    
    @IBAction func btnCancel(_ sender: Any) {
        
        print("cancel")
        
        
        
        //            let razorController : PaymentController = self.storyboard?.instantiateViewController(withIdentifier: "stbPaymentController") as! PaymentController
        //
        //            self.present(razorController, animated:true, completion: nil)
        
//        let LifeInsurance : LifeInsuranceVC = self.storyboard?.instantiateViewController(withIdentifier: "stbLifeInsuranceVC") as! LifeInsuranceVC
//        present(LifeInsurance, animated:true, completion: nil)
//
//        let KYDrawer : KYDrawerController = self.storyboard?.instantiateViewController(withIdentifier: "stbKYDrawerController") as! KYDrawerController
//        present(KYDrawer, animated: true, completion: nil)
        
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
         let KYDrawer : KYDrawerController = storyboard.instantiateViewController(withIdentifier: "stbKYDrawerController") as! KYDrawerController
        
         present(KYDrawer, animated: true, completion: nil)
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        //show window
//        appDelegate.window?.rootViewController = vc
    }
    

    func onPaymentError(_ code: Int32, description str: String) {
        
//        let PaymentCancelVC : PaymentCancelController = self.storyboard?.instantiateViewController(withIdentifier: "stbPaymentCancelController") as! PaymentCancelController
//        present(PaymentCancelVC, animated:true, completion: nil)
        
        
       let PaymentCancelVC : PaymentCancelController = self.storyboard?.instantiateViewController(withIdentifier: "stbPaymentCancelController") as! PaymentCancelController
        self.addChild(PaymentCancelVC)
        self.view.addSubview(PaymentCancelVC.view)
    }
    
    func onPaymentSuccess(_ payment_id: String) {
        
    }
   
    
    
    internal func showPaymentForm(){
        navigationController?.setNavigationBarHidden(true, animated: true)
        let options: [String:Any] = [
            "amount": "100", //This is in currency subunits. 100 = 100 paise= INR 1.
            "currency": "INR",//We support more that 92 international currencies.
            "description": "purchase description",
            "image": "https://www.rupeeboss.com/image/logo.png",
            
            "name": "Platform for onboarding for Fin-Mart",
            "prefill": [
                "contact": "9773113793",
                "email": "rahulrchaurasia@gmail.com"
            ],
            "theme": [
                "color": "#009ee3"
            ]
        ]
        razorpay.open(options)
    }
    
    
    func getPaymentDetail(){
        
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
            
            
            let parameter  :[String: AnyObject] = [
                
                "FBAID": FBAId as AnyObject
            ]
            let endUrl = "/api/getfbadataforrpay"
            let url =  FinmartRestClient.baseURLString  + endUrl
            print("urlRequest= ",url)
            print("parameter= ",parameter)
            Alamofire.request(url, method: .post, parameters: parameter).responseJSON(completionHandler: { (response) in
                switch response.result {
                    
                case .success(let value):
                    
                    alertView.close()
                    
                    self.view.layoutIfNeeded()
                    guard let data = response.data else { return }
                    do {
                        let decoder = JSONDecoder()
                        let obj = try decoder.decode(PaymentDetailModel.self, from: data)
                        
                        //  print("Payment ",shareModel.MasterData.Name + shareModel.MasterData.Email)
                        
                        print("response= ",obj)
                        
                        if obj.StatusNo == 0 {
                            self.setPaymentDetail(objModel: obj.MasterData)
                            
                        }else{
                            
                            let snackbar = TTGSnackbar.init(message: obj.Message , duration: .long)
                            snackbar.show()
                        }
                        
                        
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
    
    func setPaymentDetail(objModel :PaymentDetailMasterData ){
        
        lblCustomerName.text = objModel.Name + "-" + objModel.CustID
        lblProductName.text  = objModel.productname
        lblAmount.text       = rupee + " " + objModel.displayamounts
    }
}


