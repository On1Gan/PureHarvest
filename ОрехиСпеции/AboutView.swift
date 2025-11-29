import SwiftUI

struct AboutView: View {
    var body: some View {
        NavigationStack {
            Text("Аб нас")
                .font(.largeTitle)
                .bold()
        }
        .navigationTitle("Аб нас")
    }
}

#Preview {
    AboutView()
}
