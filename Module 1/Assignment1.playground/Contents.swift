
import Foundation

// Dataset: products and prices, stored as an array of tuples
typealias Product = (name: String, price: Float)

let products: [Product] = [
    ("Time Magazine", 4.95),
    ("Penne Pasta", 2.96),
    ("Gallon Milk", 3.59),
    ("Dozen Eggs", 2.25),
    ("Gallon OJ", 5.25),
    ("Can of Soup", 1.29),
    ("Catfood", 8.99)
]
let taxRate: Float = 0.09

// Summary function: returns a tuple of summary values
func summarize(_ items: [Product]) -> (count: Int, total: Float, average: Float,
                                       cheapest: Product, mostExpensive: Product)? {
    guard let first = items.first else {
        return nil
    }

    var total: Float = 0
    var cheapest = first
    var mostExpensive = first

    for item in items {
        total += item.price
        if item.price < cheapest.price {
            cheapest = item
        }
        if item.price > mostExpensive.price {
            mostExpensive = item
        }
    }

    let average = total / Float(items.count)
    return (items.count, total, average, cheapest, mostExpensive)
}

// Filter function: takes a closure that decides which items to keep
func filterProducts(_ items: [Product], where condition: (Product) -> Bool) -> [Product] {
    var result: [Product] = []
    for item in items {
        if condition(item) {
            result.append(item)
        }
    }
    return result
}

// Print the summary
if let summary = summarize(products) {
    let tax = summary.total * taxRate
    print("=== Summary ===")
    print("Items: \(summary.count)")
    print(String(format: "Subtotal: $%.2f", summary.total))
    print(String(format: "Average: $%.2f", summary.average))
    print(String(format: "Tax (9%%): $%.2f", tax))
    print(String(format: "Total: $%.2f", summary.total + tax))
    print(String(format: "Cheapest: %@ at $%.2f", summary.cheapest.name, summary.cheapest.price))
    print(String(format: "Most expensive: %@ at $%.2f", summary.mostExpensive.name, summary.mostExpensive.price))
}

// Filter with a closure: items over $3.00
let over3 = filterProducts(products) { $0.price > 3.00 }

print("\n=== Items over $3.00 ===")
for item in over3 {
    print(String(format: "%@: $%.2f", item.name, item.price))
}
