import SwiftUI

struct HomeScreenView: View {
    @State private var selection: SidebarSelection? = .home
    @Binding var showSignInView: Bool

    var body: some View {
        NavigationSplitView {
            SidebarView(selection: $selection)
        } content: {
            SidebarContentView(selection: $selection)
        } detail: {
            VStack {
                GridView()
            }
            .padding(.top)
            .padding(.trailing) // Add padding to shift UserProfileView to the right
//            .overlay(
//                ProfileView(showSignInView: $showSignInView)
//                    .padding(.bottom)
//                    .padding(.trailing)
//                , alignment: .topTrailing
//            )
        }
        .frame(minWidth: 800, minHeight: 600)
    }
}



struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView(showSignInView: .constant(false))
    }
}
