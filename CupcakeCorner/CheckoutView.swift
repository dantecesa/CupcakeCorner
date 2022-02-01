//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Dante Cesa on 1/28/22.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    @EnvironmentObject var views: Views
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(height: 233)
                    
                    Text("Your total is \(order.cost, format: .currency(code: Locale.current.currencyCode ?? "USD"))")
                        .font(.title)
                    
                    Button("Place Order") {
                        Task {
                            await placeOrder()
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Check out")
            .navigationBarTitleDisplayMode(.inline)
            .alert("Thank you!", isPresented: $showingConfirmation) {
                Button("OK") {
                    self.views.stacked = false
                }
            } message: {
                Text(confirmationMessage)
            }
        }
    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
        
        var request = URLRequest(url: URL(string: "https://reqres.in/api/cupcakes")!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity) x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            showingConfirmation = true
        } catch {
            print("Checkout failed.")
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
