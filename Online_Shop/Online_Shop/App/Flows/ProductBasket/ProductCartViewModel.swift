//
//  ProductCartViewModel.swift
//  Online_Shop
//
//  Created by Alexander Grigoryev on 7/26/22.
//

import Foundation
import SwiftUI

@MainActor final class ProductCartViewModel: ObservableObject {
    @Published private var isEmpty = true
    @Published private var isPaid = false
    @Published private var userMessage = ""
    @Published var dictOfProducts: Dictionary<String, [Product]> = [:]
    @Published var alertItem: AlertItem?
    @Published var totalPrice = 0
    
    let containerBuilder = ContainerBuilder()
    
    func group(product: Product) {
        if dictOfProducts.keys.contains(product.productName) {
            dictOfProducts[product.productName]?.append(product)
        } else  {
            dictOfProducts.updateValue([product], forKey: product.productName)
        }
    }
    
    func countProducts(product: Product) -> Int {
        var totalcount = 0
        if dictOfProducts.keys.contains(product.productName) {
            totalcount = dictOfProducts[product.productName]!.count
        } else {
            totalcount = 0
        }
        return totalcount
    }
    
    func pay(totalPrice: Int) {
        let container = containerBuilder.makeContainer()
        let factory = RequestFactory(container: container)
        let payForProducts = factory.makePayForProductsDataFactory()
        
        payForProducts.pay(totalPrice: totalPrice) { [weak self] data in
            guard let self = self else { return }
            switch data.result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.isPaid = data.result == 1 ? true : false
                    self.userMessage = data.userMessage
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func payOnButton() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if self.isPaid {
                self.alertItem = AlertItem(title: Text("Success"), message: Text("\(self.userMessage)"))
                self.dictOfProducts.removeAll()
                self.totalPrice = 0
            } else {
                self.alertItem = AlertItem(title:Text("Error"), message: Text("The payment is unsuccessful, please, try again"))
            }
        }
    }
    
    func deleteAllProducts() {
        self.dictOfProducts.removeAll()
        self.totalPrice = 0
    }
}
