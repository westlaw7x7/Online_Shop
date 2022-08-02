//
//  ChangeUserData.swift
//  Online_Shop
//
//  Created by Alexander Grigoryev on 6/17/22.
//

import Foundation
import Alamofire

class ChangeUserData: AbstractRequestFactory {
    var errorParser: AbstractErrorParser
    var sessionManager: Session
    var queue: DispatchQueue
    let baseUrl = URL(string: "https://gentle-depths-89634.herokuapp.com/")!
    
    init(errorParser: AbstractErrorParser,
         sessionManager: Session,
         queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

extension ChangeUserData: ChangeUserDataFactory {
    func change(userData: UserData,
                completionHandler:
                @escaping (AFDataResponse<ChangeUserDataResult>)
                -> Void) {
        let requestModel = ChangeData(baseUrl: baseUrl, userData: userData)
        self.request(request: requestModel, completionHandler:
                        completionHandler)
    }
}

extension ChangeUserData {
    struct ChangeData: RequestRouter {
        
        var baseUrl: URL
        var method: HTTPMethod = .post
        var path: String = "changeUserData"
        
        let userData: UserData
        var parameters: Parameters? {
            return [
                "id_user" : userData.id,
                "username" : userData.username,
                "password" : userData.password,
                "email": userData.email,
                "gender": userData.gender.rawValue,
                "credit_card": userData.creditCard,
                "bio": userData.bio
            ]
        }
    }
}

