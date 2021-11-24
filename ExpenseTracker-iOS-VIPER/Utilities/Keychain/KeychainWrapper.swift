//
//  KeychainLayer.swift
//  ExpenseTracker-iOS-VIPER
//
//  Created by Prabagaran, Ganesan (G.) on 23/11/21.
//

import Foundation

final class KeychainInteractor {
        
    private init() {}
    
    func save(_ data: Data, service: String, account: String) throws {
        let query = [
            kSecValueData: data,
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account
        ] as CFDictionary
        
        let status = SecItemAdd(query, nil)
        if status != errSecSuccess {
            throw ConfigError.keychainSavingError
        }
    }
    
    private func update(_ data: Data, service: String, account: String) {
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword
        ] as CFDictionary
        
        let attributesToUpdates = [kSecValueData: data] as CFDictionary
        
        SecItemUpdate(query, attributesToUpdates)
    }
    
    public func read(service: String, account: String) -> Data? {
        
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword,
            kSecReturnData: true
        ] as CFDictionary
        
        var result: AnyObject?
        
        SecItemCopyMatching(query, &result)
        return (result as? Data)
    }
}

public enum ConfigError: String, LocalizedError {
    case keychainSavingError = "Saving into keychain failed"
    case keychainRetrieveError = "There is no value saved for this key"
}

