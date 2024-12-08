import SwiftUI

struct ContentView: View {
    @State private var subscriptions: [Subscription] = {
        if let data = UserDefaults.standard.data(forKey: "subscriptions") {
            if let decoded = try? JSONDecoder().decode([Subscription].self, from: data) {
                return decoded
            }
        }
        return []
    }()

    @State private var isShowingAddSubscription = false

    var totalMonthlyCost: Double {
        subscriptions.reduce(0) { $0 + $1.cost }
    }

    var totalAnnualCost: Double {
        totalMonthlyCost * 12
    }

    var body: some View {
        ZStack {
            // Full background gradient
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                // Header with total costs
                VStack(alignment: .center, spacing: 10) {
                    Text("PayBuddy")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.bottom, 5)

                    Text("Total Monthly Cost: \(String(format: "%.2f", totalMonthlyCost)) USD")
                        .font(.title2)
                        .foregroundColor(.green)
                        .bold()

                    Text("Total Annual Cost: \(String(format: "%.2f", totalAnnualCost)) USD")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.7))
                }
                .padding()

                // Subscription list
                List {
                    ForEach(subscriptions) { subscription in
                        SubscriptionCard(subscription: subscription) {
                            deleteSubscription(subscription)
                        }
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                    }
                }
                .listStyle(PlainListStyle())
                .background(Color.clear)
                .scrollContentBackground(.hidden)
                .padding(.bottom, 90) // Extra space for floating button
            }

            // Floating button
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        isShowingAddSubscription = true
                    }) {
                        ZStack {
                            Circle()
                                .fill(LinearGradient(gradient: Gradient(colors: [Color.green, Color.teal]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                .frame(width: 70, height: 70)

                            Image(systemName: "plus")
                                .font(.system(size: 30))
                                .foregroundColor(.white)
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 5)
                    .padding(.trailing, 20)
                    .padding(.bottom, 20)
                }
            }
            .zIndex(1)
        }
        .sheet(isPresented: $isShowingAddSubscription) {
            AddSubscriptionView(subscriptions: $subscriptions, saveAction: saveSubscriptions)
        }
        .onAppear {
            loadSubscriptions()
        }
    }

    private func saveSubscriptions() {
        if let encoded = try? JSONEncoder().encode(subscriptions) {
            UserDefaults.standard.set(encoded, forKey: "subscriptions")
        }
    }

    private func deleteSubscription(_ subscription: Subscription) {
        if let index = subscriptions.firstIndex(where: { $0.id == subscription.id }) {
            subscriptions.remove(at: index)
            saveSubscriptions()
        }
    }

    private func loadSubscriptions() {
        if let data = UserDefaults.standard.data(forKey: "subscriptions") {
            if let decoded = try? JSONDecoder().decode([Subscription].self, from: data) {
                subscriptions = decoded
            }
        }
    }
}
