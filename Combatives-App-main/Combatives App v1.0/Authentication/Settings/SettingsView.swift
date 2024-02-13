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

            NavigationLink(destination: ResetPasswordView()) {
                Text("Reset Password")
            }
            
            NavigationLink(destination: UpdatePasswordView()) {
                Text("Update Password")
            }
            
            NavigationLink(destination: UpdateEmailView()) {
                Text("Update Email")
            }
            .navigationBarTitle("Settings")
        }
    }
}

#Preview {
    NavigationStack {
        SettingsView(showSignInView: .constant(false))
    }
}
