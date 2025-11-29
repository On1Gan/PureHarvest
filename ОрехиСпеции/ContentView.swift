import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem { Label("Галоўная", systemImage: "leaf") }
            CatalogView()
                .tabItem { Label("Каталог", systemImage: "grid") }
            DeliveryView()
                .tabItem { Label("Дастаўка", systemImage: "truck.box.fill") }
            AboutView()
                .tabItem { Label("Аб нас", systemImage: "info.circle") }
            CartView()
                .tabItem { Label("Кошык", systemImage: "cart") }
        }
        .tint(Color("AccentGold"))
        .environmentObject(CartManager.shared)
    }
}

struct HomeView: View {
    @EnvironmentObject private var cartManager: CartManager
    @State private var searchText = ""
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                VStack(spacing: 20) {
                    Image("nuts_bowl")
                        .resizable()
                        .scaledToFill()
                        .frame(height: 340)
                        .clipped()

                    HStack {
                        Image(systemName: "magnifyingglass")
                        TextField("Пошук арэхаў, сухафруктаў, прыпраў...", text: $searchText)
                        if !searchText.isEmpty {
                            Button { searchText = "" } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    .padding()
                    .background(.fill.tertiary)
                    .clipShape(Capsule())
                    .padding(.horizontal)

                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        CategoryTile(title: "Арэхі",      image: "cat_nuts",    count: ProductsDataSource.products(in: .nuts).count) { path.append(Category.nuts) }
                        CategoryTile(title: "Сухафрукты", image: "cat_dried",   count: ProductsDataSource.products(in: .driedFruits).count) { path.append(Category.driedFruits) }
                        CategoryTile(title: "Прыправы",   image: "cat_spices",  count: ProductsDataSource.products(in: .spices).count) { path.append(Category.spices) }
                        CategoryTile(title: "Падарункі",  image: "cat_gift",    count: 8) { path.append(Category.nuts) }
                    }
                    .padding(.horizontal)

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Хіты продажу")
                            .font(.title2.bold())
                            .padding(.horizontal)

                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 16) {
                                ForEach(ProductsDataSource.allProducts.prefix(6)) { product in
                                    ProductCard(product: product)
                                        .frame(width: 160)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }

                    Spacer(minLength: 100)
                }
            }
            .navigationTitle("Pure Harvest")
            .navigationDestination(for: Category.self) { category in
                CatalogView(selectedCategory: category)  // ← Это работает, если CatalogView public или в том же файле
            }
        }
        .overlay(alignment: .bottom) {
            if !cartManager.items.isEmpty {
                HStack {
                    Image(systemName: "cart.fill")
                    Text("Кошык • \(cartManager.totalPrice, specifier: "%.2f") BYN (\(cartManager.items.count))")
                        .fontWeight(.semibold)
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(Color("AccentGold"))
                .clipShape(Capsule())
                .padding()
            }
        }
    }
}

// КАТЕГОРИИ
struct CategoryTile: View {
    let title: String
    let image: String
    let count: Int
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack {
                Image(image)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 140)
                    .clipped()
                Text(title)
                    .font(.title3.bold())
                Text("\(count) тавараў")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding()
            .background(Color("BackgroundGray"))
            .clipShape(.rect(cornerRadius: 20))
            .shadow(radius: 5)
        }
        .buttonStyle(.plain)
    }
}

// КАРТОЧКА ТОВАРА
struct ProductCard: View {
    let product: Product
    @EnvironmentObject var cartManager: CartManager

    var body: some View {
        VStack(spacing: 8) {
            Image(product.imageName)
                .resizable()
                .scaledToFill()
                .frame(height: 100)
                .clipped()
                .cornerRadius(12)

            Text(product.name)
                .font(.caption)
                .lineLimit(2)
                .multilineTextAlignment(.center)

            HStack {
                Text("\(product.pricePer100g, specifier: "%.2f") BYN / 100г")
                    .fontWeight(.semibold)
                Spacer()
                Button {
                    cartManager.addToCart(product: product)
                } label: {
                    Image(systemName: "plus")
                        .font(.title3)
                        .padding(8)
                        .background(Color("AccentGold"))
                        .foregroundColor(.white)
                        .clipShape(Circle())
                }
            }
        }
        .padding(12)
        .background(Color("BackgroundGray"))
        .clipShape(.rect(cornerRadius: 16))
    }
}

#Preview {
    ContentView()
        .environmentObject(CartManager.shared)
}
