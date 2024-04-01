//
//  SidebarView.swift
//  Combatives App v1.0
//
//  Created by James Huber on 2/15/24.
//


import SwiftUI

//NOTE: The SidebarSelection enum that contains the home, actions, settings, and profile types is in the HomeScreen.swift file
// It allows the use of those types in this file for navigation

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
            NavigationLink(value: SidebarSelection.profile) {
                Label("Profile", systemImage: "person.crop.circle.fill")
            }
        }
        /*
         With the navigationDestination(for:) modifier, you can define the destination views based on the selected value. 
         This approach eliminates the need for a NavigationLink to have a destination parameter, 
         preventing the duplication of views when navigating back and forth.
         */
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
            case .profile:
                Text("Profile View")
            }
        }
        .listStyle(SidebarListStyle())
        .navigationTitle("Menu")
    }
}
