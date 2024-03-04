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
    
    func signIn() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            //NEED TO DO VALIDATION HERE, SO MAKE SURE EMAIL AND PASSWORD ARE VALID, COULD MAKE PASSWORD REQUIRE CHARS, LENGTH, ETC.
            print("No email or password found.")
            print("Please enter a valid ....")
            
            //ADD GUARD FOR BAD LENGTH PASSWORD OR INSUFFICIENT CHARS (PASSWORD REQS)
            // ADD GUARD FOR USERNAME
            return
        }
        
        try await AuthenticationManager.shared.signInUser(email: email, password: password)
    }
}

struct SignInWithEmailView: View {
    
    //environment var for appViewModel from ContentView
    @EnvironmentObject var appViewModel: AppViewModel
    @StateObject private var viewModel = SignInWithEmailViewModel()
    
    @State private var errorMessage = ""
    
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
            
            //Check if error message is empty. If not, display error
            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red) // Makes the error message text red
            }
            
            //SIGN IN BUTTON
            Button {
                Task {
                    do {
                        try await viewModel.signIn()
                        // revert error message to nothing if the sign in works
                        errorMessage = ""
                        // change appViewModel.isAuthenticated to true in order to navigate to HomeScreen
                        appViewModel.isAuthenticated = true

                    } catch {
                        //put actual error on view here
                        print("Incorrect email or password --", error)
                        errorMessage = "Unrecognized email or password"
                    }
                }
            } label: {
                Text("Sign In")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10.0)
            }
            
            // SIGN UP BUTTON:
            NavigationLink {
                SignUpWithEmailView()
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
        .navigationTitle("Sign In With Email")
    }
}


struct SignInWithEmail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SignInWithEmailView()
                .environmentObject(AppViewModel())
        }
    }
}
