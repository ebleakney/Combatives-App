//
//  SignUpWithEmailView.swift
//  Combatives App v1.0
//
//  Created by Ethan Bleakney on 1/24/24.
//

import SwiftUI


@MainActor
final class SignUpWithEmailViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    
    func signUp() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            //NEED TO DO VALIDATION HERE, SO MAKE SURE EMAIL AND PASSWORD ARE VALID, COULD MAKE PASSWORD REQUIRE CHARS, LENGTH, ETC.
            print("No email or password found.")
            print("Please enter a valid ....")
            return
        }
        
        try await AuthenticationManager.shared.createUser(email: email, password: password)
    }
}

struct SignUpWithEmailView: View {
    
    @StateObject private var viewModel = SignUpWithEmailViewModel()

    
    var body: some View {
        VStack(alignment: .leading) {
            TextField("Email...", text: $viewModel.email)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10.0)
                .autocapitalization(.none)
            
            SecureField("Password...", text: $viewModel.password)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10.0)
                .autocapitalization(.none)
            
            Button {
                Task {
                    do {
                        try await viewModel.signUp()
                        return
                    } catch {
                        //put actual error on view here
                        print(error)
                    }
                }
            } label: {
                Text("Sign Up")
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
        .navigationTitle("Sign Up With Email")
    }
}


struct SignUpWithEmail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SignUpWithEmailView()
        }
    }
}
