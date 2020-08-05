//
//  insalesmaterialVC.swift
//  MagicFinmart
//
//  Created by Admin on 23/01/19.
//  Copyright © 2019 Ashwini. All rights reserved.
//

import UIKit
import CustomIOSAlertView
import TTGSnackbar
import SDWebImage
import Alamofire
import AlamofireImage

protocol salesDelegate
{
    func selSalesData()
}

class insalesmaterialVC: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var insalesCView: UICollectionView!
    @IBOutlet weak var passindexLbl: UILabel!
    
    @IBOutlet weak var switchBtn: UISwitch!
    @IBOutlet weak var engLbl: UILabel!
    @IBOutlet weak var hindiLbl: UILabel!
    var imagepathArray = [String]()
    var productId = ""
    var passindexlbl = ""
    var tIndex = Int()
    
    var salesDetailModel = [SalesDetailModel]()
    // var salesDetailHindiModel = [SalesDetailHindiModel]()
    
    var salMainModel = [SalesDetailModel]()
    
    var LangType = "Eng"
    
    var delegateData : salesDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        passindexLbl.text! = passindexlbl
        switchBtn.isOn = false
        
        //--<apiCall>--
        if(productId == "7"){
            
            LoanprodDetailAPI()
        }else{
            materialproductdetailsAPI()
        }
        
    }
 
    
  
    //////////////////////  Method For Orientation   ////////////////////////////
    
    
    override var shouldAutorotate: Bool {
        
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        
        return .portrait
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        
        return .portrait
    }
    
    //////////////////////////
    
    @IBAction func backBtnCliked(_ sender: Any)
    {
        
        self.delegateData?.selSalesData()
        
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
        
    }
    
    @IBAction func homeBtnCliked(_ sender: Any)
    {
        let KYDrawer : KYDrawerController = self.storyboard?.instantiateViewController(withIdentifier: "stbKYDrawerController") as! KYDrawerController
        self.present(KYDrawer, animated: true, completion: nil)
    }
    
    @IBAction func engnhindiSwitchBtnCliked(_ sender: Any)
    {
        if switchBtn.isOn {
            engLbl.textColor = UIColor.gray
            hindiLbl.textColor = UIColor(red: 0/255, green: 125/255, blue: 213/255, alpha: 1.0)
           // insalesCView.isHidden = true
            
             filterSalesData(strLang: "Hindi")
            
            
        } else {
            engLbl.textColor = UIColor(red: 0/255, green: 125/255, blue: 213/255, alpha: 1.0)
            hindiLbl.textColor = UIColor.gray
           // insalesCView.isHidden = false
            
            
             filterSalesData(strLang: "English")
            
        }
        
    }
   
    
    func filterSalesData (strLang : String)  {
        
        print("SalesLanguage",strLang)
        
        let listData : [SalesDetailModel] =  self.salMainModel.filter {
            
            $0.language.contains(strLang)
        }
        
        self.salesDetailModel.removeAll()
        
        self.salesDetailModel = listData
        DispatchQueue.main.async {
            
            self.insalesCView.reloadData()
        }
        
        
    }
    
    //********************************************************************************************//
    //---<collectionView Datasource+Delegates>---
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
       
        return salesDetailModel.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! insalesmaterialCVCell
        
        //***************************************************************************************/
        
        //note : clearing the image and set the tag required for proper smoth of scrolling
        
        //***************************************************************************************/
        

        
        
        if let path = URL(string: salesDetailModel[indexPath.row].image_path){
            
            cell.collImgView.sd_setImage(with: path as URL,placeholderImage: UIImage(named: "finmart_placeholder"))
        }else{
            
            cell.collImgView.sd_setImage(with: Bundle.main.url(forResource: "finmart_placeholder", withExtension: "png"))
        }
        
     
        //        cell.collImgView.image = UIImage()      // nil
        //
        //        cell.collImgView.tag = indexPath.row    // VIP 05
//        if (cell.collImgView.tag == indexPath.row){
//
//
//            Alamofire.request(salesDetailModel[indexPath.row].image_path).responseImage { response in
//                debugPrint(response)
//
//                if case .success(let image) = response.result {
//                    print("image downloaded: \(image)")
//                    cell.collImgView.image = image
//                    self.salesDetailModel[indexPath.row].isLoaded = "Y"
//
//                }else{
//                    print("SALES IMAGE Not PRINTED")
//
//                    cell.collImgView.image = UIImage(named: "finmart_placeholder.png")
//                    self.salesDetailModel[indexPath.row].isLoaded = "N"
//                    //cell.collImgView.tag = 1
//                }
//            }
//        }
        
        
    
        
        return cell
    }
    
    
   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        
//
//        let imgsalesmaterialNew : imgsalesmaterialNewVC = self.storyboard?.instantiateViewController(withIdentifier: "stbimgsalesmaterialNewVC") as! imgsalesmaterialNewVC
//        imgsalesmaterialNew.detailImg =  salesDetailModel[indexPath.row].image_path
//        imgsalesmaterialNew.productID = productId
//        self.addChild(imgsalesmaterialNew)
//        self.view.addSubview(imgsalesmaterialNew.view)
        
        
        let cell = collectionView.cellForItem(at: indexPath)  as! insalesmaterialCVCell
        
        if(  cell.collImgView == nil  ){

            showToast(controller: self, message: "Product Not Found", seconds: 1)
        }else{

            let imgsalesmaterialNew : imgsalesmaterialNewVC = self.storyboard?.instantiateViewController(withIdentifier: "stbimgsalesmaterialNewVC") as! imgsalesmaterialNewVC
            imgsalesmaterialNew.detailImg =  salesDetailModel[indexPath.row].image_path
            imgsalesmaterialNew.productID = productId
            self.addChild(imgsalesmaterialNew)
            self.view.addSubview(imgsalesmaterialNew.view)
        }
        
    }
    
   
    
    
    
    //////////////////////////   Collection FlowLayout  /////////

            func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
                let collectioWidth = collectionView.bounds.width
                return CGSize(width: collectioWidth/2 - 4 , height: collectioWidth/2 - 10)
            }
    
            func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
               return 4
            }
    
            func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
               return 10
            }
    
    //********************************************************************************************//
    //---<APICALL>---
    func materialproductdetailsAPI()
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
            let params: [String: AnyObject] = ["product_id": productId as AnyObject]
            
            let url = "/api/sales-material-product-details"
            
            FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
                alertView.close()
                
                self.view.layoutIfNeeded()
                
                let jsonData = userObject as? NSDictionary
                print("SALES DATA",jsonData)
                let salesDtl = jsonData?.value(forKey: "docs") as! NSArray
                
                if(salesDtl.count > 0){
                    
                    
                    for index in 0...(salesDtl.count)-1 {
                        let aObject = salesDtl[index] as! [String : AnyObject]
                        
                        
                        let model = SalesDetailModel(language: aObject["language"] as! String,
                                                     image_path: aObject["image_path"] as! String,
                                                     imagelink: "",title: "",shorturl: "",url: "", baseurl: "")
                        

                        if(aObject["language"] as! String  == "English"){
                            
                            self.salesDetailModel.append(model)
                        }
                        
                        
                        self.LangType = "Eng"
                        self.salMainModel.append(model)
                        
                        DispatchQueue.main.async {
                            self.insalesCView.reloadData()
                        }
                    }
                    
                }
                
                
            }, onError: { errorData in
                alertView.close()
                print("Error",errorData.errorMessage)
                let snackbar = TTGSnackbar.init(message: errorData.errorMessage, duration: .long)
                snackbar.show()
            }, onForceUpgrade: {errorData in})
            
        }else{
            let snackbar = TTGSnackbar.init(message: Connectivity.message, duration: .middle )
            snackbar.show()
        }
        
    }
    
    
    ////////////////////////////////////////////////
    
    //---<APICALL>---
    func LoanprodDetailAPI()
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
            let params: [String: AnyObject] =
                [ "LoanId": "0" as AnyObject,
                  "FBAID": FBAId as AnyObject,
                  "Source": "Finmart" as AnyObject,]
            
            let url = "/api/getfincampaign"
            
            FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
                alertView.close()
                
                self.view.layoutIfNeeded()
                let jsonData = userObject as? NSArray
                //           print("SALES DATA",jsonData)
                //   let salesDtl = jsonData?.value(forKey: "docs") as! NSArray
                
                
                guard let salesDtl = jsonData else{
                    
                    return
                }
                
                for index in 0...(salesDtl.count)-1 {
                    let aObject = salesDtl[index] as! [String : AnyObject]
                    
                    
                    let model = SalesDetailModel(language: "", image_path: aObject["imagelink"] as! String,
                                                 imagelink: "",title: "",shorturl: "",url: "", baseurl: "")
                    
                    
                    //                let model = SalesDetailModel(language: "", image_path: aObject["imagelink"] as! String,
                    //                                             imagelink: aObject["imagelink"] as! String,
                    //                                             title: aObject["title"] as! String,
                    //                                             shorturl: aObject["shorturl"] as! String,
                    //                                             url: aObject["url"] as! String,
                    //                                             baseurl: aObject["baseurl"] as! String)
                    
                    
                    self.salesDetailModel.append(model)
                    self.LangType = "Eng"
                    
                    DispatchQueue.main.async {
                        self.insalesCView.reloadData()
                    }
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
    
    
}


//extension ViewController: UICollectionViewDelegateFlowLayout {
//
//
//    private func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        return CGSize(width: 50, height: 50)
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 5.0
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 5.0
//    }
//
//
//}


//extension ViewController : UICollectionViewDelegateFlowLayout {
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        let collectioWidth = collectionView.bounds.width
//        return CGSize(width: collectioWidth/3, height: collectioWidth/3)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//       return 0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//       return 0
//    }
//}
