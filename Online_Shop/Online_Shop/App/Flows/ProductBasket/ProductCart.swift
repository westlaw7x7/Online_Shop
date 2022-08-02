//
//  ProductCart.swift
//  Online_Shop
//
//  Created by Alexander Grigoryev on 7/26/22.
//

import SwiftUI

struct ProductCart: View {
    @StateObject var basket: ProductCartViewModel
    
    var body: some View {
        VStack {
            Text("Your products")
                .font(.system(size: 30))
                .bold()
            List {
                ForEach(basket.dictOfProducts.keys.sorted(), id: \.self) { key in
                    ForEach(basket.dictOfProducts[key]!) { value in
                        HStack {
                            Text(value.productName)
                                .padding(.leading, 15)
                            Spacer()
                            Text(" Price \(value.productPrice) $")
                                .padding(.trailing, 15)
                        }
                    }
                }
            }
            Spacer()
            Text("Total price is: \(basket.totalPrice)")
                .padding(.bottom, 10)
            Button("Pay") {
                basket.pay(totalPrice: basket.totalPrice)
                basket.payOnButton()
            }
            .foregroundColor(.green)
            .padding(.bottom, 10)
            
            Button("Delete all products") {
                basket.deleteAllProducts()
            }
            .foregroundColor(.red)
            .padding(.bottom, 10)
        }  .alert(item: $basket.alertItem) { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        }
    }
}

