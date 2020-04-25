//
//  imgsalesmaterialVC.swift
//  MagicFinmart
//
//  Created by Admin on 23/01/19.
//  Copyright © 2019 Ashwini. All rights reserved.
//

import UIKit
import SDWebImage
import CustomIOSAlertView


class imgsalesmaterialVC: UIViewController,UIDocumentInteractionControllerDelegate {

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
         // let text = "This is the text...."
        guard let image = NSURL(string:detailImg) else {return }
        
//        guard let image = UIImage(named: "info")else{
//            return
//        }
       
        let shareAll =  [image  ] as [Any]

        let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
        
      //  generateImage(strUrl: detailImg)
        

    
    }
    
    @IBAction func homeBtnCliked(_ sender: Any)
    {
        let KYDrawer : KYDrawerController = self.storyboard?.instantiateViewController(withIdentifier: "stbKYDrawerController") as! KYDrawerController
        self.present(KYDrawer, animated: true, completion: nil)
    }
    
    
    
    //////////////
    
    // MARK: bfbdbdbdbd
    private func generateImage(strUrl : String){
        
        
        let alertView:CustomIOSAlertView = FinmartStyler.getLoadingAlertViewWithMessage("Please Wait...")
        if let parentView = self.navigationController?.view
        {
            alertView.parentView = parentView
        }
        else
        {
            alertView.parentView = self.view
        }
        alertView.show()
        
        var filename = "salesMaterial"
        
        let request = URLRequest(url:  URL(string: strUrl )!)
        let config = URLSessionConfiguration.default
        let session =  URLSession(configuration: config)
        let task = session.dataTask(with: request, completionHandler: {(data, response, error) in
            if error == nil{
                if let pdfData = data {
                    let pathURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("\(filename).jpg")
                    do {
                         alertView.close()
                        print("open \(pathURL.path)")
                        try pdfData.write(to: pathURL, options: .atomic)
                        
                      
                        
                    
                    }catch{
                        print("Error while writting")
                        alertView.close()
                    }
                    
                    DispatchQueue.main.async {
                        
                        self.sharePdf(path: pathURL)
                    }
                    
                    
                }
            }else{
                print(error?.localizedDescription ?? "")
                alertView.close()
            }
        }); task.resume()
    }
    
    
    
    // Share Pdf Using Path
    func sharePdf(path:URL) {
        
       // let text = "This is the text...."

        let shareAll =  [ path ] as [Any]
        
        let fileManager = FileManager.default
        
        if fileManager.fileExists(atPath: path.path) {
            
            // Below is Default Sharing
                        let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
                        activityViewController.popoverPresentationController?.sourceView = self.view
                        self.present(activityViewController, animated: true, completion: nil)
            
            // For Showing Preview
            
//            let controller = UIDocumentInteractionController(url: path)
//            controller.delegate = self
//            controller.presentPreview(animated: true)
            
        }
    }
    
    
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        
        return self
    }
    
}
