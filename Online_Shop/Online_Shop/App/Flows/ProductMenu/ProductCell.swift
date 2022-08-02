//
//  ProductCell.swift
//  Online_Shop
//
//  Created by Alexander Grigoryev on 7/27/22.
//

import SwiftUI

struct ProductCell: View {
    let product: Product
    @StateObject var basket: ProductCartViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text(product.productName)
                    .padding(.leading, 5)
                Spacer()
                Text(" Price \(product.productPrice) $")
                    .padding(.leading, 10)
                Image(systemName: "minus.circle" )
                    .onTapGesture {
                        basket.dictOfProducts.forEach { key, value in
                            if key.contains(product.productName) && !value.isEmpty {
                                basket.dictOfProducts[product.productName]?.removeLast()
                                basket.totalPrice -= product.productPrice
                            }
                        }
                    }
                
                Image(systemName: "plus.circle")
                    .onTapGesture {
                        basket.group(product: product)
                        basket.totalPrice += product.productPrice
                    }
                
                Text("\(basket.countProducts(product: product))")
            }
        }
    }
}
