//
//  SidebarView.swift
//  Combatives App v1.0
//
//  Created by James Huber on 2/15/24.
//

import SwiftUI


struct SidebarView: View {
    @Binding var selection: SidebarSelection?
    
    var body: some View {
        List {
            NavigationLink(value: SidebarSelection.home) {
                Label("Home", systemImage: "house")
            }
            NavigationLink(value: SidebarSelection.actions) {
                Label("Actions", systemImage: "plus")
            }
            NavigationLink(value: SidebarSelection.settings) {
                Label("Settings", systemImage: "gear")
            }
        }
        .navigationDestination(for: SidebarSelection.self) { selection in
            switch selection {
            case .home:
                // Return the home content view
                Text("Home Content")
            case .actions:
                // Return the actions content view
                Text("Actions Content")
            case .settings:
                // Return the settings view
                SettingsView(showSignInView: .constant(false))
            }
        }
        .listStyle(SidebarListStyle())
        .navigationTitle("Menu")
    }
}
