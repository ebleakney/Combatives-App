//
//  AuthenticationManager.swift
//  Combatives App v1.0
//
//  Created by Ethan Bleakney on 1/18/24.
//

import Foundation
import FirebaseAuth


struct AuthDataResultModel {
    let uid: String
    let email: String?
    let photoUrl: String?
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
    }
}

final class AuthenticationManager {
    
    static let shared = AuthenticationManager()
    private init() { }
    
    func getAuthenticatedUser() throws -> AuthDataResultModel {
        guard let user = Auth.auth().currentUser else {
            //PUT ACTUAL ERROR HERE
            throw URLError(.badServerResponse)
        }
        return AuthDataResultModel(user: user)
    }
    
    
    @discardableResult
    func createUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    @discardableResult
    func signInUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    func resetPassword(email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
    
    func updatePassword(password: String) async throws{
        guard let currentUser = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        
        try await currentUser.updatePassword(to: password)
    }
    
    func verifyOldPassword(email: String, oldPassword: String) async -> Bool {
        let auth = Auth.auth()
        guard let user = auth.currentUser else { return false }
        
        let credential = EmailAuthProvider.credential(withEmail: email, password: oldPassword)
        do {
            try await user.reauthenticate(with: credential)
            return true
        } catch {
            print("Re-authentication failed: \(error.localizedDescription)")
            return false
        }
    }
    
    func updateEmail(email: String) async throws{
        guard let currentUser = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        
        try await currentUser.sendEmailVerification(beforeUpdatingEmail: email)
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
}
