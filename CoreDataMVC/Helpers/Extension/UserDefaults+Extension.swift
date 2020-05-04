//
//  UserDefaults+Extension.swift
// CoreDataMVC
//
//  Created by Arun Jangid on 01/05/20.
//

import UIKit
extension UserDefaults{
    static let firstLoad = "firstLoad"
    
    func getFirstLoad() -> Bool{
        return UserDefaults.standard.bool(forKey: UserDefaults.firstLoad)
    }
    func setFirsLoad(){
        UserDefaults.standard.set(true, forKey: UserDefaults.firstLoad)
    }
}
