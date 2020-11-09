//
//  creditcardListTVCell.swift
//  MagicFinmart
//
//  Created by iOS Developer on 13/08/19.
//  Copyright © 2019 Ashwini. All rights reserved.
//

import UIKit

//1. delegate method
protocol creditcardBtnsDelegates: AnyObject {
    func infoBtnTapped(cell: creditcardListTVCell)
    func applyBtnTapped(cell: creditcardListTVCell)
}

class creditcardListTVCell: UITableViewCell {

    //2.
    weak var creCrdBtnsDelegates: creditcardBtnsDelegates?
    
    @IBOutlet weak var cardCellView: UIView!
    @IBOutlet weak var creditCardImgView: UIImageView!
    @IBOutlet weak var creditCardNameLbl: UILabel!
    @IBOutlet weak var creditCardTypeLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        cardCellView.layer.cornerRadius = 8.0
        cardCellView.layer.shadowColor = UIColor.lightGray.cgColor
        cardCellView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        cardCellView.layer.shadowRadius = 10.0
        cardCellView.layer.shadowOpacity = 0.8
    }

    @IBAction func cardInfoBtnCliked(_ sender: Any)
    {
        //4. call delegate method
        //check delegate is not nil with `?`
        creCrdBtnsDelegates?.infoBtnTapped(cell: self)
    }
    
    @IBAction func cardApplyBtnCliked(_ sender: Any)
    {
        creCrdBtnsDelegates?.applyBtnTapped(cell: self)
    }
    
    
}
