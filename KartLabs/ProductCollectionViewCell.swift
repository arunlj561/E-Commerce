//
//  ProductCollectionViewCell.swift
//  KartLabs
//
//  Created by Arun Jangid on 30/04/20.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var ratinng: UILabel!
    
    @IBAction func addToFavList(_ sender: UIButton) {
    }
    
    @IBAction func addToCart(_ sender: UIButton) {
    }
    
}
