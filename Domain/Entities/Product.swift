import Foundation

/// Чистая модель товара — без SwiftUI, без хранения
public struct Product: Identifiable, Hashable {
    public let id = UUID()
    public let name: String
    public let pricePer100g: Double
    public let imageName: String
    
    public init(name: String, pricePer100g: Double, imageName: String) {
        self.name = name
        self.pricePer100g = pricePer100g
        self.imageName = imageName
    }
}
