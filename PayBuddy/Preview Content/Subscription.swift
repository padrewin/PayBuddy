//
//  Subscription.swift
//  PayBuddy
//
//  Created by padrewin on 08.12.2024.
//

import Foundation

struct Subscription: Identifiable, Codable {
    let id: UUID
    var name: String
    var cost: Double
    var nextPaymentDate: Date
    var category: String
    var currency: String

    init(id: UUID = UUID(), name: String, cost: Double, nextPaymentDate: Date, category: String, currency: String = "USD") {
        self.id = id
        self.name = name
        self.cost = cost
        self.nextPaymentDate = nextPaymentDate
        self.category = category
        self.currency = currency
    }
}
