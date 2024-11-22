import Foundation
import FirebaseFirestore

class ListViewModel: ObservableObject {
    @Published var users = [User]()
    
    private var currentIndex = 0
    
    @MainActor
    init() {
        
        Task {
            self.users = await fetchUsers()
            print("self.users: \(self.users)")
        }
        
    }
    
    //Download Users data
    private func fetchUsers() async -> [User] {
        do {
            let snapshot = try await Firestore.firestore().collection("users").getDocuments()
            var tempUsers = [User]()
            
            for document in snapshot.documents {
                let  user = try document.data(as: User.self)
                tempUsers.append(user)
            }
            return tempUsers
            
        } catch {
            print("ユーザーデータの取得に失敗しました : \(error.localizedDescription)")
            return []
        }

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
