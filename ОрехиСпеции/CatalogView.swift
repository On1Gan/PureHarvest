import SwiftUI

struct CatalogView: View {
    let selectedCategory: Category?
    
    init(selectedCategory: Category? = nil) {
        self.selectedCategory = selectedCategory
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    if let category = selectedCategory {
                        Text(categoryTitle(for: category))
                            .font(.title.bold())
                            .padding()
                    }
                    
                    let products = filteredProducts()
                    
                    if products.isEmpty {
                        Text("Тавараў пакуль няма 😔")
                            .foregroundColor(.secondary)
                            .padding()
                    } else {
                        LazyVStack(spacing: 12) {
                            ForEach(products) { product in
                                ProductRow(product: product)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .navigationTitle("Каталог")
        }
    }
    
    private func filteredProducts() -> [Product] {
        guard let category = selectedCategory else {
            return ProductsDataSource.allProducts
        }
        return ProductsDataSource.products(in: category)
    }
    
    private func categoryTitle(for category: Category) -> String {
        switch category {
        case .nuts: return "Арэхі"
        case .driedFruits: return "Сухафрукты"
        case .spices: return "Прыправы"
        }
    }
}

struct ProductRow: View {
    let product: Product
    @EnvironmentObject var cartManager: CartManager
    
    var body: some View {
        HStack {
            Image(product.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .clipped()
                .cornerRadius(12)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(product.name)
                    .font(.headline)
                Text("\(product.pricePer100g, specifier: "%.2f") BYN / 100 г")
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Button {
                cartManager.addToCart(product: product)
            } label: {
                Image(systemName: "plus.circle.fill")
                    .font(.title)
                    .foregroundColor(Color("AccentGold"))
            }
        }
        .padding()
        .background(Color("BackgroundGray"))
        .clipShape(.rect(cornerRadius: 16))
        .padding(.horizontal)
    }
}

#Preview {
    NavigationStack {
        CatalogView(selectedCategory: .nuts)
            .environmentObject(CartManager.shared)
    }
}
