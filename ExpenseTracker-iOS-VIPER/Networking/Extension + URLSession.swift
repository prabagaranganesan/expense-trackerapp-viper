//
//  Extension + URLSession.swift
//  ExpenseTracker-iOS-VIPER
//
//  Created by Prabagaran, Ganesan (G.) on 06/11/21.
//

import Foundation

public extension URLSession {
    func dataTask(with request: URLRequest,
                  _ onCompletion: @escaping (Result<(response: URLResponse, data: Data), NetworkError>) -> Void) -> URLSessionDataTask {
        let task = dataTask(with: request) { data, response, error in
            guard let response = response, let data = data else {
                onCompletion(.failure(NetworkError.returnedWithError(error ?? NetworkError.genericError)))
                return
            }
            onCompletion(.success((response, data)))
        }
        return task
    }
}

extension URLResponse {
    var status: Int {
        return (self as? HTTPURLResponse)?.statusCode ?? 500
    }
}
