//
//  KnowlgeGuruVC.swift
//  MagicFinmart
//
//  Created by Ashwini on 14/12/18.
//  Copyright © 2018 Ashwini. All rights reserved.
//

import UIKit

class KnowlgeGuruVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var knowtableArray1 = ["LOANS","INSURANCE","OTHER PRODUCTS"]
    var knowImgArray1 = ["knowledge_loan_icon.png","knowledge_insurace_icon.png","knowledge_guru_other_product.png"]
    
    
    var knowtableArray = ["INSURANCE","OTHER PRODUCTS"]
    var knowImgArray = ["knowledge_insurace_icon.png","knowledge_guru_other_product.png"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func knowguruBackBtn(_ sender: Any)
    {
        let KYDrawer : KYDrawerController = self.storyboard?.instantiateViewController(withIdentifier: "stbKYDrawerController") as! KYDrawerController
        KYDrawer.modalPresentationStyle = .fullScreen
        present(KYDrawer, animated: true, completion: nil)
        
           // self.dismiss(animated: true)
    }
    
    @IBAction func homeBtnCliked(_ sender: Any)
    {
                let KYDrawer : KYDrawerController = self.storyboard?.instantiateViewController(withIdentifier: "stbKYDrawerController") as! KYDrawerController
               KYDrawer.modalPresentationStyle = .fullScreen
                present(KYDrawer, animated: true, completion: nil)
         // self.dismiss(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return knowtableArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! knowGuruTVCell
        
//        let borderColor = UIColor.lightGray
//        cell.knowguruTView.layer.cornerRadius=2;
//        cell.knowguruTView.layer.borderWidth=1.0;
//        cell.knowguruTView.layer.shadowColor=borderColor.cgColor;
//        cell.knowguruTView.layer.borderColor=borderColor.cgColor;
 
        // The subview inside the collection view cell
        cell.knowguruTView.layer.cornerRadius = 5.0
        cell.knowguruTView.layer.shadowColor = UIColor.lightGray.cgColor
        cell.knowguruTView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        cell.knowguruTView.layer.shadowRadius = 8.0
        cell.knowguruTView.layer.shadowOpacity = 0.7
        
        cell.knowguruCellLbl.text = knowtableArray[indexPath.row]
        cell.cellImgView.image = UIImage(named: knowImgArray[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if(indexPath.row == 0)
//        {
//            let Loans : LoansVC = self.storyboard?.instantiateViewController(withIdentifier: "stbLoansVC") as! LoansVC
//            Loans.wfromScreen = "Loans"
//            Loans.modalPresentationStyle = .fullScreen
//            present(Loans, animated: true, completion: nil)
//        }
         if(indexPath.row == 0)
        {
            let Loans : LoansVC = self.storyboard?.instantiateViewController(withIdentifier: "stbLoansVC") as! LoansVC
            Loans.wfromScreen = "Insurance"
            Loans.modalPresentationStyle = .fullScreen
            present(Loans, animated: true, completion: nil)
        }
        else if(indexPath.row == 1)
        {
            let Loans : LoansVC = self.storyboard?.instantiateViewController(withIdentifier: "stbLoansVC") as! LoansVC
            Loans.wfromScreen = "otherProduct"
            Loans.modalPresentationStyle = .fullScreen
            present(Loans, animated: true, completion: nil)
        }
    }
    

}
