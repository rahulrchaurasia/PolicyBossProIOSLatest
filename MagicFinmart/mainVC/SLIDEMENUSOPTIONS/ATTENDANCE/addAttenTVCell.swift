//
//  addAttenTVCell.swift
//  MagicFinmart
//
//  Created by Admin on 14/01/19.
//  Copyright © 2019 Ashwini. All rights reserved.
//

import UIKit

class addAttenTVCell: UITableViewCell {

    @IBOutlet weak var loginhistoryView: UIView!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let borderColor = UIColor.lightGray
        self.loginhistoryView.layer.cornerRadius=4.0;
        self.loginhistoryView.layer.borderWidth=2.0;
        self.loginhistoryView.layer.borderColor=borderColor.cgColor;
    }


}
