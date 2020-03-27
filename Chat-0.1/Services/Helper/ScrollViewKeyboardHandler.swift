//
//  ScrollViewKeyboardHandler.swift
//  Chat-0.1
//
//  Created by Sunrise on 15.03.2020.
//  Copyright © 2020 Sunrise. All rights reserved.
//

import UIKit

protocol ScrollViewKeyboardHandler: class {
    var scrollView: UIScrollView { get }
    var activeField: UITextField? { get set }
}

extension ScrollViewKeyboardHandler where Self: UIViewController {
    func registerForKeyboardNotifications() {
        //Adding notifies on keyboard appearing
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { notification in
            self.keyboardWillShow(notification: notification)
        }
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { notification in
            self.keyboardWillHide(notification: notification)
        }
        
        self.scrollView.keyboardDismissMode = .onDrag
    }
    
    func deregisterFromKeyboardNotifications() {
        //Removing notifies on keyboard appearing
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(notification: Notification) {
        //Need to calculate keyboard exact size due to Apple suggestions
        self.scrollView.isScrollEnabled = true
        guard let keyboardSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
        
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        
        var aRect = self.navigationController?.view.frame ?? self.view.frame
        aRect.size.height -= keyboardSize.height
        if let activeField = self.activeField {
            self.scrollView.scrollRectToVisible(activeField.frame, animated: true)
        }

    }
    
    func scrollRectToVisible(view: UIView) {
        if let view = scrollView.subviews.first {
            var fieldFrame = view.convert(view.frame, to: scrollView)
            fieldFrame.origin.y = fieldFrame.origin.y
            self.scrollView.scrollRectToVisible(fieldFrame, animated: true)
        }
    }
    
    func keyboardWillHide(notification: Notification) {
        //Once keyboard disappears, restore original positions
        let info = notification.userInfo
        let keyboardSize = (info?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.size
        let contentInsets : UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: -keyboardSize.height, right: 0.0)
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        self.view.endEditing(true)
        self.scrollView.isScrollEnabled = false
    }
}
