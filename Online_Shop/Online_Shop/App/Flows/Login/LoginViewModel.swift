//
//  LoginViewModel.swift
//  Online_Shop
//
//  Created by Alexander Grigoryev on 7/13/22.
//

import Foundation
import SwiftUI

@MainActor final class LoginViewModel: ObservableObject {
    @Published var login = ""
    @Published var password = ""
    @Published var alertItem: AlertItem?
    @Published var isLoading = false
    var isLogin = false
    var loginResult = false
    let containerBuilder = ContainerBuilder()
    
    func getData(login: String, password: String) {
        let container = containerBuilder.makeContainer()
        let factory = RequestFactory(container: container)
        let auth = factory.makeAuthRequestFactory()
        
        auth.login(userName: login, password: password) { [weak self] result in
            guard let self = self else { return }
            
            switch result.result {
            case .success(let login):
                DispatchQueue.main.async {
                    self.loginResult = login.result == 1 ? true : false
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func loginCheck() {
        if !login.isEmpty && !password.isEmpty {
            self.getData(login: login, password: password)
            self.isLoading = true
        } else {
            self.alertItem = AlertItem(title: Text("Error"), message: Text("Please enter login and password"))
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            if self.loginResult {
                self.isLogin = true
                self.isLoading = false
            }
        }
    }
}
