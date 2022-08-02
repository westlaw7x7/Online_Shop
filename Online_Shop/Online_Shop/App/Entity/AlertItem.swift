//
//  AlertItem.swift
//  Online_Shop
//
//  Created by Alexander Grigoryev on 7/15/22.
//

import SwiftUI

struct AlertItem: Identifiable {
    var id = UUID()
    var title: Text
    var message: Text?
    var dismissButton: Alert.Button?
}
