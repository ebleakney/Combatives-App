//
//  ContentView.swift
//  Combatives App v1.0
//
//  Created by Ethan Bleakney on 1/11/24.
// Joined by James Huber 1/11/24
//
/*
import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}
*/

import SwiftUI
import FirebaseAuth

@MainActor
final class AppViewModel: ObservableObject {
    @Published var isAuthenticated = false
    
    init() {
        // Check authentication state when the app starts
        isAuthenticated = Auth.auth().currentUser != nil
    }
    
    func signOut() {
        try? AuthenticationManager.shared.signOut()
        isAuthenticated = false
    }
    
    // Add signIn and signUp methods here if needed
}

struct ContentView: View {
    @StateObject private var viewModel = AppViewModel()
    
    var body: some View {
        if viewModel.isAuthenticated {
            // User is authenticated, show the main app view
            MainAppView()
                .environmentObject(viewModel) // Pass viewModel to use for signOut etc.
        } else {
            // User is not authenticated, show sign in or sign up view
            InitLogin()
                .environmentObject(viewModel)
        }
    }
}

struct MainAppView: View {
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        NavigationStack {
            // Your main app content here, e.g., a sidebar, a home screen, etc.
            HomeScreenView()
                .navigationBarItems(trailing: Button("Sign Out") {
                    viewModel.signOut()
                })
        }
    }
}

// Update your InitLogin, SignInWithEmailView, and SignUpWithEmailView to use the AppViewModel for navigation and authentication state changes.

#Preview {
    ContentView()
}
