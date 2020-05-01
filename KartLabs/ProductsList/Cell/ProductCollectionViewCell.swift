//
//  ProductCollectionViewCell.swift
//  KartLabs
//
//  Created by Arun Jangid on 30/04/20.
//

import UIKit
protocol AddToCartDelegate:class{
    func addedToCart()
}

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var wishlist: UIButton!
    
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    
    weak var delegate:AddToCartDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        widthConstraint.constant = (deviceWidth/2) - 32
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        wishlist.isSelected = false
        widthConstraint.constant = (deviceWidth/2) - 32
    }
    
    @IBAction func addToCart(_ sender: UIButton) {
        Cart.updateCart(withProduct: self.product)
        delegate?.addedToCart()
    }
    
    var product:Products!
    
    func configure(cellWith product:Products){
        self.product = product
        title.text = product.name
        price.text = "₹ \(product.price)"
        rating.text = "\(product.rating)"        
        wishlist.isSelected = product.isfavourite
    }
    
    @IBAction func addToWishlist(_ sender: UIButton) {
        wishlist.isSelected = !wishlist.isSelected
        self.product.updateWishlist()
    }
}
