//
//  DetailTableViewCell.swift
//  KartLabs
//
//  Created by Arun Jangid on 01/05/20.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    @IBOutlet weak var wishList: UIButton!
    @IBOutlet weak var productImage: UIImageView!
    
    
    var product:Products!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func addWishlist(_ sender: UIButton) {
        self.wishList.isSelected = !self.wishList.isSelected
        self.product.updateWishlist()
    }
    
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var reviews: UILabel!
    
    @IBOutlet var colorVariantCollection: [UIButton]!
    
    
    @IBOutlet weak var content: UILabel!
    
    func updateName(){
        self.name.text = product.name
        price.text = "₹ \(product.price)"
        rating.text = "\(product.rating)"
        reviews.text = "\(product.review) Reviews"
    }
    
    
    func updateContent(with detailContent:String) {
        if detailContent.count > 0{
            content.text = detailContent
        }else{
            content.text = "No details for this product"
        }
    }
    func updateImage(){
        if let url = product.imageUrl, let downloadURL = URL(string: url){
            _ = ImageDownloader.init(downloadURL) { (image) in
            OperationQueue.main.addOperation {
                self.productImage.image = image
            }
        }
        }
        wishList.isSelected = product.isfavourite
    }
    func updateColorVariant(color variant:Int){
        for btn in colorVariantCollection{
            btn.isHidden = false
        }
    }
    
}
