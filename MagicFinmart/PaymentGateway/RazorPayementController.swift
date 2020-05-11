//
//  RazorPayementController.swift
//  MagicFinmart
//
//  Created by iOS Developer on 06/05/20.
//  Copyright © 2020 Ashwini. All rights reserved.
//

import UIKit
import CustomIOSAlertView
import TTGSnackbar
import SwiftyJSON
import Alamofire
import SDWebImage
import Razorpay

 let razorpaykey = "rzp_live_b7vQ8lyFs69syy"

class RazorPayementController: UIViewController ,RazorpayPaymentCompletionProtocol {
    
    
   
    @IBOutlet weak var mainView: UIView!
   
    @IBOutlet weak var lblCustomerName: UILabel!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    
    
    var razorpay: Razorpay!
    let rupee = "\u{20B9}"
    
    
    // RazorPayementController
    override func viewDidLoad() {
        super.viewDidLoad()

         razorpay = Razorpay.initWithKey(razorpaykey, andDelegate: self)
        
        initialize()
        
         getPaymentDetail()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showPaymentForm()
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
    
    
    
   
    @IBAction func btnBuyClick(_ sender: UIButton) {
        
          print("BUY NOW.")
    }
    
    
    @IBAction func btnCancelClick(_ sender: UIButton) {
        
        
         print("BUY NOW.")
    }
    
    ///////////
    
   
    
    func onPaymentSuccess(_ payment_id: String) {
        
      
    }
    
    func onPaymentError(_ code: Int32, description str: String){
        
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
    
    //////////////////
    
    internal func showPaymentForm(){
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
}
