import SwiftUI
import PhotosUI
struct EditProfileView: View {
    var body: some View {
        
        @State var selection: PhotosPickerItem? = nil
        @State var name = ""
        @State var age = 0
        @State var message = ""
        
        NavigationStack {
            ZStack(alignment: .top) {
                //Background
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                    
                // Edit field
                VStack(spacing: 16) {
                    // Photo picker
                    PhotosPicker(selection: $selection) {
                        ZStack {
                            Image("1")
                                .resizable()
                                .scaledToFit()
                                .clipShape(RoundedRectangle(cornerRadius: 6))
                                .frame(width: 150)
                            
                            Image(systemName: "photo.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(Color.white.opacity(0.75))
                                .frame(width: 60)
                        }
                    }
                    //Input field
                    InputField(text: $name, lable: "お名前", plceholder: "")
                    PickerField(selection: $age, titles: "年齢")
                    InputField(text: $message, lable: "メッセージ", plceholder: "入力してください", withDivider: false)
                    
                }
                .padding(.horizontal)
                .padding(.vertical, 32)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.systemGray4), lineWidth: 1)
                }
                .padding()
            }
            .navigationTitle("プロフィール変更")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("キャンセル") {
                        
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("変更") {
                        
                    }
                }
            }
            .font(.subheadline)
            .foregroundStyle(.primary)
        }
    }
}

#Preview {
    EditProfileView()
}
