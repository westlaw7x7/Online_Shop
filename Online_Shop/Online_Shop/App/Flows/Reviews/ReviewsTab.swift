//
//  ReviewsTab.swift
//  Online_Shop
//
//  Created by Alexander Grigoryev on 7/18/22.
//

import SwiftUI

struct ReviewsTab: View {
    let product: Product
    @StateObject var viewModel: MainMenuViewModel
    @StateObject var reviewViewModel: ReviewsViewModel

    var body: some View {
        VStack {
            Text("Reviews")
                .font(.system(size: 30.0))
                .bold()
            List (){
                ForEach(product.productReviews ?? [], id: \.self) { review in
                Text(review.nameOfReviewer)
                        .bold()
                    Text(review.review)
                        .italic()
                }
            }
            Button("Delete review") {
                reviewViewModel.deleteReview(id: product.id)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                viewModel.getProductList(categoryID: viewModel.searchText)
                }
                reviewViewModel.alertItem = AlertItem(title: Text("Successful"), message: Text("The latest review has been deleted"))
            }
            .foregroundColor(.red)
        }.toolbar {
            NavigationLink {
                ReviewsEntryField(viewModel: reviewViewModel, mainMenuView: viewModel, id: product.id)
            } label: {
                Text("Write a review")
            }
        }
        .alert(item: $reviewViewModel.alertItem) { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        }
    }
}
