//
//  commonQuotesTVCell.swift
//  MagicFinmart
//
//  Created by Admin on 28/02/19.
//  Copyright © 2019 Ashwini. All rights reserved.
//

import UIKit

//1. delegate method
protocol leadHistoryDelegates: AnyObject {
    func leadHistoryTapped(cell: commonQuotesTVCell)
}

class commonQuotesTVCell: UITableViewCell {

    //2.
    weak var leadHistdelegate: leadHistoryDelegates?
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var cellImgView: UIView!
    @IBOutlet weak var loanamountView: UIView!
    @IBOutlet weak var appnmberView: UIView!
    @IBOutlet weak var haimgView: UIImageView!
    @IBOutlet weak var hNameLbl: UILabel!
    @IBOutlet weak var hloanAmountLbl: UILabel!
    @IBOutlet weak var hprogressView: UIProgressView!
    @IBOutlet weak var hprogressLbl: UILabel!
    @IBOutlet weak var happNumLbl: UILabel!
    @IBOutlet weak var happDateLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewColorGray(view:cellView)
        viewColorGray(view:titleView)
        viewColorGray(view:cellImgView)
        viewColorGray(view:loanamountView)
        viewColorGray(view:appnmberView)
    }
    
    @IBAction func leadHistoryBtnCliked(_ sender: Any)
    {
        //4. call delegate method
        //check delegate is not nil with `?`
        leadHistdelegate?.leadHistoryTapped(cell: self)
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
