//
//  Extensions.swift
//  Expresso
//
//  Created by Viraj Shah on 10/22/16.
//  Copyright © 2016 Expresso. All rights reserved.
//

import UIKit

extension UIColor {
    
    static func systemColor(_ color: String) -> UIColor{
        
        switch (color){
        case "red":
            return UIColor(red:0.83, green:0.18, blue:0.18, alpha:1.00)
        case "darkRed":
            return UIColor(red:0.57, green:0.07, blue:0.04, alpha:1.00)
        case "blue":
            return UIColor(red:0.16, green:0.47, blue:1.00, alpha:1.00)
        case "orange":
            return UIColor(red:0.96, green:0.32, blue:0.12, alpha:1.00)
        case "darkOrange":
            return UIColor(red:0.75, green:0.21, blue:0.05, alpha:1.00)
        case "green":
            return UIColor(red:0.00, green:0.59, blue:0.53, alpha:1.00)
        case "darkGreen":
            return UIColor(red:0.00, green:0.30, blue:0.25, alpha:1.00)
        default:
            return .white
        }
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
