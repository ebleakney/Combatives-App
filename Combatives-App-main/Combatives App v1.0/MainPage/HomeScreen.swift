import SwiftUI

struct HomeScreenView: View {
    @State private var selection: Int? = nil

    var body: some View {
        NavigationSplitView {
            SidebarView(selection: $selection)
        } content: {
            MainContentView(selection: $selection)
        } detail: {
            if let selection = selection {
                DetailView(selection: selection)
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
