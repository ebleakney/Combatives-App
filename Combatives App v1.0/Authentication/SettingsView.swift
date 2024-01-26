//
//  SettingsView.swift
//  Combatives App v1.0
//
//  Created by Ethan Bleakney on 1/24/24.
//

import SwiftUI

@MainActor
final class SettingsViewModel: ObservableObject {
    
    
    func signOut() throws {
       try AuthenticationManager.shared.signOut()
    }
    
//    func resetPassword() async throws {
//        try await AuthenticationManager.shared.resetPassword(email: <#T##String#>)
//    }
//    
//    func updatePassword() async throws {
//        try await AuthenticationManager.shared.updatePassword(password: <#T##String#>)
//    }
//    
//    func updateEmail() async throws {
//        let authUser = try AuthenticationManager.shared.getAuthenticatedUser()
//        guard let email = authUser.email else {
//            throw URLError(.badServerResponse)
//        }
//                
//        try await AuthenticationManager.shared.updateEmail(email: email)
//    }
}


struct SettingsView: View {
    
    @StateObject private var viewModel = SettingsViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        List {
            Button("Log out") {
                Task {
                    do {
                       try viewModel.signOut()
                        showSignInView = true
                    } catch {
                        // NEED TO MAKE ACTUAL ERROR CATCHING HERE
                        print(error)
                    }
                }
            }
            
            Button("Reset password") {
                
            }
        }
        .navigationBarTitle("Settings")
    }
}

#Preview {
    NavigationStack {
        SettingsView(showSignInView: .constant(false))
    }
}
