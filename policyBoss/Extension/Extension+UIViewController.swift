//
//  Extension+UIViewController.swift
//  policyBoss
//
//  Created by Daniyal Shaikh on 30/03/21.
//  Copyright © 2021 policyBoss. All rights reserved.
//

import Foundation
import UIKit



//////////////////////// Extension For ViewController
extension UIViewController {
    
    
    func showToast(controller: UIViewController,message : String, seconds : Double){
        
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = UIColor.black
        alert.view.alpha = 0.6
        alert.view.layer.cornerRadius = 15
        
        controller.present(alert, animated: true, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds){
            alert.dismiss(animated: true)
        }
    }
    
    
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func remove() {
        // Just to be safe, we check that this view controller
        // is actually added to a parent before removing it.
        guard parent != nil else {
            return
        }
        
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    
    func dismissAll(animated: Bool, completion: (() -> Void)? = nil) {
           if let optionalWindow = UIApplication.shared.delegate?.window, let window = optionalWindow, let rootViewController = window.rootViewController, let presentedViewController = rootViewController.presentedViewController  {
               if let snapshotView = window.snapshotView(afterScreenUpdates: false) {
                   presentedViewController.view.addSubview(snapshotView)
                   presentedViewController.modalTransitionStyle = .coverVertical
               }
               if !isBeingDismissed {
                   rootViewController.dismiss(animated: animated, completion: completion)
               }
           }
       }
    
    
    //-------< For Hide Keyboard >--------
    // Put this piece of code anywhere you like
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


extension UIView
{
    func removeAllSubViews()
    {
       for subView :AnyObject in self.subviews
       {
            subView.removeFromSuperview()
       }
    }

}
