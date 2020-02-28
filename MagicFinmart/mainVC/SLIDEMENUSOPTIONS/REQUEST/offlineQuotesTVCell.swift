//
//  offlineQuotesTVCell.swift
//  MagicFinmart
//
//  Created by Admin on 17/04/19.
//  Copyright © 2019 Ashwini. All rights reserved.
//

import UIKit

class offlineQuotesTVCell: UITableViewCell {

    @IBOutlet var hcellimgView: UIView!
    @IBOutlet var hcellconfirmedView: UIView!
    @IBOutlet var hcellmiddleView: UIView!
    @IBOutlet var himgView: UIImageView!
    @IBOutlet var firstNameLbl: UILabel!
    @IBOutlet var mobNoLbl: UILabel!
    @IBOutlet var pckNameLbl: UILabel!
    @IBOutlet var mrpLbl: UILabel!
    @IBOutlet var statusLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let borderColor = UIColor.lightGray
        hcellimgView.layer.borderWidth=1.0;
        hcellimgView.layer.borderColor=borderColor.cgColor;
        hcellconfirmedView.layer.borderWidth=1.0;
        hcellconfirmedView.layer.borderColor=borderColor.cgColor;
        hcellmiddleView.layer.borderWidth=1.0;
        hcellmiddleView.layer.borderColor=borderColor.cgColor;

    }
    
    
    

}
