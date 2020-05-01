//
//  View+Extension.swift
//  KartLabs
//
//  Created by Arun Jangid on 01/05/20.
//

import UIKit

extension UIViewController{
    @IBAction func pushBack(_ sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}

extension UIView{
 
@IBInspectable var cornerRadius: CGFloat {
    get {
        return layer.cornerRadius
    }
    set {
         layer.masksToBounds = newValue > 0
         layer.cornerRadius = newValue
    }
}

@IBInspectable var borderWidth: CGFloat {
    get {
        return layer.borderWidth
    }
    set {
        layer.borderWidth = newValue
    }
}

@IBInspectable var borderColor: UIColor? {
    get {
        return UIColor(cgColor: layer.borderColor!)
    }
    set {
            layer.borderColor = newValue?.cgColor
        }
    }
}
