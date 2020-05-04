//
// CoreDataMVCTests.swift
// CoreDataMVCTests
//
//  Created by Arun Jangid on 30/04/20.
//

import XCTest
import CoreData
import CoreDataMVC
@testable import CoreDataMVC

class CoreDataMVCTests: XCTestCase {

    
    
    override func setUp() {
        super.setUp()
        
//        initStubs()
            
        
        
        //Listen to the change in context
//        NotificationCenter.default.addObserver(self, selector: #selector(contextSaved(notification:)), name: NSNotification.Name.NSManagedObjectContextDidSave , object: nil)
        
    }
    

    override func tearDown() {
        NotificationCenter.default.removeObserver(self)
        
//        flushData()
        
        super.tearDown()
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testEmptyCart(){
        let carts = Cart.getAllCartItems()
        let cartItemTotal = Cart.cartItemsTotal()
        
        XCTAssert(cartItemTotal == carts, "Cart is Empty")
    }
    
    

    func testPerformanceLoadCategpries() {
        self.measure {
            Category.loadCategories(withContainer: DatabaseManager.persistentContainer)
        }
    }
    
    func testPerformanceLoadProducts() {
        self.measure {
            Products.loadProducts(withContainer: DatabaseManager.persistentContainer)
        }
    }
    
}
