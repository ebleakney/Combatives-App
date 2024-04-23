//
//  ProfileView.swift
//  Combatives App v1.0
//
//  Created by Ethan Bleakney on 3/12/24.
//
// User profile with firestore to track individual user data

import SwiftUI



@MainActor
final class ProfileViewModel: ObservableObject {
    
    @Published private(set) var user: DBUser? = nil
    
    func loadCurrentUser() async throws {
        let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
        self.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
    }
    
    func toggleInstructorStatus() {
        guard let user else {return}
        let curVal = user.isInstructor ?? false
        let updatedUser = DBUser(userId: user.userId, email: user.email, photoUrl: user.photoUrl, dateCreated: user.dateCreated, isInstructor: !curVal)
        Task {
            try await UserManager.shared.updateInstructorStatus(user: updatedUser)
            self.user = try await UserManager.shared.getUser(userId: user.userId)
        }
    }
}




struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        List {
            if let user = viewModel.user {
                Text("UserID: \(user.userId)")
                
                Button {
                    viewModel.toggleInstructorStatus()
                } label: {
                    Text("User is an instructor: \((user.isInstructor ?? false).description.capitalized)")
                }
            }
        }
        .task {
            try? await viewModel.loadCurrentUser()
        }
        .navigationTitle("Profile")
       /* .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    SettingsView(showSignInView: $showSignInView)
                } label: {
                    Image(systemName: "gear")
                        .font(.headline)
                }
            }
        }*/
    }
}

#Preview {
    NavigationStack {
        ProfileView(showSignInView: .constant(false))
    }
}
