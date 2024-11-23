import SwiftUI

struct RegistrationView: View {
    
    let authViewModel: AuthViewModel
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var name: String = ""
    @State private var age: Int = 18
    @State private var conforemPassword: String = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
            VStack {
                BrandImage()
                
                VStack(spacing: 24) {
                    InputField(text: $email, lable: "メールアドレス", plceholder: "入力してください")
                    InputField(text: $name, lable: "お名前", plceholder: "入力してください")
                    PickerField(selection: $age, titles: "年齢")
                    InputField(text: $password, lable: "パスワード", plceholder: "6文字以上で入力してください", isSecureFiled: true)
                    InputField(text: $conforemPassword, lable: "パスワード(確認用）", plceholder: "6文字以上で入力してください", isSecureFiled: true)
                }
                
                BasicButton(label: "登録", icon: "arrow.right") {
                    Task {
                        await authViewModel.createAccount(
                            email:email,
                            password: password,
                            name: name,
                            age: age
                        )
                    }
                }
                .padding(.top, 24)
                Spacer()
                
                Button {
                    dismiss()
                } label: {
                    HStack {
                        Text("すでにアカウントをお持ちの方")
                        Text("ログイン")
                            .fontWeight(.bold)
                    }
                    .foregroundStyle(Color(.darkGray))
                }
            }
            .padding(.horizontal)
        }
}

#Preview {
    RegistrationView(authViewModel: AuthViewModel())
}
