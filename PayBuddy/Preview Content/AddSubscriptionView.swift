import SwiftUI

struct AddSubscriptionView: View {
    @Binding var subscriptions: [Subscription]
    @State private var name: String = ""
    @State private var cost: Double? = nil
    @State private var nextPaymentDate: Date = Date()
    @State private var category: String = ""

    @Environment(\.dismiss) var dismiss
    var saveAction: () -> Void

    var body: some View {
        VStack(spacing: 30) {
            Text("Add a New Subscription")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.top, 20)

            VStack(alignment: .leading, spacing: 20) {
                TextField("Enter subscription name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                TextField("Enter monthly cost (USD)", value: $cost, formatter: numberFormatter)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                DatePicker("Next Payment Date", selection: $nextPaymentDate, displayedComponents: .date)
                    .datePickerStyle(CompactDatePickerStyle())

                TextField("Enter category (e.g., Streaming)", text: $category)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding(.horizontal, 20)

            Button(action: saveSubscription) {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(LinearGradient(
                            gradient: Gradient(colors: [Color.blue, Color.indigo]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ))
                        .frame(height: 50)

                    Text("Save Subscription")
                        .font(.headline)
                        .foregroundColor(.white)
                }
            }
            .buttonStyle(PlainButtonStyle())

            Button(action: {
                dismiss()
            }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.red)
                        .frame(height: 50)

                    Text("Cancel")
                        .font(.headline)
                        .foregroundColor(.white)
                }
            }
            .buttonStyle(PlainButtonStyle())

            Spacer()
        }
        .padding()
    }

    private func saveSubscription() {
        guard let costValue = cost else { return } // Validare numerică
        let newSubscription = Subscription(
            name: name.isEmpty ? "Unnamed Subscription" : name,
            cost: costValue,
            nextPaymentDate: nextPaymentDate,
            category: category.isEmpty ? "Uncategorized" : category
        )
        subscriptions.append(newSubscription)
        saveAction()
        dismiss()
    }

    // Formatter pentru a permite doar numere
    private var numberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 0
        return formatter
    }
}
