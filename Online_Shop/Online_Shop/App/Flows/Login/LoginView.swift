//
//  LoginView.swift
//  Online_Shop
//
//  Created by Alexander Grigoryev on 7/13/22.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel = LoginViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                GeometryReader { geometry in
                    Image("wallpaper")
                        .resizable()
                        .edgesIgnoringSafeArea(.all)
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: geometry.size.width, maxHeight: geometry.size.height)
                }
                VStack {
                    Text("Online Shop")
                        .font(.system(.largeTitle, design: .rounded))
                        .bold()
                        .foregroundColor(.yellow)
                    TextField("Login", text: $viewModel.login)
                        .textFieldStyle(.roundedBorder)
                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(.roundedBorder)
                    NavigationLink(isActive: $viewModel.isLogin) {
                        MainMenuView()
                    } label: {
                        Button("Sing In") {
                            viewModel.loginCheck()
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    NavigationLink {
                        SignUpView()
                    } label: {
                        Text("Sign Up")
                    }
                    if viewModel.isLoading == true {
                        ProgressView("Logging in...")
                            .foregroundColor(.white)
                    }
                    Spacer()
                }
            }.alert(item: $viewModel.alertItem) { alertItem in
                Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
            }
        }
    }
}
