//
//  loanleadHistoryTVCell.swift
//  MagicFinmart
//
//  Created by iOS Developer on 26/07/19.
//  Copyright © 2019 Ashwini. All rights reserved.
//

import UIKit

class loanleadHistoryTVCell: UITableViewCell {

    @IBOutlet weak var leadDetailsView: UIView!
    @IBOutlet weak var updatedbycellLbl: UILabel!
    @IBOutlet weak var statuscellLbl: UILabel!
    @IBOutlet weak var followupDateLbl: UILabel!
    @IBOutlet weak var updatedcellLbl: UILabel!
    @IBOutlet weak var remarkcellLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let borderColr = UIColor.lightGray
        leadDetailsView.layer.cornerRadius=4.0;
        leadDetailsView.layer.borderWidth=1.0;
        leadDetailsView.layer.borderColor=borderColr.cgColor;
    }

   

}
