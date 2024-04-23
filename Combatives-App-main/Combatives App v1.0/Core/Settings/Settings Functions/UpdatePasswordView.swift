//
//  UpdatePasswordView.swift
//  Combatives App v1.0
//
//  Created by Ethan Bleakney on 1/26/24.
//

import SwiftUI
import FirebaseAuth

class UpdatePasswordViewModel: ObservableObject {
    @Published var oldPassword: String = ""
    @Published var newPassword: String = ""
    @Published var confirmPassword: String = ""
    @Published var errorMessage: String?
    @Published var passwordUpdated: Bool = false
    @Published var showOldPassword: Bool = false
    @Published var showNewPassword: Bool = false
    @Published var showConfirmPassword: Bool = false

    func verifyOldPassword() async -> Bool {
        // Assuming you have a way to retrieve the current user's email
        guard let email = Auth.auth().currentUser?.email else { return false }
        return await AuthenticationManager.shared.verifyOldPassword(email: email, oldPassword: oldPassword)
    }

    func updatePassword() async {
        // Initialize passwordUpdated message to false, to not display
        passwordUpdated = false
        
        guard newPassword == confirmPassword else {
            errorMessage = "New passwords do not match."
            return
        }

        let isOldPasswordCorrect = await verifyOldPassword()
        guard isOldPasswordCorrect else {
            errorMessage = "Old password is incorrect."
            return
        }

        do {
            try await AuthenticationManager.shared.updatePassword(password: newPassword)
            errorMessage = nil // Clear any previous error message
            // Show the passwordUpdated message
            DispatchQueue.main.async {
                self.passwordUpdated = true
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
            }
        }
    }
}




struct UpdatePasswordView: View {
    @StateObject private var viewModel = UpdatePasswordViewModel()

    var body: some View {
        VStack {
            passwordField(title: "Enter your old password", text: $viewModel.oldPassword, showPassword: $viewModel.showOldPassword)
                .padding()

            passwordField(title: "Enter your new password", text: $viewModel.newPassword, showPassword: $viewModel.showNewPassword)
                .padding()

            passwordField(title: "Re-enter your new password", text: $viewModel.confirmPassword, showPassword: $viewModel.showConfirmPassword)
                .padding()

            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
            
            if viewModel.passwordUpdated {
                Text("Password has been updated")
                    .foregroundColor(.red)
            }

            Button("Update Password") {
                Task {
                    // If verifyOldPassword returns true, call update password
                    if await viewModel.verifyOldPassword() { await viewModel.updatePassword() }
                }
            }
            .padding()
        }
    }
    
    @ViewBuilder
    private func passwordField(title: String, text: Binding<String>, showPassword: Binding<Bool>) -> some View {
        HStack {
            if showPassword.wrappedValue {
                TextField(title, text: text)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
            } else {
                SecureField(title, text: text)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
            }
            Button(action: {
                showPassword.wrappedValue.toggle()
            }) {
                Image(systemName: showPassword.wrappedValue ? "eye.slash.fill" : "eye.fill")
            }
        }
    }
}


#Preview {
    UpdatePasswordView()
}
