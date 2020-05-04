//
//  Products+Extension.swift
// CoreDataMVC
//
//  Created by Arun Jangid on 30/04/20.
//

import UIKit
import CoreData

extension Products{
    class func loadProducts(withContainer container:NSPersistentContainer){
        if let path = Bundle.main.path(forResource: "Products", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonObj = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                if let catArr = jsonObj as? [Any]{
                    for i in catArr{
                        let product = Products(context: container.viewContext)
                        self.configure(productsWith: product, usingJSON: i)
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
    
    class func configure(productsWith product: Products, usingJSON json:Any) {
        if let dict = json as? [String:Any]{
            product.name = dict["name"] as? String
            product.content = dict["content"] as? String
            product.imageUrl = dict["imageUrl"] as? String                        
            if let id = dict["id"] as? Int64{
                product.id = id
            }
            if let price = dict["price"] as? Int64{
                product.price = price
            }
            if let categoryId = dict["categoryId"] as? Int64{
                product.categoryId = categoryId
            }
            if let rating = dict["rate"] as? Double{
                product.rating = rating
            }
            if let review = dict["review"] as? Int64{
                product.review = review
            }
            if let colorVariant = dict["colorVariant"] as? String{
                product.colorVarient = colorVariant
            }
            product.isfavourite = false
            product.giftRegister = false
        }
    }
    
    class func getAllWishListItems() -> Int {
        let context = DatabaseManager.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Products> = Products.fetchRequest()
        do {
            let result = try context.fetch(fetchRequest)
            fetchRequest.predicate = NSPredicate(format: "isfavourite == 1")
            return result.count
        } catch {
            print("Could not fetch wishlist")
        }
        return 0
    }
    
    func updateWishlist(){
        let context = DatabaseManager.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Products> = Products.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == \(self.id)")
        do {
            let result = try context.fetch(fetchRequest)
            if let product = result.first{
                product.isfavourite = !product.isfavourite
            }
            DatabaseManager.saveContext()
        } catch {
            print("Could not fetch product")
        }
    }
    
    func updateGiftRegister(){
        let context = DatabaseManager.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Products> = Products.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == \(self.id)")
        do {
            let result = try context.fetch(fetchRequest)
            if let product = result.first{
                product.giftRegister = !product.giftRegister
            }
            DatabaseManager.saveContext()
        } catch {
            print("Could not fetch product")
        }
    }

}
