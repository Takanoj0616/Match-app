import SwiftUI

struct ChatView: View {
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(0..<15) { _ in
                        HStack {
                            Circle()
                                .frame(width: 60, height: 60)
                            Capsule()
                                .frame(height: 60)
                        }
                        .padding(.bottom)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 72)
            }
            .background(Color.cyan)
            
            // Input
            HStack {
                Circle()
                    .frame(width: 40, height: 40)
                Circle()
                    .frame(width: 40, height: 40)
                Circle()
                    .frame(width: 40, height: 40)
                Capsule()
                    .frame(height: 40)
                Circle()
                    .frame(width: 40, height: 40)
            }
            .padding()
            .background(Color.white)
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
