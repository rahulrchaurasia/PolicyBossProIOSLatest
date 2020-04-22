//
//  imgsalesmaterialVC.swift
//  MagicFinmart
//
//  Created by Admin on 23/01/19.
//  Copyright © 2019 Ashwini. All rights reserved.
//

import UIKit
import SDWebImage

class imgsalesmaterialVC: UIViewController {

    @IBOutlet weak var detailImgView: UIImageView!
    
    var detailImg = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("detailImg=",detailImg)
        let url = URL(string: detailImg)
        
//        let data = try? Data(contentsOf: url!)
//        detailImgView.image = UIImage(data: data!)
        
         detailImgView.sd_setImage(with: url)
        
    }
    
    @IBAction func backBtnCliked(_ sender: Any)
    {
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
    
    @IBAction func shareBtnCliked(_ sender: Any)
    {
//        let text = "This is the text...."
//        let image = UIImage(named: "Product")
        let myWebsite = NSURL(string:detailImg)
        let shareAll = [myWebsite as Any]
        let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    
    }
    
    @IBAction func homeBtnCliked(_ sender: Any)
    {
        let KYDrawer : KYDrawerController = self.storyboard?.instantiateViewController(withIdentifier: "stbKYDrawerController") as! KYDrawerController
        self.present(KYDrawer, animated: true, completion: nil)
    }
    
    
}
