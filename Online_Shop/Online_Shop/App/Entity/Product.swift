//
//  Product.swift
//  Online_Shop
//
//  Created by Alexander Grigoryev on 6/30/22.
//

import Foundation

struct Product: Codable, Identifiable, Equatable, Hashable {
    
    static func == (lhs: Product, rhs: Product) -> Bool {
        lhs.productName == rhs.productName
    }
   
    let result: Int
    let id: String
    let productName: String
    let productPrice: Int
    let categoryID: Int
    let productReviews: [ProductReviews]?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    enum CodingKeys: String, CodingKey {
        case result
        case id = "id_product"
        case productName = "product_name"
        case productPrice = "price"
        case categoryID = "id_category"
        case productReviews
    }
}

struct ProductReviews: Codable, Identifiable, Hashable {
    var id = UUID()
    let review: String
    let nameOfReviewer: String
    
    enum CodingKeys: String, CodingKey {
        case review
        case nameOfReviewer
    }
}

