//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Dante Cesa on 1/28/22.
//

import SwiftUI

class Views: ObservableObject {
    @Published var stacked = false
}

struct ContentView: View {
    @StateObject var viewModel = OrderViewModel()
    @State var orderInProgress: Bool = false
    
    @ObservedObject var views = Views()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("🧑🏻‍🍳 Flavor", selection: $viewModel.currentOrder.type) {
                        ForEach(0..<Order.types.count) { index in
                            Text(Order.types[index])
                        }
                    }
                    
                    Stepper("# of 🧁s: \(viewModel.currentOrder.quantity)", value: $viewModel.currentOrder.quantity, in: 3...20)
                }
                
                Section {
                    Toggle("🙇🏻‍♂️ Special Request?", isOn: $viewModel.currentOrder.specialRequestEnabled.animation())
                }
                
                if viewModel.currentOrder.specialRequestEnabled {
                    Section {
                        Toggle("❄️ Extra Frosting?", isOn: $viewModel.currentOrder.extraFrosting)
                        
                        Toggle("✨ Add Sprinkles?", isOn: $viewModel.currentOrder.addSprinkles)
                    }
                }
                
                Section {
                    NavigationLink(destination: AddressView(viewModel: viewModel), isActive: self.$views.stacked) {
                        Text("Delivery details")
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
        .navigationViewStyle(.stack)
        .environmentObject(views)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
