//
//  Extensions.swift
//  Sigfrid_Technical
//
//  Created by Sigfrid Acabal on 8/15/23.
//

import Foundation
import UIKit

extension UIViewController{
    func hideKeyboard(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc
    func dismissKeyboard(){
        DispatchQueue.main.asyncAfter(deadline: .now() + .microseconds(100)) {
            self.view.endEditing(true)
        }
    }
}
