//
//  CatalogData.swift
//  Online_Shop
//
//  Created by Alexander Grigoryev on 6/30/22.
//

import Foundation

struct CatalogData: Codable {
    let products: [Product]

    enum CodingKeys: String, CodingKey {
        case products
    }
}
