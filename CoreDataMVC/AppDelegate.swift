//
//  AppDelegate.swift
// CoreDataMVC
//
//  Created by Arun Jangid on 30/04/20.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        if UserDefaults.standard.getFirstLoad() == false{
            Category.loadCategories(withContainer: DatabaseManager.persistentContainer)
            Products.loadProducts(withContainer: DatabaseManager.persistentContainer)
            UserDefaults.standard.setFirsLoad()
        }
        
        
        
        return true
    }
    

    
}

