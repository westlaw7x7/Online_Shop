//
//  LoginResult.swift
//  Online_Shop
//
//  Created by Alexander Grigoryev on 6/15/22.
//

import Foundation

struct LoginResult: Codable {
    let result: Int
    let user: User
    let userMessage: String

    enum CodingKeys: String, CodingKey {
        case result
        case user
        case userMessage = "user_message"
    }
}

