//
//  ContentView.swift
//  Combatives App v1.0
//
//  Created by Ethan Bleakney on 1/11/24.
// Joined by James Huber 1/11/24
//

import SwiftUI
import FirebaseAuth

@MainActor
final class AppViewModel: ObservableObject {
    @Published var isAuthenticated = false

    private var authStateDidChangeListenerHandle: AuthStateDidChangeListenerHandle?

    init() {
        authStateDidChangeListenerHandle = Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
            self?.isAuthenticated = user != nil
        }
    }

    deinit {
        if let handle = authStateDidChangeListenerHandle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    func signOut() {
        try? AuthenticationManager.shared.signOut()
        isAuthenticated = false
    }
    
    // Add signIn and signUp methods here if needed
}



struct ContentView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State private var showSignInView = false
    @State private var showSignUpView = false
    
    var body: some View {
        if viewModel.isAuthenticated {
            // User is authenticated, show the main app view
            MainAppView(showSignInView: $showSignInView)
                .environmentObject(viewModel) // Pass viewModel to use for signOut etc.
        } else {
            NavigationStack {
                // User is not authenticated, show sign in or sign up view
                InitLogin(showSignInView: $showSignInView, showSignUpView: $showSignUpView)
                    .environmentObject(viewModel)
            }
        }
    }
}



struct MainAppView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @Binding var showSignInView: Bool
    
    var body: some View {
        NavigationStack {
            // Your main app content here, e.g., a sidebar, a home screen, etc.
            HomeScreenView(showSignInView: $showSignInView)
                .navigationBarItems(trailing: Button("Sign Out") {
                    viewModel.signOut()
                })
        }
    }
}



#Preview {
    ContentView()
        .environmentObject(AppViewModel())
}
