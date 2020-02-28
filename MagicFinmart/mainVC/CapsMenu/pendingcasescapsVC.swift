//
//  pendingcasescapsVC.swift
//  MagicFinmart
//
//  Created by Ashwini on 17/12/18.
//  Copyright © 2018 Ashwini. All rights reserved.
//

import UIKit
import CustomIOSAlertView
import TTGSnackbar

class pendingcasescapsVC: UIViewController,UITableViewDataSource,UITableViewDelegate,MyCellDelegate {
    
    @IBOutlet weak var pendingTV: UITableView!
    var customerName = [String]()
    var category = [String]()
    var applnStatus = [String]()
    var qaatype = [String]()
    var ppendingdays = [String]()
    var bankImage = [String]()
    var lead_Id = [String]()
    var lbl = ""
    var ids = [String]()
    var indexID = ""
    var quoteType = [String]()
    var quttype = ""
    var Message = ""
    var ApplnStatusPercntg = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ids",ids)
//        pendingTV.reloadData()

    }
    
    //6. Implement Delegate Method
    func btnDeleteTapped(cell: pendingcaseTVCell)
    {
        //Get the indexpath of cell where button was tapped
        let indexPath = self.pendingTV.indexPath(for: cell)
        indexID = ids[indexPath!.row]
        quttype = quoteType[indexPath!.row]
        deletependingcasesAPI()
        if(indexID != "")
        {
            customerName.remove(at: (indexPath?.row)!)
            category.remove(at: (indexPath?.row)!)
            ppendingdays.remove(at: (indexPath?.row)!)
            qaatype.remove(at: (indexPath?.row)!)
            ApplnStatusPercntg.remove(at: (indexPath?.row)!)
//            self.pendingTV!.reloadData()
            
        }
        
    }

    @IBAction func pendingCallBtnCliked(_ sender: Any)
    {
        callNumber(phoneNumber:"8237362825")
    }
    private func callNumber(phoneNumber:String) {
        
        if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
            
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
    }
    
    @IBAction func pendingEmailBtnCliked(_ sender: Any)
    {
        //        let text = "This is the text...."
        //        let image = UIImage(named: "Product")
        let myWebsite = NSURL(string:"pending")
        let shareAll = [myWebsite as Any]
        let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
        
    }
    

   //---<tableViewDatasource+Delegtes>---
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customerName.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! pendingcaseTVCell
        let borderColor = UIColor.gray
        cell.pendingcaseTVCellView.layer.cornerRadius=4.0;
        cell.pendingcaseTVCellView.layer.borderWidth=1.0;
        cell.pendingcaseTVCellView.layer.borderColor=borderColor.cgColor;
        //--<loadData>--
        cell.pendingtitleLbl.text! = customerName[indexPath.row]
        cell.categoryLbl.text! = category[indexPath.row]
        cell.pendingdyLbl.text! = ppendingdays[indexPath.row]
        cell.percentageLbl.text! = ApplnStatusPercntg[indexPath.row]+"%"
        let borderClr = UIColor.init(red: 0/255.0, green: 125/255.0, blue: 213/255.0, alpha: 1)
        if(lbl == "LOAN"){
            cell.qtypecirclLbl.isHidden = true
            cell.qtypeLbl.layer.borderWidth=1.0;
            cell.qtypeLbl.layer.borderColor=borderClr.cgColor;
            cell.qtypeLbl.layer.cornerRadius = 2.0
            cell.qtypeLbl.text! = qaatype[indexPath.row]
        }
        else if(lbl == "INSURANCE"){
            cell.qtypeLbl.isHidden = true
            cell.qtypecirclLbl.layer.borderWidth=1.0;
            cell.qtypecirclLbl.layer.borderColor=borderClr.cgColor;
            cell.qtypecirclLbl.text! = qaatype[indexPath.row]
            cell.qtypecirclLbl.layer.cornerRadius = cell.qtypecirclLbl.frame.size.width/2
            cell.qtypecirclLbl.clipsToBounds = true
        }
        //loadimages
        print("bankImage=",bankImage)
//        if(bankImage.isEmpty == false)
//        {
//            let imgURL = NSURL(string: bankImage[indexPath.row])
//            if imgURL != nil {
//                let data = NSData(contentsOf: (imgURL as URL?)!)
//                cell.pImageView.image = UIImage(data: data! as Data)
//            }
//        }
        
        let imgURL = NSURL(string: bankImage[indexPath.row])
        if (imgURL != nil){
            let data = NSData(contentsOf: (imgURL as URL?)!)
            cell.pImageView.image = UIImage(data: data! as Data)
        }

//        if let imageURL = URL(string: bankImage[indexPath.row]) {
//            DispatchQueue.global().async {
//                let data = try? Data(contentsOf: imageURL)
//                if let data = data {
//                    let image = UIImage(data: data)
//                    DispatchQueue.main.async {
//                        cell.pImageView.image = image
//                    }
//                }
//            }
//        }
        
        //--<show percentage on progressView>--
        let counter:Int = 0
        let value = ApplnStatusPercntg[indexPath.row]
        let value1:Float = Float(value)!/100.0
        print("value1",value1)
        let animated = counter != 0
        cell.progressView.setProgress(value1, animated: animated)
    
        //--deleteRow--
        cell.delegate = self
     
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 275
    }
    
    //---<APICALL>---
    func deletependingcasesAPI()
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
        
        let params: [String: AnyObject] = ["id":indexID as AnyObject,
                                           "quotetype":quttype as AnyObject]
        
        let url = "/api/delete-pending-cases"
        
        FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
            alertView.close()
            
            self.view.layoutIfNeeded()
            
            let jsonData = userObject as? NSArray
            self.Message = ((jsonData![0] as AnyObject).value(forKey: "Message") as AnyObject) as! String
            
            self.pendingTV.reloadData()
            
        }, onError: { errorData in
            alertView.close()
            let snackbar = TTGSnackbar.init(message: errorData.errorMessage, duration: .long)
            snackbar.show()
        }, onForceUpgrade: {errorData in})
        
    }

    
    
}
