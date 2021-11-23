//
//  RegisterView.swift
//  ExpenseTracker-iOS-VIPER
//
//  Created by Prabagaran, Ganesan (G.) on 07/11/21.
//

import UIKit

class RegisterView: UIViewController {
    
    var presenter: RegisterViewPresenter?
    
    @IBOutlet weak var firstNameLabel: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var emailLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    
    init?(_ coder: NSCoder,
         presenter: RegisterViewPresenter) {
        self.presenter = presenter
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    
    @IBAction func submitTapped(_ sender: Any) {
        presenter?.register(firstNameLabel.text, lastName.text, emailLabel.text, passwordLabel.text)
    }
}

extension RegisterView: RegisterViewProtocol {
    func onSuccess() {
        print("Account has been created")
    }
    
    func showError(_ error: String) {
        print("\(error) occured")
    }
}

