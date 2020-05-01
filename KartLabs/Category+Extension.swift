//
//  Category+Extension.swift
//  KartLabs
//
//  Created by Arun Jangid on 30/04/20.
//

import UIKit
import CoreData

extension Category{
    
    class func loadCategories(withContainer container:NSPersistentContainer){
        if let path = Bundle.main.path(forResource: "Category", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonObj = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                if let catArr = jsonObj as? [Any]{
                    for i in catArr{
                        let category = Category(context: container.viewContext)
                        self.configure(categoryWith: category, usingJSON: i)
                    }
                }
                if container.viewContext.hasChanges {
                    do {
                        try container.viewContext.save()
                    } catch {
                        print("An error occurred while saving: \(error)")
                    }
                }
            } catch let error {
                print("parse error: \(error.localizedDescription)")
            }
        } else {
            print("Invalid filename/path.")
        }
    }
    
    class func configure(categoryWith category: Category, usingJSON json:Any) {
        if let dict = json as? [String:Any]{
            category.name = dict["name"] as? String
            category.content = dict["content"] as? String
            category.imageName = dict["imageName"] as? String
            if let id = dict["id"] as? Int64{
                category.id = id
            }
        }
    }
}
