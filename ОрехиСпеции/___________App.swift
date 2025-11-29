import SwiftUI

@main
struct ОрехиСпецииApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(CartManager.shared)
        }
    }
}
