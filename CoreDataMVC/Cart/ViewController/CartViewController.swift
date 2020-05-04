//
//  CartViewController.swift
// CoreDataMVC
//
//  Created by Arun Jangid on 01/05/20.
//

import UIKit
import CoreData

class CartViewController: UIViewController, RefreshViews{
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var navTitle: UILabel!
    
    @IBOutlet weak var cartStateLabel: UILabel!
    
    class func cartViewController() -> CartViewController{
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let cartViewController = storyboard.instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
        return cartViewController
    }
    
    
    let datasource = CartDatasource()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navTitle.text = "Cart"
        self.tableView.dataSource = datasource
        self.updateUI()
        datasource.delegate = self
        self.updateUI()
    }

    func updateUI(){
        if let count = datasource.fetchedResultsController.fetchedObjects?.count, count == 0{
            cartStateLabel.isHidden = false
            self.tableView.isHidden = true
            totalLabel.isHidden = true
        }else{
            cartStateLabel.isHidden = true
            self.tableView.isHidden = false
            totalLabel.text = "Your total is: ₹ \(Cart.cartItemsTotal())"
            totalLabel.isHidden = false
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateRows(forindexPath indexPath: IndexPath) {
        self.tableView.reloadRows(at: [indexPath], with: .automatic)
        self.updateUI()
    }
    func deleteRows(forindexPath indexPath: IndexPath) {
        self.tableView.reloadData()
        self.updateUI()
    }
    
}


