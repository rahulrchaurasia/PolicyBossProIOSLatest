//
//  cmnApplictnLifeinsVC.swift
//  MagicFinmart
//
//  Created by Admin on 04/03/19.
//  Copyright © 2019 Ashwini. All rights reserved.
//

import UIKit

class cmnApplictnLifeinsVC: UIViewController,UITableViewDataSource,UITableViewDelegate,lyfInscellbtnDelegate {
    
    @IBOutlet weak var atableView: UITableView!
    
    var afrstNameArray = [String]()
    var asumArray = [String]()
    var aquoteDateArray = [String]()
    var amodeArray = [String]()
    var astatusArray = [String]()
    var astatusDateArray = [String]()
    var aappNoArray = [String]()
    var apremiumppArray = [String]()
    var atermpptArray = [String]()

    @IBOutlet weak var searchTF: ACFloatingTextfield!
    var searchActive : Bool = false
    var filtered:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTF.addTarget(self, action: #selector(cmnApplictnLifeinsVC.textFieldDidChange(_:)),
                           for: UIControl.Event.editingChanged)
        
    }
    
    @objc func textFieldDidChange(_ textField: UITextField)
    {
        // filter tableViewData with textField.text
        let searchText  = searchTF.text!
        filtered = afrstNameArray.filter({ (text) -> Bool in
            let tmp: NSString = text as NSString
            let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return range.location != NSNotFound
        })
        if(searchTF.text!.count >= 2){
            searchActive = true;
        } else {
            searchActive = false;
        }
        
        self.atableView.reloadData()
        
    }

    
    //--<tableView Datasource+Delegates>--
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! cmnApplictnLifeinsTVCell
        if((cell.premiumLbl) != nil)
        {
            return apremiumppArray.count
        }
        else{
            if(searchActive){
                return filtered.count
            } else {
                return afrstNameArray.count
            }
//            return afrstNameArray.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! cmnApplictnLifeinsTVCell
        
//        cell.contactNameLbl.text! = afrstNameArray[indexPath.row].uppercased()
        if(searchActive){
            cell.contactNameLbl.text = filtered[indexPath.row].uppercased()
        } else {
            cell.contactNameLbl.text = afrstNameArray[indexPath.row].uppercased()
        }
        cell.dateLbl.text! = aquoteDateArray[indexPath.row]
        cell.termpptLbl.text! = atermpptArray[indexPath.row]
        cell.appNoLbl.text! = aappNoArray[indexPath.row]
        cell.sumLbl.text! = asumArray[indexPath.row]
        cell.premiumLbl.text! = apremiumppArray[indexPath.row]
        cell.statusDateLbl.text! = astatusDateArray[indexPath.row]
        cell.modeLbl.text! = amodeArray[indexPath.row]
        cell.statusLbl.text! = astatusArray[indexPath.row]
        
        //--menuoptions--
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175
    }
    
    func menuBtnTapped(cell: cmnApplictnLifeinsTVCell)
    {
        //Get the indexpath of cell where button was tapped
        let indexPath = self.atableView.indexPath(for: cell)
        //here I want to execute the UIActionSheet
        let actionsheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        actionsheet.addAction(UIAlertAction(title: "CALL", style: UIAlertAction.Style.default, handler: { (action) -> Void in
        }))
        actionsheet.addAction(UIAlertAction(title: "SMS", style: UIAlertAction.Style.default, handler: { (action) -> Void in
            print("SMS")
            let myWebsite = NSURL(string:"SMS")
            let shareAll = [myWebsite as Any]
            let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            self.present(activityViewController, animated: true, completion: nil)
        }))
        actionsheet.addAction(UIAlertAction(title: "CANCEL", style: UIAlertAction.Style.cancel, handler: { (action) -> Void in
        }))
        self.present(actionsheet, animated: true, completion: nil)
        
    }
    
    
}
