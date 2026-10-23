import Playgrounds

@main
struct GroceriesApp {
    static func main() {
        let products: [String: Float] = [
            "Time Magazine": 4.95,
            "Penne Pasta": 2.96,
            "Gallon Milk": 3.59,
            "Dozen Eggs": 2.25,
            "Gallon OJ": 5.25,
            "Can of Soup": 1.29,
            "Catfood": 8.99
        ]
        let taxrate: Float = 0.09
        
        var count = 0
        var subtotal: Float = 0
        
        for (_, price) in products {
            subtotal += price
            count += 1
        }
        print(subtotal)
        
        let average = count > 0 ? subtotal / Float(count) : 0
        let tax = subtotal * taxrate
        let total = subtotal + tax
        
        print("Items: \(count)")
        print(String(format: "Average: $%.2f", average))
        print(String(format: "Tax: $%.2f", tax))
        print(String(format: "Total: $%.2f", total))
        
        func findMinPrice(in products:[String: Float])-> (item: String, price: Float)? {
            guard let first = products.first else {
                return nil
            }
            var cheapestItem = first.key
            var minPrice = first.value
            
            for (item, price) in products {
                if price < minPrice {
                    minPrice = price
                    cheapestItem = item
                }
            }
                return (cheapestItem, minPrice)
        }
        if let cheapest = findMinPrice(in: products) {
            print("Cheapest: \(cheapest.item) at $\(String(format: "%.2f", cheapest.price))")
        }
            
    }
    
}

