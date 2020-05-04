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
        /*
        initStubs()
            
        
        
        //Listen to the change in context
        NotificationCenter.default.addObserver(self, selector: #selector(contextSaved(notification:)), name: NSNotification.Name.NSManagedObjectContextDidSave , object: nil)
        */
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
    
    
    
    
    /*
    
    func test_create_todo() {
        
        //Given the name & status
        let name = "Todo1"
        let finished = false
        
        //When add todo
        let todo = sut.insertTodoItem(name: name, finished: finished)
        
        //Assert: return todo item
        XCTAssertNotNil( todo )

    }
    
    func test_fetch_all_todo() {
        
        //Given a storage with two todo
        
        //When fetch
        let results = sut.fetchAll()
        
        //Assert return two todo items
        XCTAssertEqual(results.count, 5)
    }
    
    func test_remove_todo() {
        
        //Given a item in persistent store
        let items = sut.fetchAll()
        let item = items[0]
        
        let numberOfItems = items.count
        
        //When remove a item
        sut.remove(objectID: item.objectID)
        sut.save()
        
        //Assert number of item - 1
        XCTAssertEqual(numberOfItemsInPersistentStore(), numberOfItems-1)
        
    }
    
    func test_save() {
        
        //Give a todo item
        let name = "Todo1"
        let finished = false
        
        _ = expectationForSaveNotification()
        
        _ = sut.insertTodoItem(name: name, finished: finished)
        
        //When save
        
        
        //Assert save is called via notification (wait)
        expectation(forNotification: NSNotification.Name(rawValue: Notification.Name.NSManagedObjectContextDidSave.rawValue), object: nil, handler: nil)
        
        sut.save()
        
        waitForExpectations(timeout: 1.0, handler: nil)
        
        
    }
    

    
    //MARK: mock in-memory persistant store
    lazy var managedObjectModel: NSManagedObjectModel = {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle(for: type(of: self))] )!
        return managedObjectModel
    }()
    
    lazy var mockPersistantContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "PersistentTodoList", managedObjectModel: self.managedObjectModel)
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false // Make it simpler in test env
        
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { (description, error) in
            // Check if the data store is in memory
            precondition( description.type == NSInMemoryStoreType )

            // Check if creating container wrong
            if let error = error {
                fatalError("Create an in-mem coordinator failed \(error)")
            }
        }
        return container
    }()

    //MARK: Convinient function for notification
    var saveNotificationCompleteHandler: ((Notification)->())?
    
    func expectationForSaveNotification() -> XCTestExpectation {
        let expect = expectation(description: "Context Saved")
        waitForSavedNotification { (notification) in
            expect.fulfill()
        }
        return expect
    }
    
    func waitForSavedNotification(completeHandler: @escaping ((Notification)->()) ) {
        saveNotificationCompleteHandler = completeHandler
    }
    
    func contextSaved( notification: Notification ) {
        print("\(notification)")
        saveNotificationCompleteHandler?(notification)
    }


}

//MARK: Creat some fakes
extension CoreDataMVCTests {
    
    func initStubs() {
        
//        func insertCategory( name: String, finished: Bool ) -> Category? {
//
//            let obj = NSEntityDescription.insertNewObject(forEntityName: "Category", into: mockPersistantContainer.viewContext)
//
//            obj.setValue("1", forKey: "name")
//            obj.setValue(false, forKey: "finished")
//
//            return obj as? Category
//        }
//
//        _ = insertCategory(name: "1", finished: false)
//        _ = insertCategory(name: "2", finished: false)
//        _ = insertCategory(name: "3", finished: false)
//        _ = insertCategory(name: "4", finished: false)
//        _ = insertCategory(name: "5", finished: false)
        
        do {
            try mockPersistantContainer.viewContext.save()
        }  catch {
            print("create fakes error \(error)")
        }
        
    }
    
    func flushData() {
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: "ToDoItem")
        let objs = try! mockPersistantContainer.viewContext.fetch(fetchRequest)
        for case let obj as NSManagedObject in objs {
            mockPersistantContainer.viewContext.delete(obj)
        }
        
        try! mockPersistantContainer.viewContext.save()
        
    }
 
    func numberOfItemsInPersistentStore() -> Int {
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "ToDoItem")
        let results = try! mockPersistantContainer.viewContext.fetch(request)
        return results.count
    }
    
}

*/


