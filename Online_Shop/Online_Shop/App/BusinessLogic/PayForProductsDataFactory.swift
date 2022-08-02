//
//  PayForProductsDataFactory.swift
//  Online_Shop
//
//  Created by Alexander Grigoryev on 7/29/22.
//

import Foundation
import Alamofire

protocol PayForProductsDataFactory {
    func pay(totalPrice: Int,
                   completionHandler: @escaping (AFDataResponse<PayBasket>)
                   -> Void)
}
