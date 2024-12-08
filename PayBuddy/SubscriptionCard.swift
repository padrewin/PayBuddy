//
//  SubscriptionCard.swift
//  PayBuddy
//
//  Created by padrewin on 08.12.2024.
//

import SwiftUI

struct SubscriptionCard: View {
    var subscription: Subscription
    var onDelete: () -> Void

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(subscription.name)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.black)

                Text("Monthly Cost: \(String(format: "%.2f", subscription.cost)) USD")
                    .font(.subheadline)
                    .foregroundColor(.gray)

                Text("Next Payment: \(formattedDate(subscription.nextPaymentDate))")
                    .font(.caption)
                    .foregroundColor(.blue)
            }
            Spacer()
            Text(subscription.category)
                .padding(8)
                .background(Color.blue.opacity(0.1))
                .foregroundColor(.blue)
                .font(.footnote)
                .cornerRadius(8)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
        .contextMenu { // Context menu for delete
            Button(role: .destructive, action: onDelete) {
                Label("Delete", systemImage: "trash")
            }
        }
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}
