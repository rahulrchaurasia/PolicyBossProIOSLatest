//
//  creditCardTVCell.swift
//  MagicFinmart
//
//  Created by iOS Developer on 13/08/19.
//  Copyright © 2019 Ashwini. All rights reserved.
//

import UIKit

class creditCardTVCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var fullNameLbl: UILabel!
    @IBOutlet weak var emailIdLbl: UILabel!
    @IBOutlet weak var mobNoLbl: UILabel!
    @IBOutlet weak var cardTypeLbl: UILabel!
    @IBOutlet weak var creditcardnameLbl: UILabel!
    @IBOutlet weak var appNoLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        let borderColr = UIColor.lightGray
//        cellView.layer.cornerRadius=2.0;
//        cellView.layer.borderWidth=1.0;
//        cellView.layer.borderColor=borderColr.cgColor;
//        cellView.layer.shadowColor=borderColr.cgColor
        //shadowColor for uiview
        cellView.layer.cornerRadius = 8.0
        cellView.layer.shadowColor = UIColor.lightGray.cgColor
        cellView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        cellView.layer.shadowRadius = 10.0
        cellView.layer.shadowOpacity = 0.8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
