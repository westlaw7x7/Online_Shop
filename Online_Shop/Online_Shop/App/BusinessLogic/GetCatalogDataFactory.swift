//
//  GetCatalogDataFactory.swift
//  Online_Shop
//
//  Created by Alexander Grigoryev on 6/30/22.
//

import Foundation
import Alamofire

protocol GetCatalogDataFactory {
    func getData(categoryID: String,
                 completionHandler:
                 @escaping (AFDataResponse<CatalogData>) -> Void)
}
