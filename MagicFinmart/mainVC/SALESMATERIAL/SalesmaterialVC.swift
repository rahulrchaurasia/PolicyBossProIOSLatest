//
//  SalesmaterialVC.swift
//  MagicFinmart
//
//  Created by Ashwini on 14/12/18.
//  Copyright © 2018 Ashwini. All rights reserved.
//

import UIKit
import CustomIOSAlertView
import TTGSnackbar

class SalesmaterialVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
   
    @IBOutlet weak var salesMTView: UITableView!
    @IBOutlet weak var salesmaterialdownldView: UIView!
    @IBOutlet weak var salesmaterialViewLbl: UILabel!
    @IBOutlet weak var salesmaterialdownldbckView: UIView!
    
    var ProductNameArray = [String]()
    var ProductimageArray = [String]()
    var CountArray = [Int]()
    var ProductIdArray = [String]()
    var countstringArray = [String]()
    var ProductIdstringArray = [String]()
    var productID = ""
    var productName = ""
    var productCnt = Int()
    var fromScreen = ""
    var sMaterialModel = [salesMaterialModel]()
    var indexR = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        salesmaterialdownldbckView.isHidden = true
//        salesmaterialdownldView.isHidden = true
        
        //--<apiCall>--
        salesmaterialproductAPI()
        
    }
    
    @IBAction func salesMaterialBackBtn(_ sender: Any)
    {
        let KYDrawer : KYDrawerController = self.storyboard?.instantiateViewController(withIdentifier: "stbKYDrawerController") as! KYDrawerController
        self.present(KYDrawer, animated: true, completion: nil)
    }
    
    @IBAction func homeBtnCliked(_ sender: Any)
    {
        let KYDrawer : KYDrawerController = self.storyboard?.instantiateViewController(withIdentifier: "stbKYDrawerController") as! KYDrawerController
        self.present(KYDrawer, animated: true, completion: nil)
    }
    
    //---<tableView Datasource+Delegates>---
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 90
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return ProductNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = salesMTView.dequeueReusableCell(withIdentifier: "cell") as! salesmaterialTVCell
        
        cell.salescellCountLbl.layer.cornerRadius = cell.salescellCountLbl.frame.size.width/2
        cell.salescellCountLbl.clipsToBounds = true
        salesMTView.backgroundColor = UIColor.init(red: 234/255, green: 234/255, blue: 234/255, alpha: 1)
        //shadowColor for uiview
        cell.salescellView.layer.cornerRadius = 4.0
        cell.salescellView.layer.shadowColor = UIColor.lightGray.cgColor
        cell.salescellView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        cell.salescellView.layer.shadowRadius = 10.0
        cell.salescellView.layer.shadowOpacity = 0.8
        
        cell.salescellLbl.text! = ProductNameArray[indexPath.row]
//        cell.salescellCountLbl.text! = countstringArray[indexPath.row]
        //loadimages
        let imgURL = NSURL(string: ProductimageArray[indexPath.row])
        if imgURL != nil {
            let data = NSData(contentsOf: (imgURL as URL?)!)
            cell.salesmcellImgView.image = UIImage(data: data! as Data)
        }
        
        let productCnt = UserDefaults.standard.string(forKey: "productCnt")
//        print("productCnt=",productCnt!)
        let indexR = UserDefaults.standard.string(forKey: "indexR")
        
        let mod = sMaterialModel[indexPath.row]
        let pCount = mod.productCount
        let proCount = String(pCount)
        if(fromScreen == "passindex")
        {
            if(indexR != nil){
                if(productCnt == proCount)
                {
                    cell.salescellCountLbl.text = proCount
                    cell.salescellCountLbl.isHidden = true
                }else{
                    cell.salescellCountLbl.text = proCount
                    cell.salescellCountLbl.isHidden = false
                }
            }
            else{
                if(productCnt != proCount)
                {
                    cell.salescellCountLbl.text = proCount
                    cell.salescellCountLbl.isHidden = false
                }
            }
            
        }else{
            cell.salescellCountLbl.text = proCount
        }
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let cell = tableView.cellForRow(at: indexPath) as! salesmaterialTVCell
//        cell.salescellCountLbl.isHidden = true
        productID = ProductIdstringArray[indexPath.row]
        productName = ProductNameArray[indexPath.row]
        let mod = sMaterialModel[indexPath.row]
        productCnt = mod.productCount
        UserDefaults.standard.set(String(describing: productCnt), forKey: "productCnt")

        indexR = indexPath.row
        UserDefaults.standard.set(String(describing: indexR), forKey: "indexR")
        
        if (cell.salescellCountLbl.isHidden == false)
        {
            salesmaterialdownldbckView.isHidden = false
            salesmaterialViewLbl.text! = countstringArray[indexPath.row]+" new Images are available for downloading."
        }
        else{
            cell.salescellCountLbl.isHidden = true
            let insalesmaterial : insalesmaterialVC = self.storyboard?.instantiateViewController(withIdentifier: "stbinsalesmaterialVC") as! insalesmaterialVC
            insalesmaterial.productId = ProductIdstringArray[indexPath.row]
            insalesmaterial.passindexlbl = ProductNameArray[indexPath.row]
            self.addChild(insalesmaterial)
            self.view.addSubview(insalesmaterial.view)
            
        }
        
        
    }
  
    //---<APICALL>---
    func salesmaterialproductAPI()
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
        let params: [String: AnyObject] = [:]
        
        let url = "/api/sales-material-product"
        
        FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
            alertView.close()
            
            self.view.layoutIfNeeded()
            
            let jsonData = userObject as? NSArray
            let Product_Name = jsonData?.value(forKey: "Product_Name") as AnyObject
//            print("Product_Name= ", Product_Name)
            self.ProductNameArray = Product_Name as! [String]
            //Convert int to string array
            let Count = jsonData?.value(forKey: "Count") as AnyObject
            self.CountArray = Count as! [Int]
            self.countstringArray = self.CountArray.map { String($0) }


            let Product_Id = jsonData?.value(forKey: "Product_Id") as AnyObject
            self.ProductIdArray = Product_Id  as! [String]
            
            self.ProductIdstringArray = self.ProductIdArray
            
            let Product_image = jsonData?.value(forKey: "Product_image") as AnyObject
            self.ProductimageArray = Product_image as! [String]
            
            if (jsonData?.count)! > 0{
                self.sMaterialModel = [salesMaterialModel]()
                for index in 0...(jsonData?.count)!-1 {
                    let aObject = jsonData?[index] as! [String : AnyObject]
                    let model1 = salesMaterialModel(productCount: aObject["Count"] as! Int)
                    
                    self.sMaterialModel.append(model1)//+=[model1]
                }
//                DispatchQueue.main.async {
                    self.salesMTView.reloadData()
//                }
            }
//            DispatchQueue.main.async
//            {
//                self.salesMTView.reloadData()
//            }
            
            
        }, onError: { errorData in
            alertView.close()
            let snackbar = TTGSnackbar.init(message: errorData.errorMessage, duration: .long)
            snackbar.show()
        }, onForceUpgrade: {errorData in})
        
    }
    
    
    @IBAction func closeBtnCliked(_ sender: Any)
    {
        salesmaterialdownldbckView.isHidden = true
    }
    
    @IBAction func laterBtnCliked(_ sender: Any)
    {
        salesmaterialdownldbckView.isHidden = true
//        salesmaterialdownldView.isHidden = true
    }
    
    @IBAction func downloadBtnCliked(_ sender: Any)
    {
        let insalesmaterial : insalesmaterialVC = self.storyboard?.instantiateViewController(withIdentifier: "stbinsalesmaterialVC") as! insalesmaterialVC
        insalesmaterial.productId = productID
        insalesmaterial.passindexlbl = productName
        insalesmaterial.tIndex = indexR
        self.addChild(insalesmaterial)
        self.view.addSubview(insalesmaterial.view)
        
    }
    

}
