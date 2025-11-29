import Foundation
import Combine

// CartManager — теперь использует Product из Domain
// НЕ НАДО ПИСАТЬ struct Product ЗДЕСЬ — он уже в Domain!

// Элемент в корзине
struct CartItem: Identifiable, Hashable {
    let id = UUID()
    let product: Product        // ← берётся из Domain
    var weight: Double = 100
    var quantity: Int = 1
}

// Менеджер корзины
class CartManager: ObservableObject {
    static let shared = CartManager()
    private init() {}
    
    @Published var items: [CartItem] = []
    
    func addToCart(product: Product, weight: Double = 100) {
        if let index = items.firstIndex(where: { $0.product.id == product.id && $0.weight == weight }) {
            items[index].quantity += 1
        } else {
            items.append(CartItem(product: product, weight: weight))
        }
    }
    
    var totalPrice: Double {
        items.reduce(0) { $0 + ($1.product.pricePer100g * $1.weight / 100 * Double($1.quantity)) }
    }
    
    func increaseQuantity(_ item: CartItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index].quantity += 1
        }
    }
    
    func decreaseQuantity(_ item: CartItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            if items[index].quantity > 1 {
                items[index].quantity -= 1
            } else {
                items.remove(at: index)
            }
        }
    }
    
    func remove(_ item: CartItem) {
        items.removeAll { $0.id == item.id }
    }
    
    func clear() {
        items.removeAll()
    }
}
