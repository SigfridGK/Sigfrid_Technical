//
//  Main_Delegate.swift
//  Sigfrid_Technical
//
//  Created by Sigfrid Acabal on 8/15/23.
//

import Foundation
import UIKit

extension MainViewController {
    @objc
    func keyboardWillShow(notification: NSNotification) {
        //Need to calculate keyboard exact size due to Apple suggestions
        let info : NSDictionary = notification.userInfo! as NSDictionary
        let keyboardSize = (info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        let contentInsets : UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize!.height, right: 0.0)

        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets

        var aRect : CGRect = self.view.frame
        aRect.size.height -= keyboardSize!.height
    }

    @objc
    func keyboardWillHide(notification: NSNotification) {
        //Once keyboard disappears, restore original positions
        let _ : NSDictionary = notification.userInfo! as NSDictionary
        let contentInsets : UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        self.view.endEditing(true)
        self.scrollView.isScrollEnabled = true
    }
}
