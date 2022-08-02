//
//  GetCatalogData.swift
//  Online_Shop
//
//  Created by Alexander Grigoryev on 6/30/22.
//

import Foundation
import Alamofire

class GetCatalogData: AbstractRequestFactory {
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

extension GetCatalogData: GetCatalogDataFactory {
    func getData(categoryID: String,
                 completionHandler:
                 @escaping (AFDataResponse<CatalogData>)
                 -> Void) {
        let requestModel = GetCatalog(baseUrl: baseUrl, categoryID: categoryID)
        self.request(request: requestModel, completionHandler:
                        completionHandler)
    }
}

extension GetCatalogData {
    struct GetCatalog: RequestRouter {
        
        var baseUrl: URL
        var method: HTTPMethod = .post
        var path: String = "getProductList"
        
        let categoryID: String
        var parameters: Parameters? {
            return [
                "id_category": categoryID
            ]
        }
    }
}
