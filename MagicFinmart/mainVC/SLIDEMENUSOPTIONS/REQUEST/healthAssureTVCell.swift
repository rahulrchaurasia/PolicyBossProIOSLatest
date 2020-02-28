//
//  healthAssureTVCell.swift
//  MagicFinmart
//
//  Created by Admin on 17/04/19.
//  Copyright © 2019 Ashwini. All rights reserved.
//

import UIKit
//1. delegate method
protocol healthAssurecellDelegates: AnyObject {
    func dwnArrowBtnTapped(cell: healthAssureTVCell)
    func shareBtnTapped(cell: healthAssureTVCell)
}

class healthAssureTVCell: UITableViewCell {

    //2.
    weak var hadelegate: healthAssurecellDelegates?
    
    @IBOutlet var testsView: UIView!
    @IBOutlet var dropdwnView: UIView!
    @IBOutlet var dwnArrowHeaderBtn: UIButton!
    @IBOutlet var clickheaderBtn: UIButton!
    @IBOutlet var pckNameLbl: UILabel!
    @IBOutlet var cntLbl: UILabel!
    @IBOutlet var mrpLbl: UILabel!
    @IBOutlet var offerPriceLbl: UILabel!
    @IBOutlet var shareBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        viewColorGray(view:testsView)
        viewColorGray(view:dropdwnView)
        
    }

    func setExpanded() {
        clickheaderBtn.setImage(#imageLiteral(resourceName: "drop-down-arrow"), for: .normal)
    }
    
    func setCollapsed() {
        clickheaderBtn.setImage(#imageLiteral(resourceName: "drop-down-arrow"), for: .normal)
    }
    
    @IBAction func dwnArrowBtnCliked(_ sender: Any)
    {
        //4. call delegate method
        //check delegate is not nil with `?`
        hadelegate?.dwnArrowBtnTapped(cell: self)
        
    }
    
    @IBAction func shareBtnCliked(_ sender: Any)
    {
        hadelegate?.shareBtnTapped(cell: self)
    }
    
    func viewColorGray(view:UIView)
    {
        let borderColr = UIColor.lightGray
        view.layer.cornerRadius=2.0;
        view.layer.borderWidth=1.0;
        view.layer.borderColor=borderColr.cgColor;
        //        Btn.setTitleColor(UIColor.gray, for: .normal)
    }
    
    
    
}
