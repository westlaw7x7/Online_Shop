//
//  AddReviewDataFactory.swift
//  Online_Shop
//
//  Created by Alexander Grigoryev on 7/24/22.
//

import Foundation
import Alamofire

protocol AddReviewDataFactory {
    func addReview(review: String,
                   nameOfReviewer: String,
                   id: String,
                   completionHandler: @escaping (AFDataResponse<AddReview>)
                   -> Void)
    
    func deleteReview(id: String,
                      completionHandler: @escaping (AFDataResponse<AddReview>)
                      -> Void)
}
