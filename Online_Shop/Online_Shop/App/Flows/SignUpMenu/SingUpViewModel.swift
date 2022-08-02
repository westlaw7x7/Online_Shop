//
//  SingUpViewModel.swift
//  Online_Shop
//
//  Created by Alexander Grigoryev on 7/14/22.
//

import Foundation
import SwiftUI

@MainActor final class SingUpViewModel: ObservableObject {
    let containerBuilder = ContainerBuilder()
    @Published var alertItem: AlertItem?
    @Published var isRegistered = false
    @Published var isDataChanged = false
    @Published var id = ""
    @Published var username = ""
    @Published var password = ""
    @Published var email = ""
    @Published var gender: Gender = .choose
    @Published var creditCard = ""
    @Published var bio = ""
    
    func register(userData: UserData) {
        let container = containerBuilder.makeContainer()
        let factory = RequestFactory(container: container)
        let register = factory.makeRegisterRequestFactory()
        
        register.register(userData: userData) { [weak self] data in
            guard let self = self else { return }
            switch data.result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.isRegistered = data.result == 1 ? true : false
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func changeData(userData: UserData) {
        let container = containerBuilder.makeContainer()
        let factory = RequestFactory(container: container)
        let changeData = factory.makeChangeDataRequestFactory()
        
        changeData.change(userData: userData) { [weak self] data in
            guard let self = self else { return }
            switch data.result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.isDataChanged = data.result == 1 ? true : false
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func createUser(id: String, username: String, password: String, email: String, gender: Gender, creditCard: String, bio: String ) -> UserData {
        let userData = UserData(id: Int(id) ?? 0, username: username, password: password, email: email, gender: gender, creditCard: creditCard, bio: bio)
        
        return userData
    }
    
    func registerOnButton() {
        let data = createUser(id: id, username: username, password: password, email: email, gender: Gender(rawValue: gender.rawValue) ?? Gender.choose, creditCard: creditCard, bio: bio)
        
        guard !id.isEmpty,
              !username.isEmpty,
              !password.isEmpty,
              !email.isEmpty,
              !creditCard.isEmpty,
              !bio.isEmpty,
              data.gender != .choose
        else {
            self.alertItem = AlertItem(title: Text("Error"), message: Text("Each field needs to be filled"))
            return
        }
        
        self.register(userData: data)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if self.isRegistered {
                self.alertItem = AlertItem(title: Text("Success"), message: Text("You've been registered"))
            } else {
                self.alertItem = AlertItem(title: Text("Error"), message: Text("Registration failed, check out your data"))
            }
        }
    }
    
    func updateInfoOnButton() {
        let newData = createUser(id: id, username: username, password: password, email: email, gender: gender, creditCard: (Gender(rawValue: gender.rawValue) ?? Gender.choose).rawValue, bio: bio)
        
        guard !id.isEmpty,
              !username.isEmpty,
              !password.isEmpty,
              !email.isEmpty,
              !creditCard.isEmpty,
              !bio.isEmpty,
              newData.gender != .choose
        else {
            self.alertItem = AlertItem(title: Text("Error"), message: Text("Each field needs to be filled"))
            return
        }
        
        self.changeData(userData: newData)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if self.isDataChanged {
                self.alertItem = AlertItem(title: Text("Success"), message: Text("Your data has been updated"))
            } else {
                self.alertItem = AlertItem(title: Text("Error, try again"), message: Text("Data isn't updated, check out your data"))
            }
        }
    }
}
