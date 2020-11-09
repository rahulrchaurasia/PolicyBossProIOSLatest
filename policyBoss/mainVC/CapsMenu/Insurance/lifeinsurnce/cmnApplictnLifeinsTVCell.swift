//
//  cmnApplictnLifeinsTVCell.swift
//  MagicFinmart
//
//  Created by Admin on 04/03/19.
//  Copyright © 2019 Ashwini. All rights reserved.
//

import UIKit

//1. delegate method
protocol lyfInscellbtnDelegate: AnyObject {
    func menuBtnTapped(cell: cmnApplictnLifeinsTVCell)
}

class cmnApplictnLifeinsTVCell: UITableViewCell {

    //2.
    weak var delegate: lyfInscellbtnDelegate?
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var termpptView: UIView!
    @IBOutlet weak var appNoView: UIView!
    @IBOutlet weak var contactNameLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var termpptLbl: UILabel!
    @IBOutlet weak var sumLbl: UILabel!
    @IBOutlet weak var modeLbl: UILabel!
    @IBOutlet weak var premiumLbl: UILabel!
    @IBOutlet weak var appNoLbl: UILabel!
    @IBOutlet weak var statusDateLbl: UILabel!
    
    @IBOutlet weak var statusLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let borderColrr = UIColor.init(red: 1/225.0, green: 25/225.0, blue: 146/225.0, alpha: 1)
//        titleView.layer.cornerRadius=2.0;
        titleView.layer.borderWidth=1.0;
        titleView.layer.borderColor=borderColrr.cgColor;
        cellView.layer.cornerRadius=2.0;
        cellView.layer.borderWidth=1.0;
        cellView.layer.borderColor=borderColrr.cgColor;
        
    }

    
    @IBAction func menuBtnCliked(_ sender: Any)
    {
        //4. call delegate method
        //check delegate is not nil with `?`
        delegate?.menuBtnTapped(cell: self)
    }
    
}
