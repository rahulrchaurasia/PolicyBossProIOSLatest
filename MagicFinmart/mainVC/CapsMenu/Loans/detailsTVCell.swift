//
//  detailsTVCell.swift
//  MagicFinmart
//
//  Created by iOS Developer on 20/07/19.
//  Copyright © 2019 Ashwini. All rights reserved.
//

import UIKit

//1. delegate method
protocol loanDetailsDelegates: AnyObject {
    func applyNowBtnTapped(cell: detailsTVCell)
    func readMoreBtnTapped(cell: detailsTVCell)
}

class detailsTVCell: UITableViewCell {
    //2.
    weak var loandelegate: loanDetailsDelegates?
    
    @IBOutlet weak var firstheaderView: UIView!
    @IBOutlet weak var applyNowHeaderBtn: UIButton!
    @IBOutlet weak var readmoreBtn: UIButton!
    @IBOutlet weak var fbestroiLbl: UILabel!
    @IBOutlet weak var femiLbl: UILabel!
    @IBOutlet weak var fprocessingfeeLbl: UILabel!
    @IBOutlet weak var fbankimgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewColorGray(view:firstheaderView)
    }
    
    func setExpanded() {
        readmoreBtn.setImage(#imageLiteral(resourceName: "read_more_btn_up_arrow"), for: .normal)
    }
    func setCollapsed() {
        readmoreBtn.setImage(#imageLiteral(resourceName: "read_more_btn_down_arrow"), for: .normal)
    }
    
    @IBAction func applyNowBtnCliked(_ sender: Any)
    {
        //4. call delegate method
        //check delegate is not nil with `?`
        loandelegate?.applyNowBtnTapped(cell: self)
    }
    @IBAction func readMoreBtnCliked(_ sender: Any)
    {
        //4. call delegate method
        //check delegate is not nil with `?`
        loandelegate?.readMoreBtnTapped(cell: self)
    }
    
    func viewColorGray(view:UIView)
    {
        let borderColr = UIColor.lightGray
        view.layer.cornerRadius=2.0;
        view.layer.borderWidth=1.0;
        view.layer.borderColor=borderColr.cgColor;
        view.layer.shadowColor=borderColr.cgColor
        //        Btn.setTitleColor(UIColor.gray, for: .normal)
    }
    
    
}
