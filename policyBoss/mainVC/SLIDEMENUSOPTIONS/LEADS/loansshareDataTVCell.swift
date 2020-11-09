//
//  loansshareDataTVCell.swift
//  MagicFinmart
//
//  Created by Admin on 15/04/19.
//  Copyright © 2019 Ashwini. All rights reserved.
//

import UIKit

//1. delegate method
protocol shareBtnDelegate: AnyObject {
    func shareBtnTapped(cell: loansshareDataTVCell)
}

class loansshareDataTVCell: UITableViewCell {

    //2.
    weak var sharedelegate: shareBtnDelegate?
    
    @IBOutlet var loanleadCellView: UIView!
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var msgbodyLbl: UILabel!
    @IBOutlet var linkLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        let borderColr = UIColor.lightGray
//        loanleadCellView.layer.cornerRadius=2.0;
//        loanleadCellView.layer.borderWidth=1;
//        loanleadCellView.layer.borderColor=borderColr.cgColor;
        loanleadCellView.layer.cornerRadius = 4.0
        loanleadCellView.layer.shadowColor = UIColor.gray.cgColor
        loanleadCellView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        loanleadCellView.layer.shadowRadius = 10.0
        loanleadCellView.layer.shadowOpacity = 0.8
    }

    @IBAction func shareBtnCliked(_ sender: Any)
    {
        //4. call delegate method
        //check delegate is not nil with `?`
        sharedelegate?.shareBtnTapped(cell: self)
    }
    
}
