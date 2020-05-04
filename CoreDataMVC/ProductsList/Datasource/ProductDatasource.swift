//
//  ProductDatasource.swift
// CoreDataMVC
//
//  Created by Arun Jangid on 01/05/20.
//

import UIKit
import CoreData

enum ListType{
    case normal
    case wishlist
    case gift
    
    var title:String{
        switch self {
        case .normal: return ""
        case .gift: return "Gift"
        case .wishlist: return "WishList"        
        }
    }
    
    var emptyMessage:String{
        switch self {
        case .normal: return ""
        case .gift: return "You have not added any products into gift list. Please add from product details."
        case .wishlist: return "You have not added any products into wishlist. Please add by clicking heart."
        }
    }
}


class ProductDatasource: NSObject, UICollectionViewDataSource {
    
    var _fetchedResultsController: NSFetchedResultsController<Products>? = nil
    var managedObjectContext :NSManagedObjectContext = DatabaseManager.persistentContainer.viewContext
    
    var categoryId:Int64!
    weak var delegate:AddToCartDelegate?
    weak var refreshDelegate:RefreshViews?
    var type = ListType.normal
    
    
    var fetchedResultsController: NSFetchedResultsController<Products>
    {
        
    
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        
        
        let fetchRequest: NSFetchRequest<Products> = Products.fetchRequest()
                        
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        switch type {
        case .normal:
            guard let categoryId = categoryId else {
                return _fetchedResultsController!
            }
            let predicate = NSPredicate(format: "id != nil && categoryId == \(categoryId)")
            fetchRequest.predicate = predicate
        case .wishlist:
            let predicate = NSPredicate(format: "id != nil &&  isfavourite == 1")
            fetchRequest.predicate = predicate
        case .gift:
            let predicate = NSPredicate(format: "id != nil &&  giftRegister ==1")
            fetchRequest.predicate = predicate
        }
        
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
                
        aFetchedResultsController.delegate = self
        _fetchedResultsController = aFetchedResultsController
        
        do {
            try _fetchedResultsController!.performFetch()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        return _fetchedResultsController!
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.reuseIdentifier, for: indexPath) as! ProductCollectionViewCell
        let product = self.fetchedResultsController.object(at: indexPath)
        cell.configure(cellWith: product)
        cell.delegate = self.delegate
        return cell        
    }    
}

extension ProductDatasource:NSFetchedResultsControllerDelegate{
             
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
            case .delete: refreshDelegate?.deleteRows(forindexPath: indexPath!)
            case .update: refreshDelegate?.updateRows(forindexPath: indexPath!)
            default:
                break
        }
    }
    

}
