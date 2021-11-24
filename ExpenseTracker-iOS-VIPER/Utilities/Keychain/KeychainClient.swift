//
//  KeychainClient.swift
//  ExpenseTracker-iOS-VIPER
//
//  Created by Prabagaran, Ganesan (G.) on 24/11/21.
//

import Foundation

class KeyChainClient {
    private let keychainInteractor: KeychainInteractor
    
    init(keychainInteractor: KeychainInteractor) {
        self.keychainInteractor = keychainInteractor
    }
    
    func save<T: Codable>(_ item: T, service: String, account: String) throws {
        let data = try JSONEncoder().encode(item)
        try keychainInteractor.save(data, service: service, account: account)
    }
    
    func read<T: Codable>(service: String, account: String, type: T.Type) throws -> T {
        
        guard let data = keychainInteractor.read(service: service, account: account) else {
            throw ConfigError.keychainRetrieveError
        }
        let item = try JSONDecoder().decode(type, from: data)
        return item
    }
}
