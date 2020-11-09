//
//  creditcrdpersnlInfoVC.swift
//  MagicFinmart
//
//  Created by iOS Developer on 13/08/19.
//  Copyright © 2019 Ashwini. All rights reserved.
//

import UIKit

class creditcrdpersnlInfoVC: UIViewController {

    @IBOutlet weak var personlinfoCardView: UIView!
    @IBOutlet weak var threeLacBtn: UIButton!
    @IBOutlet weak var fiveLacBtn: UIButton!
    @IBOutlet weak var sixLacBtn: UIButton!
    @IBOutlet weak var tenLacBtn: UIButton!
    @IBOutlet weak var fiftnLacBtn: UIButton!
    @IBOutlet weak var salariedradioBtnImg: UIImageView!
    @IBOutlet weak var selfradioBtnImg: UIImageView!
    var incomeStr = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        personlinfoCardView.layer.cornerRadius=2.0;
        btnColorChangeGray(Btn: threeLacBtn)
        btnColorChangeGray(Btn: fiveLacBtn)
        btnColorChangeGray(Btn: sixLacBtn)
        btnColorChangeGray(Btn: tenLacBtn)
        btnColorChangeGray(Btn: fiftnLacBtn)
        
    }
    
    @IBAction func salariedBtnCliked(_ sender: Any)
    {
        salariedradioBtnImg.image = UIImage(named: "icons8-unchecked-radio-button-24 (1).png")
        selfradioBtnImg.image = UIImage(named: "icons8-round-24.png")
    }
    
    @IBAction func selfBtnCliked(_ sender: Any)
    {
        salariedradioBtnImg.image = UIImage(named: "icons8-round-24.png")
        selfradioBtnImg.image = UIImage(named: "icons8-unchecked-radio-button-24 (1).png")
    }
    
    @IBAction func doneBtnCliked(_ sender: Any)
    {
        let creditCardList : creditCardListVC = self.storyboard?.instantiateViewController(withIdentifier: "stbcreditCardListVC") as! creditCardListVC
        creditCardList.income = incomeStr
        self.addChild(creditCardList)
        self.view.addSubview(creditCardList.view)
    }
    
    @IBAction func threelacBtnCliked(_ sender: Any)
    {
        btnColorChangeBlue(Btn: threeLacBtn)
        btnColorChangeGray(Btn: fiveLacBtn)
        btnColorChangeGray(Btn: sixLacBtn)
        btnColorChangeGray(Btn: tenLacBtn)
        btnColorChangeGray(Btn: fiftnLacBtn)
        incomeStr = 6
    }
    
    @IBAction func fivelacBtnCliked(_ sender: Any)
    {
        btnColorChangeGray(Btn: threeLacBtn)
        btnColorChangeBlue(Btn: fiveLacBtn)
        btnColorChangeGray(Btn: sixLacBtn)
        btnColorChangeGray(Btn: tenLacBtn)
        btnColorChangeGray(Btn: fiftnLacBtn)
        incomeStr = 3
    }
    
    @IBAction func sixelacBtnCliked(_ sender: Any)
    {
        btnColorChangeGray(Btn: threeLacBtn)
        btnColorChangeGray(Btn: fiveLacBtn)
        btnColorChangeBlue(Btn: sixLacBtn)
        btnColorChangeGray(Btn: tenLacBtn)
        btnColorChangeGray(Btn: fiftnLacBtn)
        incomeStr = 7
    }
    
    @IBAction func tenlacBtnCliked(_ sender: Any)
    {
        btnColorChangeGray(Btn: threeLacBtn)
        btnColorChangeGray(Btn: fiveLacBtn)
        btnColorChangeGray(Btn: sixLacBtn)
        btnColorChangeBlue(Btn: tenLacBtn)
        btnColorChangeGray(Btn: fiftnLacBtn)
        incomeStr = 4
    }
    
    @IBAction func fiftnlacBtnCliked(_ sender: Any)
    {
        btnColorChangeGray(Btn: threeLacBtn)
        btnColorChangeGray(Btn: fiveLacBtn)
        btnColorChangeGray(Btn: sixLacBtn)
        btnColorChangeGray(Btn: tenLacBtn)
        btnColorChangeBlue(Btn: fiftnLacBtn)
        incomeStr = 5
    }
    
    
    
    
    
    
    
    
    //----<buttonColor>----
    func btnColorChangeBlue(Btn:UIButton)
    {
        let borderColor = UIColor.gray
        Btn.layer.cornerRadius=2.0;
        Btn.layer.borderWidth=1.0;
        Btn.layer.borderColor=borderColor.cgColor;
        Btn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        Btn.backgroundColor = UIColor.init(red: 0/225.0, green: 125/225.0, blue: 213/225.0, alpha: 1)
    }
    
    func btnColorChangeGray(Btn:UIButton)
    {
        let borderColr = UIColor.gray
        Btn.layer.cornerRadius=2.0;
        Btn.layer.borderWidth=1.0;
        Btn.layer.borderColor=borderColr.cgColor;
        Btn.setTitleColor(UIColor.black, for: .normal)
        Btn.backgroundColor = UIColor.white
    }
    
    
}
