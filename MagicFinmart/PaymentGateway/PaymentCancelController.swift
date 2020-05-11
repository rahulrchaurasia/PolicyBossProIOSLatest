//
//  PaymentCancelController.swift
//  MagicFinmart
//
//  Created by iOS Developer on 10/05/20.
//  Copyright © 2020 Ashwini. All rights reserved.
//

import UIKit

class PaymentCancelController: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    
    
    @IBOutlet weak var cardView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()

        // Do any additional setup after loading the view.
    }
    
    
    func initialize()
    {
        
        
//        mainView.backgroundColor = .white
//
//        mainView.layer.cornerRadius = 10.0
//
//        mainView.layer.shadowColor = UIColor.gray.cgColor
//
//        mainView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
//
//        mainView.layer.shadowRadius = 6.0
//
//        mainView.layer.shadowOpacity = 0.7
        
        
        cardView.backgroundColor = .white

        cardView.layer.cornerRadius = 10.0

        cardView.layer.shadowColor = UIColor.gray.cgColor

        cardView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)

        cardView.layer.shadowRadius = 6.0

        cardView.layer.shadowOpacity = 0.7
//
        
        
    }
    

  
}
