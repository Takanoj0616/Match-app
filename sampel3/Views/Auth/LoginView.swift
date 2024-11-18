import SwiftUI

struct LoginView: View {
    
    let authViewModel: AuthViewModel
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                // Image
                BrandImage()
                
                // 入力フォーム
                VStack(spacing: 24) {
                    InputField(text: $email, lable: "メールアドレス", plceholder: "入力してください")
                    InputField(text: $password, lable: "パスワード", plceholder: "半角英数字6文字以上", isSecureFiled: true)
                }
                //: -ボタン
                BasicButton(label: "ログイン", icon: "arrow.right") {
                    Task {
                        await authViewModel.login(email: email, password: password)
                    }
                }
                .padding(.top, 24)
                Spacer()
                // navigation
                NavigationLink {
                    RegistrationView(authViewModel: authViewModel)
                        .navigationBarBackButtonHidden()
                } label: {
                    HStack {
                        Text("まだアカウントをお持ちでない方は")
                        Text("新規登録")
                            .fontWeight(.bold)
                    }
                    .foregroundStyle(Color(.darkGray))
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    LoginView(authViewModel: AuthViewModel())
}
