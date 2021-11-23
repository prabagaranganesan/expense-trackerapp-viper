//
//  URLRequestBuilder.swift
//  ExpenseTracker-iOS-VIPER
//
//  Created by Prabagaran, Ganesan (G.) on 06/11/21.
//

import Foundation

protocol RequestBuilding {
    func build(for httpRequest: HttpRequest) throws -> URLRequest
}

struct URLRequestBuilder: RequestBuilding {
    
    func build(for httpRequest: HttpRequest) throws -> URLRequest {
    
        guard let url = URL(string: httpRequest.baseURL + httpRequest.path) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)

        if let body = httpRequest.body {
            request.httpBody = try add(body)
        }
        
        request.httpMethod = httpRequest.type.rawValue
        request.allHTTPHeaderFields = httpRequest.headers
        request.cachePolicy = .reloadIgnoringCacheData
        request.timeoutInterval = 200
       
        return request
    }
    
    func add<T: Encodable>(_ body: T) throws -> Data {
        return try JSONEncoder().encode(body)
    }
}

