//
//  attenReportTVCell.swift
//  MagicFinmart
//
//  Created by Admin on 15/01/19.
//  Copyright © 2019 Ashwini. All rights reserved.
//

import UIKit

class attenReportTVCell: UITableViewCell {

    @IBOutlet weak var reportTCellView: UIView!
    @IBOutlet weak var rdateLbl: UILabel!
    @IBOutlet weak var rtypeLbl: UILabel!
    @IBOutlet weak var rcityLbl: UILabel!
    @IBOutlet weak var rlocationLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let borderColor = UIColor.lightGray
        self.reportTCellView.layer.cornerRadius=4.0;
        self.reportTCellView.layer.borderWidth=2.0;
        self.reportTCellView.layer.borderColor=borderColor.cgColor;
    }

   
}
