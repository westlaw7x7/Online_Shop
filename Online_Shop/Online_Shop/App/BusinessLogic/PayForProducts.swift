//
//  PayForProducts.swift
//  Online_Shop
//
//  Created by Alexander Grigoryev on 7/29/22.
//

import Foundation
import Alamofire

class PayForProducts: AbstractRequestFactory {
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

extension PayForProducts: PayForProductsDataFactory {
    func pay(totalPrice: Int,
             completionHandler: @escaping (AFDataResponse<PayBasket>)
             -> Void) {
        let requestModel = PayForProductsNetwork(baseUrl: baseUrl,
                                                 totalPrice: totalPrice)
        self.request(request: requestModel,
                     completionHandler: completionHandler)
    }
    
    
}

extension PayForProducts {
    struct PayForProductsNetwork: RequestRouter {
        var baseUrl: URL
        var method: HTTPMethod = .post
        var path: String = "payBasket"
        
        let totalPrice: Int
        
        var parameters: Parameters? {
            return [
                "totalPrice" : totalPrice
            ]
        }
        
        
    }
}
