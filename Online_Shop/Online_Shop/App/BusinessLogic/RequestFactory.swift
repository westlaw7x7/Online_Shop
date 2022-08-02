//
//  RequestFactory.swift
//  Online_Shop
//
//  Created by Alexander Grigoryev on 6/15/22.
//

import Foundation
import Swinject

class RequestFactory {
    
    let container: Container
    
    init(container: Container) {
        self.container = container
    }
    
    func makeAuthRequestFactory() -> AuthRequestFactory {
        return container.resolve(AuthRequestFactory.self)!
    }
    
    func makeRegisterRequestFactory() -> RegistrationRequestFactory {
        return container.resolve(RegistrationRequestFactory.self)!
    }
    
    func makeChangeDataRequestFactory() -> ChangeUserDataFactory {
        return container.resolve(ChangeUserDataFactory.self)!
    }
    
    func makeCatalogDataRequestFactory() -> GetCatalogDataFactory {
        return container.resolve(GetCatalogDataFactory.self)!
    }
    
    func makeSingleProductDataRequestFactory() -> GetSingleProductDataFactory {
        return container.resolve(GetSingleProductDataFactory.self)!
    }
    
    func makeAddReviewDataFactory() -> AddReviewDataFactory {
        return container.resolve(AddReviewDataFactory.self)!
    }
    
    func makePayForProductsDataFactory() -> PayForProductsDataFactory {
        return container.resolve(PayForProductsDataFactory.self)!
    }
}
