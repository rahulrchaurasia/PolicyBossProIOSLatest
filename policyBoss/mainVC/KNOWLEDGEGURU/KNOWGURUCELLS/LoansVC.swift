//
//  LoansVC.swift
//  MagicFinmart
//
//  Created by Ashwini on 28/12/18.
//  Copyright © 2018 Ashwini. All rights reserved.
//

import UIKit
import WebKit

class LoansVC: UIViewController,WKNavigationDelegate{

    @IBOutlet weak var loanwebView: WKWebView!
    @IBOutlet weak var titleLBL: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var wfromScreen = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add activity
        self.loanwebView.addSubview(self.activityIndicator)
        self.activityIndicator.startAnimating()
        self.loanwebView.navigationDelegate = self
        self.activityIndicator.hidesWhenStopped = true
        
        if(wfromScreen == "Loans")
        {
            titleLBL.text! = "LOAN REPOSITORY"
            loanwebView.load(URLRequest(url: URL(string: "http://erp.rupeeboss.com/loansrepository/Loans-repository.html")!))

        }
        else if(wfromScreen == "Insurance")
        {
           titleLBL.text! = "INSURANCE REPOSITORY"
           loanwebView.load(URLRequest(url: URL(string: "http://bo.magicfinmart.com/insurance_repository/page.html")!))
        }
        else if(wfromScreen == "otherProduct")
        {
            titleLBL.text! = "OTHER PRODUCT"
            loanwebView.load(URLRequest(url: URL(string: "http://www.myfinpeace.com/hostedpages/finmart/KnowledgeGuru.html")!))
        }
        loanwebView.allowsBackForwardNavigationGestures = true
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()
    }
    
    @IBAction func loanBackBtnCliked(_ sender: Any)
    {
        let KnowlgeGuru : KnowlgeGuruVC = self.storyboard?.instantiateViewController(withIdentifier: "stbKnowlgeGuruVC") as! KnowlgeGuruVC
        KnowlgeGuru.modalPresentationStyle = .fullScreen
        present(KnowlgeGuru, animated: true, completion: nil)
    }
    
    @IBAction func homeBtnCliked(_ sender: Any)
    {
        let KYDrawer : KYDrawerController = self.storyboard?.instantiateViewController(withIdentifier: "stbKYDrawerController") as! KYDrawerController
        KYDrawer.modalPresentationStyle = .fullScreen
        present(KYDrawer, animated: true, completion: nil)
    }
    
    @IBAction func backtoMainBtnCliked(_ sender: Any)
    {
        let KnowlgeGuru : KnowlgeGuruVC = self.storyboard?.instantiateViewController(withIdentifier: "stbKnowlgeGuruVC") as! KnowlgeGuruVC
        KnowlgeGuru.modalPresentationStyle = .fullScreen
        present(KnowlgeGuru, animated: true, completion: nil)
    }
    
    
}
