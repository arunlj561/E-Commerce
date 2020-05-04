//
//  CategoryCollectionViewCell.swift
// CoreDataMVC
//
//  Created by Arun Jangid on 30/04/20.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var content: UILabel!
    
    
    func configure(cellWith category:Category){
        name.text = category.name
        content.text = category.content
        if let imageName = category.imageName{            
            imageView.image = UIImage(named: imageName)
        }
        
    }
    
}
