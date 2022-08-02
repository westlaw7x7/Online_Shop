//
//  SignUpView.swift
//  Online_Shop
//
//  Created by Alexander Grigoryev on 7/14/22.
//

import SwiftUI

struct SignUpView: View {
    @StateObject var viewModel: SingUpViewModel = SingUpViewModel()
    
    var body: some View {
        VStack() {
            Text("Registration")
                .font(.largeTitle)
                .bold()
                .multilineTextAlignment(.center)
            Text("Fill in your data for the registration, or update your current information")
                .multilineTextAlignment(.leading)
                .padding(.top, 5.0)
            Form {
                Group {
                    TextField("User ID (Your unique number)", text: $viewModel.id)
                        .keyboardType(.numberPad)
                    TextField("Name", text: $viewModel.username)
                    TextField("Password", text: $viewModel.password)
                    TextField("Email", text: $viewModel.email)
                    TextField("Credit Card", text: $viewModel.creditCard)
                    TextField("Bio", text: $viewModel.bio)
                }
                .textFieldStyle(.automatic)
                .padding(.leading, 10.0)
                HStack {
                    Picker(selection: $viewModel.gender, label: Text("Select Gender")) {
                        Text("Choose...").tag(Gender.choose)
                        Text("Male").tag(Gender.male)
                        Text("Female").tag(Gender.female)
                    }
                }
            }
            Group {
                HStack {
                    Button("Register") {
                        viewModel.registerOnButton()
                    }
                    Button("Update") {
                        viewModel.updateInfoOnButton()
                    }
                }
            }   .buttonStyle(.bordered)
            
        }
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        }
    }
}
