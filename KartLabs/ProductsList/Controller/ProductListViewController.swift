//
//  ProductListViewController.swift
//  KartLabs
//
//  Created by Arun Jangid on 30/04/20.
//

import UIKit

class ProductListViewController: UIViewController, RefreshViews{
    
    class func productsListViewController(forCategory category:Category?, loadList type:ListType) -> ProductListViewController?{
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let productListViewController = storyboard.instantiateViewController(withIdentifier: "ProductListViewController") as? ProductListViewController
        if let category = category{
            productListViewController?.categoryId = category.id
            productListViewController?.title = category.name
        }else{
            productListViewController?.title = type.title
        }
        
        productListViewController?.listType = type
        return productListViewController
    }
    
    var imageDownloaders = Set<ImageDownloader>()
    
    
    var categoryId: Int64!
    var datasource = ProductDatasource()
    @IBOutlet weak var collectionView:UICollectionView!
    @IBOutlet weak var categoryTitle: UILabel!
    @IBOutlet weak var cartCount: UILabel!
    
    var listType:ListType!
    
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
        self.categoryTitle.text = self.title
        self.datasource.categoryId = categoryId
        self.collectionView.dataSource = datasource
        self.datasource.type = self.listType
        self.datasource.delegate = self
        self.datasource.refreshDelegate = self
        self.count = Cart.getAllCartItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.count = Cart.getAllCartItems()
    }
    
    
    
    
    func updateRows(forindexPath indexPath: IndexPath) {
        self.collectionView.reloadItems(at: [indexPath])        
    }
    func deleteRows(forindexPath indexPath: IndexPath) {
        self.collectionView.reloadData()
        
    }
    

}

extension ProductListViewController:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (deviceWidth/2) - 20, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = datasource.fetchedResultsController.object(at: indexPath)
        if let productViewController = ProductDetailsViewController.productsDetailViewController(forProduct: product){
            self.navigationController?.pushViewController(productViewController, animated: true)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? ProductCollectionViewCell else { return }
        cell.image.image = UIImage(named: "placeholder")
        if let url = datasource.fetchedResultsController.object(at: indexPath).imageUrl, let imageURl = URL(string: url){
            if let imageDownloader = imageDownloaders.filter({ $0.imageUrl == imageURl && $0.imageCache != nil}).first{
                OperationQueue.main.addOperation {
                    cell.image.image = imageDownloader.imageCache
                }
            }else{
                let downloader = ImageDownloader.init(imageURl) { (image) in
                    OperationQueue.main.addOperation {
                        cell.image.image = image
                    }
                }
                imageDownloaders.insert(downloader)
            }
        }
        
    }
}

extension ProductListViewController:AddToCartDelegate{
    
    func addedToCart() {
        self.count = Cart.getAllCartItems()
    }
}
