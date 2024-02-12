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
    
    
    func updateEmail() async {
        
        do {
            try await AuthenticationManager.shared.updateEmail(email: newEmail)
            errorMessage = nil // Clear any previous error message
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
                .padding()
            
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
            
            Button("Update Email") {
                Task {
                    await viewModel.updateEmail()
                    Text("An reset email message was sent to the new email you entered. Please confirm your new email at that link")
                        .foregroundColor(.red)
                }
            }
            .padding()
        }
    }
}

#Preview {
    UpdateEmailView()
}
