//
//  ProductDatasource.swift
//  KartLabs
//
//  Created by Arun Jangid on 01/05/20.
//

import UIKit
import CoreData

class ProductDatasource: NSObject, UICollectionViewDataSource {
    
    var _fetchedResultsController: NSFetchedResultsController<Products>? = nil
    var managedObjectContext :NSManagedObjectContext = DatabaseManager.persistentContainer.viewContext
    
    var categoryId:Int64!
    weak var delegate:AddToCartDelegate?
    
    var fetchedResultsController: NSFetchedResultsController<Products>
    {
        
    
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        guard let categoryId = categoryId else {
            return _fetchedResultsController!
        }
        
        let fetchRequest: NSFetchRequest<Products> = Products.fetchRequest()
                        
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
                
        let predicate = NSPredicate(format: "id != nil && categoryId == \(categoryId)")
        
        
        fetchRequest.predicate = predicate
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
    
}
