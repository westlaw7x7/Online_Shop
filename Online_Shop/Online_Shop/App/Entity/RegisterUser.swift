//
//  RegisterUser.swift
//  Online_Shop
//
//  Created by Alexander Grigoryev on 6/17/22.
//

import Foundation

struct RegisterUser: Codable {
    let result: Int
    let isRegistered: String
    
    enum CodingKeys: String, CodingKey {
        case result
        case isRegistered = "user_message"
    }
}
