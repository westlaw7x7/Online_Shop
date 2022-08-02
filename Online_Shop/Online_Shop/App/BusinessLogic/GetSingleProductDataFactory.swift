//
//  GetSingleProductDataFactory.swift
//  Online_Shop
//
//  Created by Alexander Grigoryev on 6/30/22.
//

import Foundation
import Alamofire

protocol GetSingleProductDataFactory {
    func getData(id: String,
                completionHandler:
                @escaping (AFDataResponse<Product>)
                -> Void)
}
