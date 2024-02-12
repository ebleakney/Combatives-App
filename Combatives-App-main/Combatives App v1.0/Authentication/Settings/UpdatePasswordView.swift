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

    func verifyOldPassword() async -> Bool {
        // Assuming you have a way to retrieve the current user's email
        guard let email = Auth.auth().currentUser?.email else { return false }
        return await AuthenticationManager.shared.verifyOldPassword(email: email, oldPassword: oldPassword)
    }

    func updatePassword() async {
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
            TextField("Enter your old password", text: $viewModel.oldPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Enter your new password", text: $viewModel.newPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Re-enter your new password", text: $viewModel.confirmPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
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
}


#Preview {
    UpdatePasswordView()
}
