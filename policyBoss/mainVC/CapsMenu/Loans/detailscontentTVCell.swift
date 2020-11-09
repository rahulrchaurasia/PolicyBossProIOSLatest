//
//  detailscontentTVCell.swift
//  MagicFinmart
//
//  Created by iOS Developer on 20/07/19.
//  Copyright © 2019 Ashwini. All rights reserved.
//

import UIKit

//1. delegate method
protocol closeDetailsDelegates: AnyObject {
    func readmoreCloseBtnTapped(cell: detailscontentTVCell)
}

class detailscontentTVCell: UITableViewCell {
    //2.
    weak var londelegate: closeDetailsDelegates?
    
    @IBOutlet weak var hidedetailsView: UIView!
    @IBOutlet weak var ssegmentLbl: UILabel!
    @IBOutlet weak var sproductLbl: UILabel!
    @IBOutlet weak var sproductTypeLbl: UILabel!
    @IBOutlet weak var sbestroiLbl: UILabel!
    @IBOutlet weak var sperlacemiLbl: UILabel!
    @IBOutlet weak var sloanamountLbl: UILabel!
    @IBOutlet weak var stenureLbl: UILabel!
    @IBOutlet weak var sageLbl: UILabel!
    @IBOutlet weak var sminsalaryLbl: UILabel!
    @IBOutlet weak var sminworkexpLbl: UILabel!
    @IBOutlet weak var sprocessingfeeLbl: UILabel!
    @IBOutlet weak var sminicibilLbl: UILabel!
    @IBOutlet weak var sforechargeLbl: UILabel!
    @IBOutlet weak var sprepayLbl: UILabel!
    @IBOutlet weak var closereadmoreBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let borderColr = UIColor.lightGray
        hidedetailsView.layer.cornerRadius=2.0;
        hidedetailsView.layer.borderWidth=1.0;
        hidedetailsView.layer.borderColor=borderColr.cgColor;
    }

    @IBAction func closereadmoreBtnCliked(_ sender: Any)
    {
        //4. call delegate method
        //check delegate is not nil with `?`
        londelegate?.readmoreCloseBtnTapped(cell: self)
    }
    
    
    
}
