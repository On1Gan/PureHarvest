import Foundation

/// Все товары приложения — пока в коде, потом легко поменять на сеть
struct ProductsDataSource {
    static let allProducts: [Product] = [
        Product(name: "Грэцкі арэх", pricePer100g: 3.20, imageName: "walnut"),
        Product(name: "Міндаль",      pricePer100g: 4.50, imageName: "almond"),
        Product(name: "Кешью",        pricePer100g: 5.10, imageName: "cashew"),
        Product(name: "Фундук",       pricePer100g: 4.80, imageName: "hazelnut"),
        Product(name: "Курага",       pricePer100g: 2.90, imageName: "apricot"),
        Product(name: "Чарнасліў",    pricePer100g: 3.10, imageName: "prune"),
        Product(name: "Разынкі",      pricePer100g: 2.70, imageName: "raisin"),
        Product(name: "Фінікі",       pricePer100g: 3.50, imageName: "date"),
        Product(name: "Куркума",      pricePer100g: 1.80, imageName: "turmeric"),
        Product(name: "Карэца",       pricePer100g: 2.40, imageName: "cinnamon"),
        Product(name: "Папрыка",      pricePer100g: 1.90, imageName: "paprika"),
        Product(name: "Зіра",         pricePer100g: 2.60, imageName: "cumin")
    ]
    
    static func products(in category: Category) -> [Product] {
        switch category {
        case .nuts:
            return allProducts.filter {
                ["Грэцкі арэх", "Міндаль", "Кешью", "Фундук"].contains($0.name)
            }
        case .driedFruits:
            return allProducts.filter {
                ["Курага", "Чарнасліў", "Разынкі", "Фінікі"].contains($0.name)
            }
        case .spices:
            return allProducts.filter {
                ["Куркума", "Карэца", "Папрыка", "Зіра"].contains($0.name)
            }
        }
    }
}
