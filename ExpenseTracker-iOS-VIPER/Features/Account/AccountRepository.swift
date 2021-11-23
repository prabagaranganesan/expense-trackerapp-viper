//
//  AccountRepository.swift
//  ExpenseTracker-iOS-VIPER
//
//  Created by Prabagaran, Ganesan (G.) on 07/11/21.
//

import Foundation

protocol AccountRepository {
    func register(_ user: [String: String],
                  _ onSuccess: @escaping (String) -> (),
                  _ onError: @escaping (Error) -> ())
}

struct AccountRepositoryImp: AccountRepository {
    
    private let networking: CoreNetworkable
    
    init(networking: CoreNetworkable) {
        self.networking = networking
    }
    
    func register(_ user: [String: String],
                  _ onSuccess: @escaping (String) -> (),
                  _ onError: @escaping (Error) -> ())  {
        
        let request = HttpRequest(baseURL: URLConstants.baseURL,
                                  path: URLConstants.Account.register,
                                  body: user,
                                  type: .post,
                                  headers: ["Content-Type": "application/json"])
        do {
            try networking.fetchData(for: request) { (response: RegisterResponse)  in
                onSuccess("")
            } onError: { error in
                onError(error)
            }
        } catch {
            onError(error)
        }
    }
}

struct UserRegisterRequest: Encodable {
    let firstName: String
    let lastName: String
    let email: String
    let password: String
}

struct RegisterResponse: Decodable {
    let token: String
}
