//
//  ContainerBuilder.swift
//  Online_Shop
//
//  Created by Alexander Grigoryev on 6/29/22.
//

import Foundation
import Swinject
import Alamofire

class ContainerBuilder: AbstractRequestFactory {
    
    var sessionManager = Session()
    let errorParser: AbstractErrorParser = ErrorParser()
    let queue = DispatchQueue.global(qos: .utility)
    
    func makeContainer() -> Container {
        let container = Container()
        container.register(AbstractErrorParser.self) { _ in ErrorParser()}
        container.register(Session.self) { _ in
            self.sessionManager
        }
        container.register(RegistrationRequestFactory.self) { resolver in
            return Registration(errorParser: resolver.resolve(AbstractErrorParser.self)!,
                                sessionManager: resolver.resolve(Session.self)!,
                                queue: self.queue)
        }
        
        container.register(AuthRequestFactory.self) { resolver in
            return Auth(errorParser: resolver.resolve(AbstractErrorParser.self)!,
                        sessionManager: resolver.resolve(Session.self)!,
                        queue: self.queue)
        }
        
        container.register(ChangeUserDataFactory.self) { resolver in
            return ChangeUserData(errorParser: resolver.resolve(AbstractErrorParser.self)!,
                                  sessionManager: resolver.resolve(Session.self)!,
                                  queue: self.queue)
        }
        
        container.register(GetCatalogDataFactory.self) { resolver in
            return GetCatalogData(errorParser: resolver.resolve(AbstractErrorParser.self)!,
                                  sessionManager: resolver.resolve(Session.self)!,
                                  queue: self.queue)
        }
        
        container.register(GetSingleProductDataFactory.self) { resolver in
            return GetSingleProductData(errorParser: resolver.resolve(AbstractErrorParser.self)!,
                                        sessionManager: resolver.resolve(Session.self)!,
                                        queue: self.queue)
        }
        
        container.register(AddReviewDataFactory.self) { resolver in
            return AddReviewData(errorParser: resolver.resolve(AbstractErrorParser.self)!,
                                 sessionManager: resolver.resolve(Session.self)!,
                                 queue: self.queue)
        }
    
        container.register(PayForProductsDataFactory.self) { resolver in
            return PayForProducts(errorParser: resolver.resolve(AbstractErrorParser.self)!,
                                  sessionManager: resolver.resolve(Session.self)!,
                                  queue: self.queue)
        }
        
        return container
    }
}
