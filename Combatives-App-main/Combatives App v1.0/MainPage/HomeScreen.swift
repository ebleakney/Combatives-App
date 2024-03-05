import SwiftUI

enum SidebarSelection: Int, Hashable {
    case home
    case actions
    case settings
}

struct HomeScreenView: View {
    @State private var selection: SidebarSelection? = .home

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
                    UserProfileView()
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
        HomeScreenView()
    }
}
