//
//  HomeScreenView.swift
//  Combatives App v1.0
//
//  Created by Ethan Bleakney on 5/9/24.
//

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
        }
        .frame(minWidth: 800, minHeight: 600)
    }
}



struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView(showSignInView: .constant(false))
    }
}
