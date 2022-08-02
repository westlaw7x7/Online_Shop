//
//  ChangeUserDataFactory.swift
//  Online_Shop
//
//  Created by Alexander Grigoryev on 6/17/22.
//

import Foundation
import Alamofire

protocol ChangeUserDataFactory {
    func change(userData: UserData,
                completionHandler:
                @escaping (AFDataResponse<ChangeUserDataResult>)
                -> Void)
}
