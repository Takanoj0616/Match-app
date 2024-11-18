import SwiftUI

struct ContentView: View {
    
    @ObservedObject var authViewModel = AuthViewModel()
    
    var body: some View {
        Group {
            if authViewModel.userSession != nil {
                ListView()
            } else {
                LoginView(authViewModel: authViewModel)
            }
        }
    }
}

#Preview {
    LoginView(authViewModel: AuthViewModel())
}
