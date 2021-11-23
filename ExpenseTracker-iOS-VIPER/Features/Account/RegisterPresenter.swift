//
//  RegisterPresenter.swift
//  ExpenseTracker-iOS-VIPER
//
//  Created by Prabagaran, Ganesan (G.) on 07/11/21.
//

import Foundation

protocol RegisterInteractorInputProtocol {
    func viewDidLoad()
    func register(_ firstName: String?, _ lastName: String?, _ email: String?, _ password: String?)
}

protocol RegisterInteractorOutputProtocol: AnyObject {
    func onSuccess()
    func onError(_ error: String)
}

class RegisterViewPresenter: RegisterInteractorInputProtocol {
    weak var view: RegisterViewProtocol?
    private let interactor: RegisterInteractor
    
    init(interactor: RegisterInteractor) {
        self.interactor = interactor
    }
    
    func viewDidLoad() {
        
    }
    
    func register(_ firstName: String?, _ lastName: String?, _ email: String?, _ password: String?) {
        interactor.registerUser(of: firstName, lastName, email, password)
    }
    
}

extension RegisterViewPresenter: RegisterInteractorOutputProtocol {
    
    func onSuccess() {
        view?.onSuccess()
    }
    
    func onError(_ error: String) {
        view?.showError(error)
    }
}

protocol RegisterViewProtocol: AnyObject {
    func showError(_ error: String)
    func onSuccess()
}
