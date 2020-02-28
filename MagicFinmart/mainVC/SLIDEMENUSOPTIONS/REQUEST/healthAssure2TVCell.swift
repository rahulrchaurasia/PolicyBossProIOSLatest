//
//  healthAssure2TVCell.swift
//  MagicFinmart
//
//  Created by Admin on 20/04/19.
//  Copyright © 2019 Ashwini. All rights reserved.
//

import UIKit

class healthAssure2TVCell: UITableViewCell {

    @IBOutlet var hidecellLbl: UILabel!
    @IBOutlet var hidecellLbl2: UILabel!
    @IBOutlet var hidecellBtnLbl1: UILabel!
    @IBOutlet var hidecellBtnLbl2: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        hidecellLbl.sizeToFit()
        hidecellLbl2.sizeToFit()
    }

    
    
    
}
