//
//  ErrorParser.swift
//  Online_Shop
//
//  Created by Alexander Grigoryev on 6/15/22.
//

import Foundation

class ErrorParser: AbstractErrorParser {
    func parse(_ result: Error) -> Error {
        return result
    }
    
    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error? {
        return error
    }
}
