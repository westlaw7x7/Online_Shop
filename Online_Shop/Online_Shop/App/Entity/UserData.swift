//
//  UserData.swift
//  Online_Shop
//
//  Created by Alexander Grigoryev on 6/17/22.
//

import Foundation

struct UserData {
    var id: Int
    var username: String
    var password: String
    var email: String
    var gender: Gender
    var creditCard: String
    var bio: String

}

enum Gender: String {
    case male = "m"
    case female = "f"
    case choose = ""
}
