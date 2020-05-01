//
//  HomeViewController.swift
//  KartLabs
//
//  Created by Arun Jangid on 30/04/20.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {


    @IBOutlet weak var navTitle: UILabel!
    @IBOutlet weak var collectionView:UICollectionView!
    var datasource = CategoryDatasource()    
    @IBOutlet weak var cartCount: UILabel!
    var count :Int!{
        didSet{
            if count > 0 {
                cartCount.isHidden = false
                cartCount.text = "\(count ?? 0)"
            }else{
                cartCount.isHidden = true
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navTitle.text = "Home"
        collectionView.dataSource = datasource
        collectionView.delegate = self
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.count = Cart.getAllCartItems()
    }
    @IBAction func openWishList(_ sender: UIButton) {        
        if let productsListViewController = ProductListViewController.productsListViewController(forCategory: nil, loadList: .wishlist){
            self.navigationController?.pushViewController(productsListViewController, animated: true)
        }
    }
        
    
    @IBAction func openGiftList(_ sender: Any) {
        if let productsListViewController = ProductListViewController.productsListViewController(forCategory: nil, loadList: .gift){
            self.navigationController?.pushViewController(productsListViewController, animated: true)
        }
    }
    
}

extension HomeViewController:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {        
        return CGSize(width: deviceWidth - 20, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = datasource.fetchedResultsController.object(at: indexPath)
        if let productsListViewController = ProductListViewController.productsListViewController(forCategory: category, loadList: .normal){
            self.navigationController?.pushViewController(productsListViewController, animated: true)
        }        
    }
}
