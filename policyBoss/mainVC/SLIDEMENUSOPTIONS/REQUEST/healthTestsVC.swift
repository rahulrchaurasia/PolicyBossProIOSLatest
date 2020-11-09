//
//  healthTestsVC.swift
//  MagicFinmart
//
//  Created by Admin on 07/05/19.
//  Copyright © 2019 Ashwini. All rights reserved.
//

import UIKit

class healthTestsVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    var testArray = Array<Any>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("testArray=",testArray)

    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! healthTestTVCell
        

    //        cell.testsLbl.text! = testArray[indexPath.row] as! String
        
        return cell
        
    }


    @IBAction func okBtnCliked(_ sender: Any)
    {
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }

    
    
}
