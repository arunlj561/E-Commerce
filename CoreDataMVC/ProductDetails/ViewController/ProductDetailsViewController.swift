//
//  ProductDetailsViewController.swift
// CoreDataMVC
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
    @IBOutlet weak var giftRegisterButton: UIButton!
    
    var product:Products!
    var datasource = ProductDetailDatasource()
    
    @IBOutlet weak var navTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
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
        datasource.product = product
        tableView.dataSource = datasource
        self.navTitle.text = product.name
        self.updateGiftButton()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.count = Cart.getAllCartItems()
    }
    
    
    
    @IBAction func addToCart(_ sender: Any) {
        Cart.updateCart(withProduct: self.product)
        self.count = Cart.getAllCartItems()
    }
    
    @IBAction func addToGift(_ sender: Any) {
        self.product.updateGiftRegister()
        self.updateGiftButton()
    }
    
    func updateGiftButton(){
        if self.product.giftRegister == true{
            self.giftRegisterButton.backgroundColor = UIColor.systemTeal
            self.giftRegisterButton.setTitleColor(.white, for: .normal)
        }else{
            self.giftRegisterButton.backgroundColor = UIColor.white
            self.giftRegisterButton.setTitleColor(.systemTeal, for: .normal)
        }
        
    }
    

}
