import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartManager: CartManager
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Кошык")
                    .font(.largeTitle)
                    .bold()
                
                if cartManager.items.isEmpty {
                    Text("Кошык пусты")
                        .foregroundColor(.secondary)
                } else {
                    Text("У вас \(cartManager.items.count) тавараў")
                }
            }
        }
        .navigationTitle("Кошык")
    }
}

#Preview {
    CartView()
        .environmentObject(CartManager.shared)
}
