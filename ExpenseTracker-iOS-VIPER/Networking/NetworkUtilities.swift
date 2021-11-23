//
//  NetworkUtilities.swift
//  ExpenseTracker-iOS-VIPER
//
//  Created by Prabagaran, Ganesan (G.) on 06/11/21.
//

import Foundation

struct HttpRequest {
    var baseURL: String
    var path: String
    var body: [String: String]?
    var type: RequestType
    var headers: [String: String]
}

enum RequestType: String {
    case get, post, put, delete
}

public enum NetworkError: Error {
    case invalidURL
    case invalidToken
    case genericError
    case noInternet
    case returnedWithError(Error)
}
