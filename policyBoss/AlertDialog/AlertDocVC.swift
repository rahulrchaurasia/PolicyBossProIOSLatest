//
//  AlertDocVC.swift
//  policyBoss
//
//  Created by Daniyal Shaikh on 22/09/21.
//  Copyright © 2021 policyBoss. All rights reserved.
//

import UIKit

class AlertDocVC: UIViewController {

   
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var imgDoc: UIImageView!
    
    var alertTitle = String()
    var strURL = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lblTitle.text = alertTitle
        let url = URL(string: strURL)
       // imgDoc.sd_setImage(with: url)
        imgDoc.sd_setImage(with: url, placeholderImage: UIImage(named: "policyboss_placeholder"), options: .continueInBackground , completed: nil)
    }
    
    
    @IBAction func btnCloseClick(_ sender: Any) {
        
        dismiss(animated: true)
    }
    
    

   

}
