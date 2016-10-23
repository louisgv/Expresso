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
        case "angry":
            return UIColor(red:0.41, green:0.20, blue:0.16, alpha:1.00)
        case "main":
            return UIColor(red:106/255, green:80/255, blue:238/255, alpha:1.00)
        case "mild":
            return UIColor(red:0.89, green:0.69, blue:0.00, alpha:1.00)
        case "sad":
            return UIColor(red:0.22, green:0.35, blue:0.43, alpha:1.00)
        case "purple":
            return UIColor(red:47/255, green:42/255, blue:69/255, alpha:1.00)
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
