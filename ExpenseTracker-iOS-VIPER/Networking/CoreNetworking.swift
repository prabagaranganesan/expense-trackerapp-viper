//
//  CoreNetWorking.swift
//  ExpenseTracker-iOS-VIPER
//
//  Created by Prabagaran, Ganesan (G.) on 06/11/21.
//

import Foundation

typealias ErrorCompletion = (NetworkError) -> ()

protocol CoreNetworkable {
    func fetchData<T: Decodable>(for request: HttpRequest,
                   onSuccess: @escaping (T) -> (),
                   onError: @escaping ErrorCompletion) throws
}

struct CoreNetWorking: CoreNetworkable {
    
    private let urlSession: URLSession
    private let urlRequestBuilder: URLRequestBuilder
    
    init(urlSession: URLSession,
         urlRequestBuilder: URLRequestBuilder) {
        self.urlSession = urlSession
        self.urlRequestBuilder = urlRequestBuilder
    }
    
    func fetchData<T: Decodable>(for request: HttpRequest,
                   onSuccess: @escaping (T) -> (),
                   onError: @escaping (NetworkError) -> ()) throws {
        
        let urlRequest = try urlRequestBuilder.build(for: request)
        
        let task = urlSession.dataTask(with: urlRequest) { result in
            
            switch result {
            case let .success(value):
                let statusCode = value.response.status
                
                switch statusCode {
                case 200...299:
                    do {
                        let decodedData = try JSONDecoder().decode(T.self,
                                                                   from: value.data)
                        onSuccess(decodedData)
                    } catch let error {
                        print(error)
                    }
                default:
                    onError(NetworkError.invalidToken)
                }
            case let .failure(error):
                onError(NetworkError.returnedWithError(error))
            }
            
        }
        task.resume()
    }
}
