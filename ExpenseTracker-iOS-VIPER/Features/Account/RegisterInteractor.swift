//
//  RegisterInteractor.swift
//  ExpenseTracker-iOS-VIPER
//
//  Created by Prabagaran, Ganesan (G.) on 07/11/21.
//

import Foundation

protocol RegisterInteractor {
    func registerUser(of firstName: String?, _ lastName: String?, _ email: String?, _ password: String?)
    var presenter: RegisterInteractorOutputProtocol? { get set }
}

class RegisterInteractorImp: RegisterInteractor {
    
    private let accountRepo: AccountRepository
    weak var presenter: RegisterInteractorOutputProtocol?
    
    init(accountRepo: AccountRepository) {
        self.accountRepo = accountRepo
    }
    
    func registerUser(of firstName: String?,
                      _ lastName: String?,
                      _ email: String?,
                      _ password: String?) {
        if let firstName = firstName,
           let lastName = lastName,
           let email = email,
           let password = password {
            let user = ["firstName": firstName,
                        "lastName": lastName,
                        "email": email,
                        "password": password]
            
            accountRepo.register(user) { [weak self] string in
                self?.presenter?.onSuccess()
            } _: { [weak self] error in
                self?.presenter?.onError(error.localizedDescription)
            }
        }
    }
}
