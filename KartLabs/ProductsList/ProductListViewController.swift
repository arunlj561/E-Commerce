//
//  ProductListViewController.swift
//  KartLabs
//
//  Created by Arun Jangid on 30/04/20.
//

import UIKit

class ProductListViewController: UIViewController {
    
    class func productsListViewController(forCategory category:Category) -> ProductListViewController?{
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let productListViewController = storyboard.instantiateViewController(withIdentifier: "ProductListViewController") as? ProductListViewController
        productListViewController?.categoryId = category.id
        productListViewController?.title = category.name
        return productListViewController
    }
    
    
    
    var categoryId: Int64!
    var datasource = ProductDatasource()
    @IBOutlet weak var collectionView:UICollectionView!
    @IBOutlet weak var categoryTitle: UILabel!
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
        self.categoryTitle.text = self.title
        self.datasource.categoryId = categoryId
        self.collectionView.dataSource = datasource
        self.datasource.delegate = self
        self.count = Cart.getAllCartItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.count = Cart.getAllCartItems()
    }
    
    
    @IBAction func openCart(_ sender: Any) {
        self.navigationController?.pushViewController(CartViewController.cartViewController(), animated: true)

    }

}

extension ProductListViewController:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (deviceWidth/2) - 20, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

extension ProductListViewController:AddToCartDelegate{
    
    func addedToCart() {
        self.count = Cart.getAllCartItems()
    }
}
