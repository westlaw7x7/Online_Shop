//
//  AuthRequestFactory.swift
//  Online_Shop
//
//  Created by Alexander Grigoryev on 6/17/22.
//

import Foundation
import Alamofire

protocol AuthRequestFactory {
    func login(userName: String,
               password: String,
               completionHandler:
               @escaping (AFDataResponse<LoginResult>)
               -> Void)
    
    func logout(id: Int,
                completionHandler:
                @escaping (AFDataResponse<LogoutResult>)
                -> Void)
}
