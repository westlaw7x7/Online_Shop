//
//  RegistrationRequestFactory.swift
//  Online_Shop
//
//  Created by Alexander Grigoryev on 6/17/22.
//

import Foundation
import Alamofire

protocol RegistrationRequestFactory {
    func register(userData: UserData,
                  completionHandler:
                  @escaping (AFDataResponse<RegisterUser>)
                  -> Void)
}
