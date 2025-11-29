import SwiftUI

struct DeliveryView: View {
    var body: some View {
        NavigationStack {
            Text("Дастаўка")
                .font(.largeTitle)
                .bold()
        }
        .navigationTitle("Дастаўка")
    }
}

#Preview {
    DeliveryView()
}
