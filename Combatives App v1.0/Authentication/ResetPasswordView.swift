//
//  ResetPasswordView.swift
//  Combatives App v1.0
//
//  Created by Ethan Bleakney on 1/26/24.
//

import SwiftUI
import Foundation

class ResetPasswordViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var errorMessage: String? // Used to display error messages to the user

    func resetPassword() async {
        do {
            try await AuthenticationManager.shared.resetPassword(email: email)
            // Handle success, e.g., showing a confirmation message to the user
        } catch {
            // Update the UI to show the error message
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
            }
        }
    }
}


struct ResetPasswordView: View {
    @StateObject private var viewModel = ResetPasswordViewModel()

    var body: some View {
        VStack {
            TextField("Enter your email", text: $viewModel.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
            
            Button("Reset Password") {
                Task {
                    await viewModel.resetPassword()
                }
            }
            .padding()
        }
        .padding()
    }
}

#Preview {
    ResetPasswordView()
}
