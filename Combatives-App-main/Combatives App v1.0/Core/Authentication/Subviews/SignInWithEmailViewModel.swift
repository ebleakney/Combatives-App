//
//  SignInWithEmailViewModel.swift
//  Combatives App v1.0
//
//  Created by Ethan Bleakney on 3/12/24.
//

import Foundation

enum SignInError: Error, LocalizedError {
    case emptyCredentials
    case invalidCredentials

    var errorDescription: String? {
        switch self {
        case .emptyCredentials:
            return "Email and password cannot be empty."
        case .invalidCredentials:
            return "Incorrect email or password."
        }
    }
}

@MainActor
final class SignInWithEmailViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    
    func signIn() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            //NEED TO DO VALIDATION HERE, SO MAKE SURE EMAIL AND PASSWORD ARE VALID, COULD MAKE PASSWORD REQUIRE CHARS, LENGTH, ETC.
            print("No email or password found.")
            print("Please enter a valid ....")
            throw SignInError.emptyCredentials
            
            //ADD GUARD FOR BAD LENGTH PASSWORD OR INSUFFICIENT CHARS (PASSWORD REQS)
            // ADD GUARD FOR USERNAME
        }
        
        try await AuthenticationManager.shared.signInUser(email: email, password: password)
    }
}
