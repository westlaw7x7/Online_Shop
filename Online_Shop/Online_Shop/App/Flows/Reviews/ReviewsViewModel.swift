//
//  ReviewsViewModel.swift
//  Online_Shop
//
//  Created by Alexander Grigoryev on 7/24/22.
//

import Foundation
import SwiftUI

@MainActor final class ReviewsViewModel: ObservableObject {
    
    @Published var alertItem: AlertItem?
    @Published var text = ""
    @Published var textName = ""
    @Published var isDeleted = false
    
    let containerBuilder = ContainerBuilder()
    var isAdded = false

    func addReview(review: String,
                   nameOfReviewer: String,
                   id: String) {
        let container = containerBuilder.makeContainer()
        let factory = RequestFactory(container: container)
        let add = factory.makeAddReviewDataFactory()
        
        add.addReview(review: review,
                      nameOfReviewer: nameOfReviewer,
                      id: id) { [weak self] data in
            guard let self = self else { return }
            switch data.result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.isAdded = data.result == 1 ? true : false
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func deleteReview(id: String) {
        let container = containerBuilder.makeContainer()
        let factory = RequestFactory(container: container)
        let review = factory.makeAddReviewDataFactory()
        
        review.deleteReview(id: id) { [weak self] data in
            guard let self = self else { return }
            switch data.result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.isDeleted = data.result == 1 ? true : false
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func saveReview(id: String ) {
        if !text.isEmpty && !textName.isEmpty {
            self.addReview(review: text,
                                nameOfReviewer: textName,
                                id: id)
        } else {
            self.alertItem = AlertItem(title: Text("Error"), message: Text("Enter your name and review"))
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            if self.isAdded {
                self.alertItem = AlertItem(title: Text("Success"), message: Text("Your review has been added"))
                self.clearTheFields()
            } else {
                self.alertItem = AlertItem(title: Text("Error"), message: Text("Unknown error, try again later"))
            }
        }
    }
    
    func clearTheFields() {
        self.text.removeAll()
        self.textName.removeAll()
    }
}
