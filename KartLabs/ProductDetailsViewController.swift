//
//  ProductDetailsViewController.swift
//  KartLabs
//
//  Created by Arun Jangid on 30/04/20.
//

import UIKit

class ProductDetailsViewController: UIViewController {

    class func productsDetailViewController(forProduct product:Products) -> ProductDetailsViewController?{
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let productDetailsViewController = storyboard.instantiateViewController(withIdentifier: "ProductDetailsViewController") as? ProductDetailsViewController
        productDetailsViewController?.product = product
        return productDetailsViewController
    }
    
    var product:Products!
    var datasource = ProductDetailDatasource()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datasource.product = product
        tableView.dataSource = datasource

        
    }
    
    @IBAction func addToCart(_ sender: Any) {
        Cart.updateCart(withProduct: self.product)
    }
    
    @IBAction func addToGift(_ sender: Any) {
        self.product.updateGiftRegister()
    }
    

}
