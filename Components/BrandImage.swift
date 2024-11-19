import SwiftUI

struct BrandImage: View {
    var body: some View {
        VStack {
            Image(systemName: "flame.circle.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(.red)
                .frame(width: 120, height: 120)
                .padding(.vertical, 32)
        }
    }
}

#Preview {
    BrandImage()
}
