//
//  SignInWithEmailView.swift
//  Combatives App v1.0
//
//  Created by Ethan Bleakney on 1/18/24.
//

import SwiftUI

@MainActor
final class SignInWithEmailViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    
    func signIn() {
        guard !email.isEmpty, !password.isEmpty else {
            //NEED TO DO VALIDATION HERE, SO MAKE SURE EMAIL AND PASSWORD ARE VALID, COULD MAKE PASSWORD REQUIRE CHARS, LENGTH, ETC.
            print("No email or password found.")
            print("Please enter a valid ....")
            return
        }
        
        Task {
            do {
                let returnedUserData = try await AuthenticationManager.shared.createUser(email: email, password: password)
                print("Success")
                print(returnedUserData)
            } catch {
                print("Error: \(error)")
            }
        }

    }
    
}

struct SignInWithEmailView: View {
    
    @StateObject private var viewModel = SignInWithEmailViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField("Email...", text: $viewModel.email)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10.0)
            
            SecureField("Password...", text: $viewModel.password)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10.0)
            
            Button {
                viewModel.signIn()
            } label: {
                Text("Sign In")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10.0)
            }
        }
        Spacer()
        .padding()
        .navigationTitle("Sign In With Email")
    }
}


struct SignInWithEmail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SignInWithEmailView()
        }
    }
}
