//
//  Cart+Extension.swift
// CoreDataMVC
//
//  Created by Arun Jangid on 01/05/20.
//

import UIKit
import CoreData


extension Cart{
    
    class func updateCart(withProduct product:Products){
        let context = DatabaseManager.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Cart> = Cart.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "productId == \(product.id)")
        do {
            let result = try context.fetch(fetchRequest)
            if let cart = result.first{
                cart.quantity += 1
                cart.subTotal = (product.price * cart.quantity)
            }else{
                let cart = Cart.init(context: context)
                cart.quantity = 1
                cart.productId = product.id
                cart.products = product
                cart.subTotal = product.price
            }
            DatabaseManager.saveContext()
        } catch {
            print("Could not fetch cart")
        }
    }
    
    class func updateCart(withProduct product:Products, forQuantity quantity:Int){
        let context = DatabaseManager.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Cart> = Cart.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "productId == \(product.id)")
        do {
            let result = try context.fetch(fetchRequest)
            if let cart = result.first{
                if quantity == 0 {
                    context.delete(cart)
                }else{
                    cart.quantity = Int64(quantity)
                    cart.subTotal = (product.price * cart.quantity)
                }
            }
            DatabaseManager.saveContext()
        } catch {
            print("Could not fetch cart")
        }
    }
    
    class func getAllCartItems() -> Int {
        let context = DatabaseManager.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Cart> = Cart.fetchRequest()
        do {
            let result = try context.fetch(fetchRequest)
            let count = result.reduce(0) { (value, item)  in
                value + item.quantity
            }
            return Int(count)
        } catch {
            print("Could not fetch all cart items")
        }
        return 0
    }
    
    class func cartItemsTotal() -> Int{
        let context = DatabaseManager.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Cart> = Cart.fetchRequest()
        do {
            let result = try context.fetch(fetchRequest)
            let count = result.reduce(0) { (value, item)  in
                value + item.subTotal
            }
            return Int(count)
        } catch {
            print("Could not fetch all cart items")
        }
        return 0
    }
    
    
}
