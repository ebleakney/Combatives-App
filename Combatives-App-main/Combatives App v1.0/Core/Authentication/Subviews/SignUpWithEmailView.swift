//
//  SignUpWithEmailView.swift
//  Combatives App v1.0
//
//  Created by Ethan Bleakney on 1/24/24.
//

import SwiftUI


struct SignUpWithEmailView: View {
    //environment variable for appViewModel from ContentView
    @EnvironmentObject var appViewModel: AppViewModel
    @StateObject private var viewModel = SignUpWithEmailViewModel()
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
                
                Button {
                    Task {
                        do {
                            try await viewModel.signUp()
                            // change appViewModel.isAuthenticated to true in order to navigate to HomeScreen
                            appViewModel.isAuthenticated = true
                            return
                        } catch SignInError.emptyCredentials {
                            errorMessage = "Email and password cannot be empty"
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
}


struct SignUpWithEmail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SignUpWithEmailView()
        }
    }
}
