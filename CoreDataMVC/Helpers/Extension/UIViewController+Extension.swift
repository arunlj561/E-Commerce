//
//  UIViewController+Extension.swift
// CoreDataMVC
//
//  Created by Arun Jangid on 01/05/20.
//

import UIKit

extension UIViewController{
    @IBAction func pushBack(_ sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func openCart(_ sender: Any) {
        self.navigationController?.pushViewController(CartViewController.cartViewController(), animated: true)
    }
}
