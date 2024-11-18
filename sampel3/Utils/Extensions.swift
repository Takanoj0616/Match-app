import SwiftUI

extension Text {
    
    func likeNopeText(isLiked: Bool) -> some View {
        self
            .tracking(4)
            .foregroundColor(isLiked ? .green : .red)
            .font(.system(size: 50))
            .fontWeight(.heavy)
            .padding(.horizontal, 8)
            .padding(.vertical, 2)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(isLiked ? .green : .red, lineWidth: 5)
            )
            .rotationEffect(Angle(degrees: isLiked ? -15 : 15))
            .offset(x: isLiked ? 16 : -16, y: isLiked ? 30 : 36)
    }
}
