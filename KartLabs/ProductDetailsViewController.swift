//
//  ProductDetailsViewController.swift
//  KartLabs
//
//  Created by Arun Jangid on 30/04/20.
//

import UIKit

class ProductDetailsViewController: UIViewController {

    class func productsDetailViewController(forProductId productId:Int64) -> ProductDetailsViewController?{
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let productDetailsViewController = storyboard.instantiateViewController(withIdentifier: "ProductDetailsViewController") as? ProductDetailsViewController
        return productDetailsViewController
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

}
