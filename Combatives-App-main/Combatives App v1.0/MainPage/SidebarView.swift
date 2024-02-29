//
//  SidebarView.swift
//  Combatives App v1.0
//
//  Created by James Huber on 2/15/24.
//

import SwiftUI


struct SidebarView: View {
    @Binding var selection: Int?
    var body: some View {
        List {
            NavigationLink(destination: HomeScreenView()) {
                Label("Home", systemImage: "house")
            }
            NavigationLink(destination: Text("Actions Content")) {
                Label("Actions", systemImage: "plus")
            }
            /*NavigationLink(destination: Text("Compose Content")) {
                Label("Compose", systemImage: "square.and.pencil")
            }*/
            NavigationLink(destination: SettingsView(showSignInView: .constant(false))) {// the destination for this will eventually need to be settings view
                Label("Settings", systemImage: "gear")
            }
        }
        .listStyle(SidebarListStyle())
        .navigationTitle("Menu")
    }
}
