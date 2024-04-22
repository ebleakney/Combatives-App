//
//  UserManager.swift
//  Combatives App v1.0
//
//  Created by Ethan Bleakney on 4/1/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct DBUser: Codable {
    let userId : String
    let email : String
    let photoUrl : String?
    let dateCreated : Date?
    let isInstructor: Bool?
    
    init(auth: AuthDataResultModel) {
        self.userId=auth.uid
        self.email=auth.email ?? "No email"
        self.photoUrl=auth.photoUrl
        self.dateCreated=Date()
        self.isInstructor=false
    }
    
    init(
        userId : String,
        email : String,
        photoUrl : String? = nil,
        dateCreated : Date? = nil,
        isInstructor: Bool? = nil
    ) {
        self.userId=userId
        self.email=email
        self.photoUrl=photoUrl
        self.dateCreated=dateCreated
        self.isInstructor=isInstructor
    }
}

final class UserManager {
    
    //singleton design pattern
    static let shared = UserManager()
    private init() {}
    
    private let userCollection = Firestore.firestore().collection("users")
    
    private func userDocument(userId: String) -> DocumentReference {
        userCollection.document(userId)
    }
    
    
    private let encoder: Firestore.Encoder = {
        let encoder = Firestore.Encoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()
    
    private let decoder: Firestore.Decoder = {
        let decoder = Firestore.Decoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    func createNewUser(user: DBUser) async throws {
        try userDocument(userId: user.userId).setData(from: user, merge: false, encoder: encoder)
        
    }
    
    func getUser(userId: String) async throws -> DBUser {
        try await userDocument(userId: userId).getDocument(as: DBUser.self, decoder: decoder)
    }
    
    
    func updateInstructorStatus(user: DBUser) async throws {
        try userDocument(userId: user.userId).setData(from: user, merge: true, encoder: encoder)
    }
}
    
    /*func createNewUser(auth: AuthDataResultModel) async throws {
     var userData: [String:Any] = [
     "user_id" : auth.uid,
     "date_created" : Timestamp(),
     "email" : auth.email
     ]
     if let photoURL = auth.photoUrl {
     userData["photo_url"] = photoURL
     }
     
     try await userDocument(userId: auth.uid).setData(userData, merge: false)
     }
     
     
     func getUser(userId: String) async throws -> DBUser {
     let snapshot = try await userDocument(userId: userId).getDocument()
     
     guard let data = snapshot.data(), let userId = data["user_id"] as? String, let email = data["email"] as? String else{
     throw URLError(.badServerResponse)
     }
     
     let photoUrl = data["photo_url"] as? String
     let dateCreated = data["date_created"] as? Date
     
     return DBUser(userId: userId, email: email, photoUrl: photoUrl, dateCreated: dateCreated)
     }
     }*/
