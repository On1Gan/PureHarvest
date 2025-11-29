import Foundation

enum Category: String, CaseIterable, Hashable { // ← ДОБАВЬ Hashable ЗДЕСЬ!
    case nuts = "Арэхі"
    case driedFruits = "Сухафрукты"
    case spices = "Прыправы"
    
    var rawValue: String {
        switch self {
        case .nuts: return "Арэхі"
        case .driedFruits: return "Сухафрукты"
        case .spices: return "Прыправы"
        }
    }
}
