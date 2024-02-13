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
                    UserProfileView()
                    GridView()
                }
                .padding(.top)
                .padding(.trailing) // Add padding to shift UserProfileView to the right
            }
        }
        .frame(minWidth: 800, minHeight: 600)
    }
}

struct SidebarView: View {
    @Binding var selection: Int?
    var body: some View {
        List {
            NavigationLink(destination: Text("Home Content")) {
                Label("Home", systemImage: "house")
            }
            NavigationLink(destination: Text("Actions Content")) {
                Label("Actions", systemImage: "plus")
            }
            NavigationLink(destination: Text("Compose Content")) {
                Label("Compose", systemImage: "square.and.pencil")
            }
            NavigationLink(destination: Text("Settings Content")) {// the destination for this will eventually need to be settings view
                Label("Settings", systemImage: "gear")
            }
        }
        .listStyle(SidebarListStyle())
        .navigationTitle("Menu")
    }
}

struct MainContentView: View {
    @Binding var selection: Int?
    var body: some View {
        SidebarView(selection: $selection)
            .navigationBarHidden(true)
    }
}

struct DetailView: View {
    let selection: Int
    var body: some View {
        Text("Detail view for selection \(selection)")
    }
}

struct UserProfileView: View {
    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                // Profile button action
            }) {
                HStack {
                    Text("Jess Militar")
                    Image(systemName: "person.crop.circle.fill")
                }
                .padding(.horizontal)
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}

struct GridView: View {
    let columns = [GridItem(.adaptive(minimum: 160), spacing: 20)]
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(0..<9) { item in
                    ZStack {
                        Rectangle()
                            .foregroundColor(Color(hue: Double(item) / 9.0, saturation: 0.3, brightness: 0.9))
                            .cornerRadius(12)
                        Text("Item \(item)")
                    }
                    .aspectRatio(1, contentMode: .fit)
                }
            }
            .padding(.horizontal)
        }
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}
