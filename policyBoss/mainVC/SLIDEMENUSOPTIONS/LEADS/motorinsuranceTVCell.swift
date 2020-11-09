//
//  motorinsuranceTVCell.swift
//  MagicFinmart
//
//  Created by Admin on 21/05/19.
//  Copyright © 2019 Ashwini. All rights reserved.
//

import UIKit

//1. delegate method
protocol mcellBtnDelegate: AnyObject {
    func dateBtnTapped(cell: motorinsuranceTVCell)
    func generateBtnTapped(cell: motorinsuranceTVCell)
}


class motorinsuranceTVCell: UITableViewCell {
    
    //2.
    weak var delegate: mcellBtnDelegate?

    @IBOutlet var cellView: UIView!
    @IBOutlet var categoryLbl: UILabel!
    @IBOutlet var vehicleregLbl: UILabel!
    @IBOutlet var nameTf: ACFloatingTextfield!
    @IBOutlet var mobNoTf: ACFloatingTextfield!
    @IBOutlet var expdateLblTf: ACFloatingTextfield!
    
    @IBOutlet var expdateBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    
    @IBAction func expDateBtnCliked(_ sender: Any)
    {
        //4. call delegate method
        //check delegate is not nil with `?`
        delegate?.dateBtnTapped(cell: self)
    }
    
    @IBAction func generateBtnCliked(_ sender: Any)
    {
        //4. call delegate method
        //check delegate is not nil with `?`
        delegate?.generateBtnTapped(cell: self)
    }
    
}
