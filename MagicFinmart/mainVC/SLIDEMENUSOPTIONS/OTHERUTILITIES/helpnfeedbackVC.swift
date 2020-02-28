//
//  helpnfeedbackVC.swift
//  MagicFinmart
//
//  Created by Ashwini on 27/12/18.
//  Copyright © 2018 Ashwini. All rights reserved.
//

import UIKit

class helpnfeedbackVC: UIViewController,UITableViewDataSource,UITableViewDelegate {

    var tableArr = ["CONTACT US","RAISE A TICKET","DISCLOSURE","FINMART WHATSAPP CHAT"]

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func backBtnCliked(_ sender: Any)
    {
        let KYDrawer : KYDrawerController = self.storyboard?.instantiateViewController(withIdentifier: "stbKYDrawerController") as! KYDrawerController
        present(KYDrawer, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! helpnfeedbckTVCell
        
        cell.cellLbel.text = tableArr[indexPath.row]
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.row == 0)
        {
            let hnfcontactUs : hnfcontactUsVC = self.storyboard?.instantiateViewController(withIdentifier: "stbhnfcontactUsVC") as! hnfcontactUsVC
            present(hnfcontactUs, animated: true, completion: nil)
        }
        else if(indexPath.row == 1)
        {
            let hnfraiseTickt : hnfraiseTicktVC = self.storyboard?.instantiateViewController(withIdentifier: "stbhnfraiseTicktVC") as! hnfraiseTicktVC
            present(hnfraiseTickt, animated: true, completion: nil)
        }
        else if(indexPath.row == 2)
        {
            let hnfdisclosure : hnfdisclosureVC = self.storyboard?.instantiateViewController(withIdentifier: "stbhnfdisclosureVC") as! hnfdisclosureVC
            present(hnfdisclosure, animated: true, completion: nil)
        }
        
    }
    
}
