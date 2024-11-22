import Foundation
import FirebaseAuth
import FirebaseFirestore
class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    
    init() {
        self.userSession = Auth.auth().currentUser
        print("\(self.userSession?.email!)")
    }
    
    // Login
    func login(email: String, password: String) async {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            print("ログイン成功 \(result.user.email!)")
            self.userSession = result.user
            print("\(self.userSession?.email!)")
        } catch let error as NSError {
            print("ログイン失敗 \(error.localizedDescription) (コード: \(error.code))")
        }
    }
    
    // Logout
    func logout() {
        do {
            try Auth.auth().signOut()
            print("ログアウト成功")
            self.userSession = nil
        } catch let error as NSError {
            print("ログアウト失敗 \(error.localizedDescription) (コード: \(error.code))")
        }
    }
    
    // Create Account
    @MainActor
    func createAccount(email: String, password: String, name: String, age: Int) async {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            print("アカウント作成成功: \(result.user.email!)")
            self.userSession = result.user
            let newUser = User(id: result.user.uid, name: name, email: email, age: age)
            await uploadUserData(withUser: newUser)
        } catch let error as NSError {
            print("アカウント作成失敗 \(error.localizedDescription) (コード: \(error.code))")
        }
    }
    
    // Delete Account
    func deleteAccount() async {
        guard let user = Auth.auth().currentUser else {
            print("削除失敗: ログインしていません")
            return
        }
        
        do {
            try await user.delete()
            print("アカウント削除成功")
        } catch let error as NSError {
            print("アカウント削除失敗 \(error.localizedDescription) (コード: \(error.code))")
        }
    }
    
    //Upload User Data
    private func uploadUserData(withUser user: User) async {
        do {
           let userData = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(userData)
            print("データ保存成功")
        } catch {
            print("データ保存失敗: \(error.localizedDescription)")
            
        }

    }
}
