//
//  appliedSuccessfulyVC.swift
//  MagicFinmart
//
//  Created by iOS Developer on 26/08/19.
//  Copyright © 2019 Ashwini. All rights reserved.
//

import UIKit

class appliedSuccessfulyVC: UIViewController {

    @IBOutlet weak var applicatnnoLbl: UILabel!
    @IBOutlet weak var decisionLbl: UILabel!
    @IBOutlet weak var messageLbl: UILabel!
    
    var applictntext = ""
    var decisntext = ""
    var mesgtext = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        applicatnnoLbl.text! = "Application No: "+applictntext
        decisionLbl.text! = "Decision: "+decisntext
        messageLbl.text! = mesgtext
    }
    
    @IBAction func okBtnCliked(_ sender: Any)
    {
        let creditCard : creditCardVC = self.storyboard?.instantiateViewController(withIdentifier: "stbcreditCardVC") as! creditCardVC
        self.addChild(creditCard)
        self.view.addSubview(creditCard.view)
    }
    
   

}
