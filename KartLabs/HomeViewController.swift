//
//  HomeViewController.swift
//  KartLabs
//
//  Created by Arun Jangid on 30/04/20.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {

    var container: NSPersistentContainer!

    @IBOutlet weak var collectionView:UICollectionView!
    var datasource = CategoryDatasource()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        collectionView.dataSource = datasource
        collectionView.delegate = self
    }
                
}

extension HomeViewController:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {        
        return CGSize(width: deviceWidth - 20, height: 200)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
