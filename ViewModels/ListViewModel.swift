import Foundation

class ListViewModel {
    var users = [User]()
    
    private var currentIndex = 0
    
    init() {
        self.users = getMockUsers()
    }
    
    private func getMockUsers() -> [User] {
        return [
            User.mockUser1,
            User.mockUser2,
            User.mockUser3,
            User.mockUser4,
            User.mockUser5,
            User.mockUser6,
            User.mockUser7
        ]
    }
    
    func adjustIndex(isRedo: Bool) {
        if isRedo {
            currentIndex -= 1
        } else {
            currentIndex += 1
        }
    }
    func tappedHandler(action: Action) {
        switch action {
        case .like, .nope:
            if currentIndex >= users.count {return}
        case .redo:
            if currentIndex <= 0 {return}
                
        }
        NotificationCenter.default.post(name: Notification.Name("ACTIONFROMBUTTON"), object: nil, userInfo: [
            "id": action == .redo ? users[currentIndex - 1].id : users[currentIndex].id,
            "action": action
        ])
        
    }

}
