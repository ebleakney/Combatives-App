//
//  SettingsViewModel.swift
//  Combatives App v1.0
//
//  Created by Ethan Bleakney on 3/12/24.
//

import Foundation
import FirebaseAuth

@MainActor
final class SettingsViewModel: ObservableObject {

    @Published var authUser: AuthDataResultModel? = nil
    
    
    func signOut() throws {
       try AuthenticationManager.shared.signOut()
    }
    
}
