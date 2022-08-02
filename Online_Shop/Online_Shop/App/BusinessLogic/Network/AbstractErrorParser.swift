//
//  AbstractErrorParser.swift
//  Online_Shop
//
//  Created by Alexander Grigoryev on 6/15/22.
//

import Foundation

protocol AbstractErrorParser {
    func parse(_ result: Error) -> Error
    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error?
}
