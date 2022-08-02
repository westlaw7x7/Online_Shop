//
//  DataRequest.swift
//  Online_Shop
//
//  Created by Alexander Grigoryev on 6/15/22.
//

import Alamofire
import Foundation

class CustomDecodableSerializer<T: Decodable>: DataResponseSerializerProtocol {
    private let errorParser: AbstractErrorParser
    
    init(errorParser: AbstractErrorParser) {
        self.errorParser = errorParser
    }
    
    func serialize(
        request: URLRequest?,
        response: HTTPURLResponse?,
        data: Data?,
        error: Error?) throws -> T {
            if let error = errorParser.parse(response: response, data: data, error: error) {
                throw error
            }
            do {
                let data = try DataResponseSerializer().serialize(
                    request: request,
                    response: response,
                    data: data,
                    error: error)
                let value = try JSONDecoder().decode(T.self, from: data)
                return value
            } catch {
                let customError = errorParser.parse(error)
                throw customError
            }
        }
}

extension DataRequest {
    @discardableResult
    func responseCodable<T: Decodable>(
        errorParser: AbstractErrorParser,
        queue: DispatchQueue = .main,
        completionHandler: @escaping (AFDataResponse<T>) -> Void)
    -> Self {
        let responseSerializer = CustomDecodableSerializer<T>(errorParser: errorParser)
        return response(queue: queue,
                        responseSerializer: responseSerializer,
                        completionHandler: completionHandler)
    }
}
