//
//  GetSingleProductData.swift
//  Online_Shop
//
//  Created by Alexander Grigoryev on 6/30/22.
//

import Foundation
import Alamofire

class GetSingleProductData: AbstractRequestFactory {
    let baseUrl = URL(string: "https://gentle-depths-89634.herokuapp.com/")!
    var errorParser: AbstractErrorParser
    var sessionManager: Session
    var queue: DispatchQueue
    
    init(errorParser: AbstractErrorParser,
         sessionManager: Session,
         queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

extension GetSingleProductData: GetSingleProductDataFactory {
    func getData(id: String,
                 completionHandler:
                 @escaping (AFDataResponse<Product>)
                 -> Void) {
        let requestModel = GetSingleProduct(baseUrl: baseUrl,
                                            id: id)
       
        self.request(request: requestModel, completionHandler:
                        completionHandler)
    }
}

extension GetSingleProductData {
    struct GetSingleProduct: RequestRouter {
        
        var baseUrl: URL
        var method: HTTPMethod = .post
        var path: String = "getSingleProduct"
        
        let id: String
        var parameters: Parameters? {
            return [
                "id_product" : id
            ]
        }
    }
}

