//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Dante Cesa on 1/28/22.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var viewModel: OrderViewModel
    
    var body: some View {
        Form {
            Section {
                TextField("First & Last Name", text: $viewModel.currentOrder.name)
                TextField("Street Address", text: $viewModel.currentOrder.streetAddress)
                TextField("City", text: $viewModel.currentOrder.city)
                TextField("Zip", text: $viewModel.currentOrder.zip)
            }
            
            Section {
                NavigationLink(destination: { CheckoutView(viewModel: viewModel) },
                               label: { Text("Check out") })
                    .disabled(viewModel.currentOrder.hasValidAddress == false)
            }
        }
        .navigationTitle("Delivery Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(viewModel: OrderViewModel())
    }
}
