//
//  lifeInsuranceTVCell.swift
//  MagicFinmart
//
//  Created by Admin on 04/03/19.
//  Copyright © 2019 Ashwini. All rights reserved.
//

import UIKit

class lifeInsuranceTVCell: UITableViewCell {

    @IBOutlet weak var lifeIncellView: UIView!
    @IBOutlet weak var lifeIncellLbl: UILabel!
    @IBOutlet weak var lifeInImgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lifeIncellView.layer.cornerRadius = 2.0
        lifeIncellView.layer.shadowColor = UIColor.lightGray.cgColor
        lifeIncellView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        lifeIncellView.layer.shadowRadius = 10.0
        lifeIncellView.layer.shadowOpacity = 0.8
        
    }

  

}
