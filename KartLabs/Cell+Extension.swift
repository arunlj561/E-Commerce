//
//  Protocol.swift
//  KartLabs
//
//  Created by Arun Jangid on 30/04/20.
//

import UIKit

extension UITableViewCell{
    class var reuseIdentifier : String {
        return "\(self)"
    }
}

extension UICollectionViewCell{
    class var reuseIdentifier : String {
        return "\(self)"
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

extension UserDefaults{
    static let firstLoad = "firstLoad"
    
    func getFirstLoad() -> Bool{
        return UserDefaults.standard.bool(forKey: UserDefaults.firstLoad)
    }
    func setFirsLoad(){
        UserDefaults.standard.set(true, forKey: UserDefaults.firstLoad)
    }
}
