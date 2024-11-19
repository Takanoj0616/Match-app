import SwiftUI

struct CardView: View {
    
    @State private var offset: CGSize = .zero
    let user:User
    let adjustIndex: (Bool) -> Void
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.black
            imageLayer
            
            LinearGradient(colors: [.clear,.black], startPoint: .center, endPoint: .bottom)
            
            informationLayer
            
            //LIKE and NOPE
            LikeAndNope
            
        }
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .offset(offset)
        .gesture(getsture)
        .scaleEffect(scale)
        .rotationEffect(.degrees(angle))
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("ACTIONFROMBUTTON"), object: nil)) { data in
            receivedHandler(data: data)
        }
    }
}

#Preview {
    ListView()
}

//MARK: -UI
extension CardView {
    
    private var imageLayer: some View {
        Image(user.photoUrl ?? "1")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 100)
    }
    
    private var informationLayer: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .bottom) {
                Text(user.name)
                    .font(.largeTitle.bold())
                Text("\(user.age)")
                    .font(.title2)
                Image(systemName: "checkmark.seal.fill")
                    .foregroundStyle(.white, .blue)
                    .font(.title2)
            }
            
            if let message = user.message {
                Text(message)
            }
        }
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        
    }
    
    private var LikeAndNope: some View {
        HStack {
            //Like
            Text("Like")
                .likeNopeText(isLiked: true)
                .opacity(opacity)
            
            Spacer()
            //Nope
            Text("Nope")
                .likeNopeText(isLiked: false)
                .opacity(-opacity)
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
}


// MARK: -Action
extension CardView {
    
    private var screenWidth: CGFloat {
        guard let windows = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return 0.0 }
        return windows.screen.bounds.width
    }
    
    private var scale: CGFloat {
        return max(1.0 - (abs(offset.width) / screenWidth), 0.75)
    }
    
    private var angle: Double {
        return (offset.width / screenWidth) * 10.0
    }
    
    private var opacity: Double {
        return (offset.width / screenWidth) * 4.0
    }
    
    private func removeCard(isLiked: Bool, height: CGFloat = 0.0)  {
        withAnimation {
            offset = CGSize(width: isLiked ? screenWidth * 1.5 : -screenWidth * 1.5, height: height)
        }
        adjustIndex(false)
    }
    
    private func resetCard()  {
        withAnimation(.smooth) {
            offset = .zero
        }
        
    }
    
    private var getsture: some Gesture {
        DragGesture()
            .onChanged{ value in
                let width = value.translation.width
                let height = value.translation.height
                
                let limitedeHeight = height > 0 ? min(height, 100) : max(height, -100)
                
                offset = CGSize(width: width, height: limitedeHeight)
            }
            .onEnded { value in
                
                let width = value.translation.width
                let height = value.translation.height
                
                
                if (abs(width) > (screenWidth / 4)) {
                    removeCard(isLiked: width > 0, height: height)
                } else {
                    resetCard()
                }
            }
    }
    
    private func receivedHandler(data: NotificationCenter.Publisher.Output) {
        guard
            let info = data.userInfo,
            let id = info["id"] as? String,
            let action = info["action"] as? Action
        else { return }
        
        if id == user.id {
            switch action {
            case .redo:
                resetCard()
            case .nope:
                removeCard(isLiked: false)
            case .like:
                removeCard(isLiked: true)
            }
        }
    }
}


