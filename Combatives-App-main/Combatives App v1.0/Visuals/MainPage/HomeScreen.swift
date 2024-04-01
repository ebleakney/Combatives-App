import SwiftUI

// enables the sidebar selections in the Sidebar View
enum SidebarSelection: Int, Hashable {
    case home
    case actions
    case settings
    case profile
}

struct HomeScreenView: View {
    @State private var selection: SidebarSelection? = .home
    @Binding var showSignInView: Bool

    var body: some View {
        NavigationSplitView {
            SidebarView(selection: $selection)
        } content: {
            MainContentView(selection: $selection)
        } detail: {
            if let selection = selection {
                DetailView(selection: selection.rawValue)
            } else {
                VStack {
                    GridView()
                }
                .padding(.top)
                .padding(.trailing) // Add padding to shift UserProfileView to the right
                .overlay(
                    ProfileView(showSignInView: $showSignInView)
                        .padding(.bottom)
                        .padding(.trailing)
                    , alignment: .topTrailing
                )
            }
        }
        .frame(minWidth: 800, minHeight: 600)
    }
}


struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView(showSignInView: .constant(false))
    }
}
