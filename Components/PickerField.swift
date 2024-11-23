import SwiftUI

struct PickerField: View {
    
    @Binding var selection: Int
    let titles: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(titles)
                    .foregroundStyle(Color(.darkGray))
                    .fontWeight(.semibold)
                    .font(.footnote)
                Spacer()
                Picker(selection: $selection) {
                    ForEach(18..<100) { number in
                        Text("\(number)")
                            .tag(number)
                    }
                } label: {
                    Text("年齢")
                }
                .tint(.black)
                
            }
            Divider()
        }
    }
}

#Preview {
    PickerField(selection: .constant(18), titles: "title")
}
