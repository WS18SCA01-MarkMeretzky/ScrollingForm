//
//  ViewController.swift
//  ScrollingForm
//
//  Created by Mark Meretzky on 2/1/19.
//  Copyright © 2019 New York University School of Professional Studies. All rights reserved.
//

import UIKit;

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!;   //contains 8 UIView's

    override func viewDidLoad() {
        super.viewDidLoad();
        // Do any additional setup after loading the view, typically from a nib.
        registerForKeyboardNotifications();
    }
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWasShown(_:)),
            name: UIResponder.keyboardDidShowNotification,
            object: nil);
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillBeHidden(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil);
    }
    
    @objc func keyboardWasShown(_ notification: NSNotification) {
        guard let info: [AnyHashable: Any] = notification.userInfo,
            let keyboardFrameValue: NSValue = info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue else {
            return;
        }
        
        let height: CGFloat = keyboardFrameValue.cgRectValue.size.height;
        let contentInsets: UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: height, right: 0.0);
        scrollView.contentInset = contentInsets;
        scrollView.scrollIndicatorInsets = contentInsets;
    }
    
    @objc func keyboardWillBeHidden(_ notification: NSNotification) {
        scrollView.contentInset = .zero;
        scrollView.scrollIndicatorInsets = .zero;
    }

    //Called when the return key of any UITextField is tapped.

    @IBAction func returnKeyTapped(_ sender: UITextField) {
        sender.resignFirstResponder();
    }
}
