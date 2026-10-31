//
//  ContentView.swift
//  BuyMyGroceries
//
//  Created by Jonathon Andrews on 10/22/26.
//  Add List of 5 or 6 items with pics
//  My extra thing to add is Stepper.
//  Will use it on adding qty to each item.

import SwiftUI

struct GroceryItem: Identifiable {
    let id = UUID()
    var graphicName: String
    var itemName: String
    var price: Int
    var quantity = 0
}

struct ContentView: View {
    @State private var items = [
        GroceryItem(graphicName: "apple", itemName: "Apple", price: 1),
        GroceryItem(graphicName: "tomato", itemName: "Tomato", price: 2),
        GroceryItem(graphicName: "bread", itemName: "Bread", price: 4),
        GroceryItem(graphicName: "milk", itemName: "Milk", price: 6),
        GroceryItem(graphicName: "eggs", itemName: "Eggs", price: 4)
    ]
    
    @State private var isShowingCheckout = false
    private var subtotal: Double {
        items.reduce(0) { $0 + Double($1.price * $1.quantity) }
    }
    
    private var deliveryFee: Double {
        subtotal * 0.10
    }
    
    private var total: Double {
        subtotal + deliveryFee
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach($items) { $item in
                    ListItem(item: $item)
                }
            }
            .listStyle(GroupedListStyle())
            .navigationTitle(Text("BuyMyGroceries"))
            .safeAreaInset(edge: .bottom) {
                VStack(spacing: 8) {
                    SummaryRow(label: "Subtotal", amount: subtotal)
                    SummaryRow(label: "Delivery Fee (10%)", amount: deliveryFee)
                    Divider()
                    SummaryRow(label: "Total", amount: total)
                        .font(.headline)
                    
                    Button {
                        isShowingCheckout = true
                    } label: {
                        Text("Checkout")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color("theme"))
                    .controlSize(.large)
                    .disabled(subtotal == 0)
                    .padding(.top, 8)
                }
                .padding()
                .background(.regularMaterial)
            }
            .sheet(isPresented: $isShowingCheckout, onDismiss: {
                for index in items.indices {
                    items[index].quantity = 0
                }
            }) {
                CheckoutView()
            }
        }
    }
}

struct ListItem: View {
    @Binding var item: GroceryItem

    var body: some View {
        HStack {
            Image(item.graphicName)
                .resizable()
                .scaledToFit()
                .frame(width: 44, height: 44)

            VStack(alignment: .leading) {
                Text(item.itemName)
                Text("$\(item.price)")
                Text("Quantity: \(item.quantity)")
            }
            .foregroundStyle(Color("theme"))

            Spacer()

            Stepper("Quantity", value: $item.quantity, in: 0...10)
                .labelsHidden()
        }
        .padding(.vertical, 4)
    }
}

struct SummaryRow: View {
    var label: String
    var amount: Double

    var body: some View {
        HStack {
            Text(label)
            Spacer()
            Text(amount, format: .currency(code: "USD"))
        
        }
    }
}

struct CheckoutView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 24) {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 72))
                .foregroundStyle(Color("theme"))

            Text("Checked Out")
                .font(.largeTitle)
                .bold()

            Button("Close") {
                dismiss()
            }
            .buttonStyle(.bordered)
            .controlSize(.large)
        }
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.light)
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
