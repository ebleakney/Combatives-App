//
//  SignInWithEmailView.swift
//  Combatives App v1.0
//
//  Created by Ethan Bleakney on 1/18/24.
//

import SwiftUI



struct SignInWithEmailView: View {
    
    //environment var for appViewModel from ContentView
    @EnvironmentObject var appViewModel: AppViewModel
    @StateObject private var viewModel = SignInWithEmailViewModel()
    
    @State private var errorMessage = ""
    
    var body: some View {
        NavigationStack {
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
                        } catch SignInError.emptyCredentials {
                            errorMessage = "Email and password cannot be empty"

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
}


struct SignInWithEmail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SignInWithEmailView()
                .environmentObject(AppViewModel())
        }
    }
}
