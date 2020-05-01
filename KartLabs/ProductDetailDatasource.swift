//
//  ProductDetailDatasource.swift
//  KartLabs
//
//  Created by Arun Jangid on 01/05/20.
//

import Foundation

import UIKit
import CoreData

enum RowType{
    case image
    case name
    case color
    case detail
    
    var reuseIdentifier:String!{
        switch self {
        case .image: return "image"
        case .name : return "name"
        case .color: return "color"
        case .detail: return "detail"
        }
    }

    static let all:[RowType] = [.image, .name, .color, .detail]
}


class ProductDetailDatasource: NSObject,UITableViewDataSource {
    
    var rowDatasource = RowType.all
    var product:Products!
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return rowDatasource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = rowDatasource[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: type.reuseIdentifier, for: indexPath) as! DetailTableViewCell
        cell.product = self.product
        switch type {
        case .image: cell.updateImage()
        case .detail: cell.updateContent(with: product.content ?? "")
        case .name: cell.updateName()
            break
        case .color:
            if let variant = product.colorVarient, let count = Int(variant){
                cell.updateColorVariant(color: count)
            }
        
        }
    
        return cell
    }

}



