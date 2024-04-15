//
//  UserManager.swift
//  Combatives App v1.0
//
//  Created by Ethan Bleakney on 4/1/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct DBUser {
    let userId : String
    let email : String
    let photoUrl : String?
    let dateCreated : Date?
}

final class UserManager {
    
    //singleton design pattern
    static let shared = UserManager()
    private init() {}
    
    func createNewUser(auth: AuthDataResultModel) async throws {
        var userData: [String:Any] = [
            "user_id" : auth.uid,
            "date_created" : Timestamp(),
            "email" : auth.email
        ]
        if let photoURL = auth.photoUrl {
            userData["photo_url"] = photoURL
        }
        
        try await Firestore.firestore().collection("users").document(auth.uid).setData(userData, merge: false)
    }
    
    
    func getUser(userId: String) async throws -> DBUser {
        let snapshot = try await Firestore.firestore().collection("users").document(userId).getDocument()
        
        guard let data = snapshot.data(), let userId = data["user_id"] as? String, let email = data["email"] as? String else{
            throw URLError(.badServerResponse)
        }
    
        let photoUrl = data["photo_url"] as? String
        let dateCreated = data["date_created"] as? Date
        
        return DBUser(userId: userId, email: email, photoUrl: photoUrl, dateCreated: dateCreated)
    }
}
