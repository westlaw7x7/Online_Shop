//
//  Online_ShopApp.swift
//  Online_Shop
//
//  Created by Alexander Grigoryev on 6/9/22.
//

import SwiftUI

@main
struct Online_ShopApp: App {
    @StateObject var viewModel = MainMenuViewModel()
    
    var body: some Scene {
        WindowGroup {
            LoginView()
        }
    }
}
