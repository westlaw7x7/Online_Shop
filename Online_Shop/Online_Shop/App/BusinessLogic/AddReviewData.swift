//
//  AddReviewData.swift
//  Online_Shop
//
//  Created by Alexander Grigoryev on 7/24/22.
//

import Foundation
import Alamofire

class AddReviewData: AbstractRequestFactory {
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

extension AddReviewData: AddReviewDataFactory {
    func addReview(
        review: String,
        nameOfReviewer: String,
        id: String,
        completionHandler: @escaping (AFDataResponse<AddReview>)
        -> Void){
        let requestModel = AddReviewNetwork(baseUrl: baseUrl,
                                            review: review,
                                            nameOfReviewer: nameOfReviewer,
                                            id: id)
        self.request(request: requestModel,
                     completionHandler: completionHandler)
    }
    
    func deleteReview(id: String,
                      completionHandler: @escaping (AFDataResponse<AddReview>)
                      -> Void){
        let requestModel = DeleteReviewNetwork(baseUrl: baseUrl,
                                               id: id)
        self.request(request: requestModel,
                     completionHandler: completionHandler)
    }
    
}

extension AddReviewData {
    struct AddReviewNetwork: RequestRouter {
        var baseUrl: URL
        var method: HTTPMethod = .put
        var path: String = "addReview"
        
        let review: String
        let nameOfReviewer: String
        let id: String
        var parameters: Parameters? {
            return [
                "review" : review,
                "nameOfReviewer" : nameOfReviewer,
                "id" : id
            ]
        }
    }
    
    struct DeleteReviewNetwork: RequestRouter {
        var baseUrl: URL
        var method: HTTPMethod = .put
        var path: String = "deleteReview"
        
        let id: String
        var parameters: Parameters? {
            return [
                "id" : id
            ]
        }
    }
}
