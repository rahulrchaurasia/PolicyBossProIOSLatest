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

class RazorPayementController: UIViewController {

    // RazorPayementController
    override func viewDidLoad() {
        super.viewDidLoad()

       getShareData()
    }
    

    
    func getShareData(){

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
                        let objModel = try decoder.decode(PaymentDetailModel.self, from: data)

                      //  print("Payment ",shareModel.MasterData.Name + shareModel.MasterData.Email)

                      print("response= ",objModel)


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

}
