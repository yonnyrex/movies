//
//  LoginViewModel.swift
//  movies
//
//  Created by Yonny on 30/11/24.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
        
    // MARK: - Propety Wrappers
    @Published var user = ""
    @Published var password = ""
    @Published var error: LoginError?
    @Published var isLoading = false
    @Published var displayError = false
    
    // MARK: - Variables
    private var loginService: LoginServiceType
    private var cancellables: Set<AnyCancellable> = .init()

    var fieldsAreEmpty: Bool {
        user.isEmpty || password.isEmpty
    }
    
    // MARK: - Initializer
    init(
        loginService: LoginServiceType = LoginService()
    ) {
        self.loginService = loginService
        setupBindings()
    }
    
    // MARK: - Methods
    func setupBindings() {
        $error
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                guard error != nil else { return }
                
                self?.displayError = true
            }
            .store(in: &cancellables)
    }
    
    
    func login() {
        isLoading = true
        loginService
            .login(user: user, password: password)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                self?.isLoading = false
                switch result {
                case .failure(let error):
                    self?.error = .error(message: error.message)
                case .finished:
                    return
                }
            } receiveValue: { result in
                print(result.message)
            }
            .store(in: &cancellables)
    }
    
}
