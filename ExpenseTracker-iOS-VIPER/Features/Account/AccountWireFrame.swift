//
//  AccountWireFrame.swift
//  ExpenseTracker-iOS-VIPER
//
//  Created by Prabagaran, Ganesan (G.) on 07/11/21.
//

import Foundation
import UIKit

protocol RegisterWireFrameProtocol {
    func createRegisterModule() -> UIViewController
}

class AccountWireFrame: RegisterWireFrameProtocol {
    
    func createRegisterModule() -> UIViewController {
        let storyBoard = UIStoryboard(name: StoryboardConstants.main, bundle: nil)
        
        let vc = storyBoard.instantiateViewController(identifier: StoryboardConstants.registerView) { coder -> UIViewController? in
            let requestBuilder = URLRequestBuilder()
            let coreNetworking: CoreNetworkable = CoreNetWorking(urlSession: URLSession.shared,
                                                                 urlRequestBuilder: requestBuilder)
            let accountRepo = AccountRepositoryImp(networking: coreNetworking)
            var interactor: RegisterInteractor = RegisterInteractorImp(accountRepo: accountRepo)
            
            let presentor: RegisterViewPresenter &
                           RegisterInteractorOutputProtocol = RegisterViewPresenter(interactor: interactor)
            let registerView = RegisterView(coder, presenter: presentor)

            presentor.view = registerView
            interactor.presenter = presentor
        
            return registerView
        }
        
        return UINavigationController(rootViewController: vc)
    }
}


protocol HttpReq {
    var path: String { get }
    
    associatedtype Response = [String: Any]
    func serialize(data: Data) throws -> Response
}

extension HttpReq where Response == [String: Any] {
    func serailize(data: Data) throws -> Response {
        return try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
    }
}

extension HttpReq where Response: Codable {
    func serialize(data: Data) throws -> Response {
        return try JSONDecoder().decode(Response.self, from: data)
    }
    
    func genreActionHandler() {
        
    }
}

enum ListingAction: Equatable {
    case one(String)
    case two(title: String)
    case three
}
