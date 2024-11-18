import SwiftUI

struct InputField: View {
    
    @Binding var text: String
    let lable: String
    let plceholder: String
    var isSecureFiled = false
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 12) {
            Text(lable)
                .foregroundStyle(Color(.darkGray))
                .fontWeight(.semibold)
                .font(.footnote)
            
            if isSecureFiled {
                SecureField(plceholder, text: $text)
            } else {
                TextField(plceholder, text: $text)
            }
            Divider()
        }
    }
}

#Preview {
    InputField(text: .constant(""), lable: "メールアドレス", plceholder: "入力してください")
}
