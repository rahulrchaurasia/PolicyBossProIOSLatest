//
//  multiselctionTVC.swift
//  MagicFinmart
//
//  Created by Ashwini on 13/12/18.
//  Copyright © 2018 Ashwini. All rights reserved.
//

import UIKit

protocol selectedDataDelegate
{
    func getselectedData(selectedData : [String], stringId : String)
}

class multiselctionTVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
  
    var delegateData : selectedDataDelegate?
    
    @IBOutlet weak var slectnTV: UITableView!
    
    var fromScreen = ""
    var tableArray = [String]()
    var selectedData = [String]()
    var stringId = ""
    
    var lyfInsArray = ["Aen Life","Aviva","Bajaj","Bharti AXA","Birla","CanaraHSBC","DLF","Edelwiess","ExideLife","Future Ge","HDFC","ICICI","IDBIFedera","IndiaFirst","Kotak Life","LIC","MaxNewyork","MetLife","PostalLife","Reliance","SAHARALife","SBI Life","Shriram","Star Unio","Tata AIG","UTI"]
    var genrlInsArray = ["Agri.Ins","Apollo","Bajaj","Bharti","Chola","Cigna TTK","Exp-Credit","Future Gen","HDFC","ICICI","IFFCO","Kotak","L & T Insurance","Liberty Videocon","Magma","Max Bupa","National","New India","Oriental","Raheja","Reliance","Religare","SBI General","Shriram","Star Health","Sundaram","Tata AIG","Uni.Sompo","United"]
    var healthInsArray = ["Agri.Ins","Apollo","Cigna TTK","Exp-Credit","Future Gen","Max Bupa","Religare","Star Health","Uni.Sompo"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("fromScreen=",fromScreen)

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if(fromScreen == "lifeInsurance")
        {
            return lyfInsArray.count
        }
        else if(fromScreen == "genInsurance")
        {
            return genrlInsArray.count
        }
        else if(fromScreen == "healthInsurance")
        {
            return healthInsArray.count
        }else
        {
            return tableArray.count
        }

    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = slectnTV.dequeueReusableCell(withIdentifier: "cell") as! multiselctionTVCell
        
//        cell.tableLbl.text! = tableArray[indexPath.row]
        if(fromScreen == "lifeInsurance")
        {
            cell.tableLbl.text! = lyfInsArray[indexPath.row]
        }
        else if(fromScreen == "genInsurance")
        {
            cell.tableLbl.text! = genrlInsArray[indexPath.row]
        }
        else if(fromScreen == "healthInsurance")
        {
            cell.tableLbl.text! = healthInsArray[indexPath.row]
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        slectnTV.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
        if(fromScreen == "lifeInsurance")
        {
            selectedData.append(lyfInsArray[indexPath.row])
            print("selectedData=",selectedData)
            stringId = "lyf"
        }
        else if(fromScreen == "genInsurance")
        {
            selectedData.append(genrlInsArray[indexPath.row])
            print("selectedData=",selectedData)
            stringId = "gen"
        }
        else if(fromScreen == "healthInsurance")
        {
            selectedData.append(healthInsArray[indexPath.row])
            print("selectedData=",selectedData)
            stringId = "health"
        }
        
    }
    
    @IBAction func tableCancelBtnCliked(_ sender: Any)
    {
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
    @IBAction func tableOkBtnCliked(_ sender: Any)
    {
        print("selectedData=",selectedData)
        print("stringId=",stringId)
        self.delegateData?.getselectedData(selectedData : selectedData, stringId: stringId)
        
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
        
//        let ViewCont : ViewController! = storyboard?.instantiateViewController(withIdentifier: "stbViewController") as? ViewController
//        ViewCont.fromScreen = "fromMultiple"
//        ViewCont.multipleSelectedData = selectedData
////        self.addChild(ViewCont)
////        self.view.addSubview(ViewCont.view)
//        self.present(ViewCont, animated: true, completion: nil)
        
        
    }
    
    
    
    
}
