//
//  UpdateEmailView.swift
//  Combatives App v1.0
//
//  Created by Ethan Bleakney on 2/12/24.
//

import SwiftUI

class UpdateEmailViewModel: ObservableObject {
    @Published var newEmail: String = ""
    @Published var errorMessage: String?
    @Published var emailUpdateSent: Bool = false // To track if the email reset was sent
    
    func updateEmail() async {
        // Clear previous states
        errorMessage = nil
        emailUpdateSent = false
        
        do {
            try await AuthenticationManager.shared.updateEmail(email: newEmail)
            // Set emailUpdateSent to true on success
            DispatchQueue.main.async {
                self.emailUpdateSent = true
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
            }
        }
    }
}

struct UpdateEmailView: View {
    @StateObject private var viewModel = UpdateEmailViewModel()
    
    var body: some View {
        VStack {
            TextField("Enter your new email", text: $viewModel.newEmail)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .padding()
            
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
            
            // Confirmation message
            if viewModel.emailUpdateSent {
                Text("An email reset message was sent to the new email you entered. Please confirm your new email at that link")
                    .foregroundColor(.red)
            }
            
            Button("Update Email") {
                Task {
                    await viewModel.updateEmail()
                }
            }
            .padding()
        }
    }
}

struct UpdateEmailView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateEmailView()
    }
}

