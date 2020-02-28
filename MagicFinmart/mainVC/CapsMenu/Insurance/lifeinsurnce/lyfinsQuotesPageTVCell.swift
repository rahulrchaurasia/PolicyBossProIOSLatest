//
//  lyfinsQuotesPageTVCell.swift
//  MagicFinmart
//
//  Created by Admin on 16/03/19.
//  Copyright © 2019 Ashwini. All rights reserved.
//

import UIKit

//1. delegate method
protocol lyfhdfccellDelegates: AnyObject {
    func netpreBtnTapped(cell: lyfinsQuotesPageTVCell)
    func customiseBtnTapped(cell: lyfinsQuotesPageTVCell)
}


class lyfinsQuotesPageTVCell: UITableViewCell {
    
    //2.
    weak var delegateb: lyfhdfccellDelegates?
    
    //    @IBOutlet var comqquoteplanViewHeight: NSLayoutConstraint!//145
    @IBOutlet var comqbankimageView: UIView!
    @IBOutlet var comqplaneView: UIView!
    @IBOutlet var comqcustomiseView: UIView!
    @IBOutlet var comqcoverView: UIView!
    @IBOutlet var comqpolicyTermView: UIView!
    @IBOutlet var comquptoageView: UIView!
    @IBOutlet var headerBtn: UIButton!
    @IBOutlet var comimgView: UIImageView!
    @IBOutlet var complanLbl: UILabel!
    @IBOutlet var comCoverLbl: UILabel!
    @IBOutlet var comPolicytermLbl: UILabel!
    @IBOutlet var comuptoAgeLbl: UILabel!
    @IBOutlet var comtermreqRsLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewColorGray(view:comqbankimageView)
        viewColorGray(view:comqplaneView)
        viewColorGray(view:comqcustomiseView)
        viewColorGray(view:comqcoverView)
        viewColorGray(view:comqpolicyTermView)
        viewColorGray(view:comquptoageView)
        
    }
    
    func setExpanded() {
        headerBtn.setImage(#imageLiteral(resourceName: "down_arrow_bas_screen"), for: .normal)
    }
    
    func setCollapsed() {
        headerBtn.setImage(#imageLiteral(resourceName: "down_arrow_bas_screen"), for: .normal)
    }
    
    @IBAction func termreqRsBtnCliked(_ sender: Any)
    {
        //4. call delegate method
        //check delegate is not nil with `?`
        delegateb?.netpreBtnTapped(cell: self)
    }
    
    @IBAction func customiseBtnCliked(_ sender: Any)
    {
        //4. call delegate method
        //check delegate is not nil with `?`
        delegateb?.customiseBtnTapped(cell: self)
    }
    
    func viewColorGray(view:UIView)
    {
        let borderColr = UIColor.lightGray
        view.layer.cornerRadius=2.0;
        view.layer.borderWidth=0.5;
        view.layer.borderColor=borderColr.cgColor;
        //        Btn.setTitleColor(UIColor.gray, for: .normal)
    }
    
    
    
}
