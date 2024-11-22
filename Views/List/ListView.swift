import SwiftUI

struct ListView: View {
    
    @ObservedObject private var viewModel = ListViewModel()
    
    var body: some View {
        Group {
            if viewModel.users.count > 0 {
                VStack(spacing: 0) {
                    // Cards
                    cards
                    actions
                }
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.black)
                )
                .padding(.horizontal, 6)
            } else {
                ProgressView()
                    .padding()
                    .tint(Color.white)
                    .background(Color.gray)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                    .scaleEffect(1.5)
            }
        }
    }
}

#Preview {
    ListView()
}

extension ListView {
    private var cards: some View {
        ZStack {
            ForEach(viewModel.users.reversed()) { user in
                CardView(user: user) { isRedo in
                    viewModel.adjustIndex(isRedo: isRedo)
                }
            }
        }
    }
    private var actions: some View {
        // Actions
        HStack(spacing: 60) {
            ForEach(Action.allCases, id: \.self) {type in
                type.createAction(viewModel: viewModel)
            }
        }
        .foregroundColor(.white)
        .frame(height: 100)
    }
}
