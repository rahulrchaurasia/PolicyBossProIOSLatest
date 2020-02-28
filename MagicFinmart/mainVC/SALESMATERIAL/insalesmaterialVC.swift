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

class insalesmaterialVC: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    @IBOutlet weak var insalesCView: UICollectionView!
    @IBOutlet weak var passindexLbl: UILabel!
    
    @IBOutlet weak var switchBtn: UISwitch!
    @IBOutlet weak var engLbl: UILabel!
    @IBOutlet weak var hindiLbl: UILabel!
    var imagepathArray = [String]()
    var productId = ""
    var passindexlbl = ""
    var tIndex = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        passindexLbl.text! = passindexlbl
        switchBtn.isOn = false
        
        //--<apiCall>--
        materialproductdetailsAPI()
    }
    
    @IBAction func backBtnCliked(_ sender: Any)
    {
        let Salesmaterial : SalesmaterialVC = self.storyboard?.instantiateViewController(withIdentifier: "stbSalesmaterialVC") as! SalesmaterialVC
        Salesmaterial.fromScreen = "passindex"
        Salesmaterial.indexR = tIndex
        self.addChild(Salesmaterial)
        self.view.addSubview(Salesmaterial.view)
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
            insalesCView.isHidden = true
        } else {
            engLbl.textColor = UIColor(red: 0/255, green: 125/255, blue: 213/255, alpha: 1.0)
            hindiLbl.textColor = UIColor.gray
            insalesCView.isHidden = false
        }
    }
    
    
    //---<collectionView Datasource+Delegates>---
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagepathArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! insalesmaterialCVCell
        
        //loadimages
        let imgURL = NSURL(string: imagepathArray[indexPath.row])
        if imgURL != nil {
            let data = NSData(contentsOf: (imgURL as URL?)!)
            cell.collImgView.image = UIImage(data: data! as Data)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let imgsalesmaterial : imgsalesmaterialVC = self.storyboard?.instantiateViewController(withIdentifier: "stbimgsalesmaterialVC") as! imgsalesmaterialVC
        imgsalesmaterial.detailImg = imagepathArray[indexPath.row]
        self.addChild(imgsalesmaterial)
        self.view.addSubview(imgsalesmaterial.view)
    }

    //---<APICALL>---
    func materialproductdetailsAPI()
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
            let docs = jsonData?.value(forKey: "docs") as AnyObject
            let image_path = docs.value(forKey: "image_path") as AnyObject
            self.imagepathArray = image_path as! [String]
            
//            DispatchQueue.main.async
//            {
                    self.insalesCView.reloadData()
//            }
            
            
        }, onError: { errorData in
            alertView.close()
            let snackbar = TTGSnackbar.init(message: errorData.errorMessage, duration: .long)
            snackbar.show()
        }, onForceUpgrade: {errorData in})
        
    }

}
