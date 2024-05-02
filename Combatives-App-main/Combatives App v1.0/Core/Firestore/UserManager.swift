//
//  UserManager.swift
//  Combatives App v1.0
//
//  Created by Ethan Bleakney on 4/1/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

//Note: In a class you have an instance and you can change the value inside that instance
// In a struct you need to mutate it to regenerate the values
struct DBUser: Codable {
    let userId : String
    let email : String
    let photoUrl : String?
    let dateCreated : Date?
    let isInstructor: Bool?
    let classList: [String]?
    // add class list here
    
    init(auth: AuthDataResultModel) {
        self.userId = auth.uid
        self.email = auth.email ?? "No email"
        self.photoUrl = auth.photoUrl
        self.dateCreated = Date()
        self.isInstructor = false
        self.classList = nil
    }
    
    init(
        userId : String,
        email : String,
        photoUrl : String? = nil,
        dateCreated : Date? = nil,
        isInstructor: Bool? = nil,
        classList: [String]? = nil
    ) {
        self.userId=userId
        self.email=email
        self.photoUrl=photoUrl
        self.dateCreated=dateCreated
        self.isInstructor=isInstructor
        self.classList=classList
    }
    
    //takes the current dbuser struct and creates & returns a new dbuser struct
    /*func toggleInstructorStatus() -> DBUser {
        let curVal = isInstructor ?? false
        return DBUser(
            userId: userId,
            email: email,
            photoUrl: photoUrl,
            dateCreated: dateCreated,
            isInstructor: !curVal)
    }*/
    
    /*//mutates the isInstructor var in the struct
    mutating func toggleInstructorStatus() {
        let curVal = isInstructor ?? false
        isInstructor = !curVal
    }*/
    
    //allows us to match the names of our keys to the firestore database so they don't get looked over bc different names
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case email = "email"
        case photoUrl = "photo_url"
        case dateCreated = "date_created"
        case isInstructor = "is_instructor"
        case classList = "class_list"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try container.decode(String.self, forKey: .userId)
        self.email = try container.decode(String.self, forKey: .email)
        self.photoUrl = try container.decodeIfPresent(String.self, forKey: .photoUrl)
        self.dateCreated = try container.decodeIfPresent(Date.self, forKey: .dateCreated)
        self.isInstructor = try container.decodeIfPresent(Bool.self, forKey: .isInstructor)
        self.classList = try container.decodeIfPresent([String].self, forKey: .classList)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.userId, forKey: .userId)
        try container.encode(self.email, forKey: .email)
        try container.encodeIfPresent(self.photoUrl, forKey: .photoUrl)
        try container.encodeIfPresent(self.dateCreated, forKey: .dateCreated)
        try container.encodeIfPresent(self.isInstructor, forKey: .isInstructor)
        try container.encodeIfPresent(self.classList, forKey: .classList)
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
    
    
   /* private let encoder: Firestore.Encoder = {
        let encoder = Firestore.Encoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()
    
    private let decoder: Firestore.Decoder = {
        let decoder = Firestore.Decoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    */
    
    func createNewUser(user: DBUser) async throws {
        try userDocument(userId: user.userId).setData(from: user, merge: false)
        
    }
    
    func getUser(userId: String) async throws -> DBUser {
        try await userDocument(userId: userId).getDocument(as: DBUser.self)
    }
    
    
    //basically just taking the user we have and pushing the whole user back to firestore database to update the user,
    // so it doesn't just update the Instructor status, it updates everything from user
    //merge is true so we don't duplicate the user
    /*func updateInstructorStatus(user: DBUser) async throws {
        try userDocument(userId: user.userId).setData(from: user, merge: true)
    }*/
    
    //updates only the isInstructor value
    func updateInstructorStatus(userId: String, isInstructor: Bool) async throws {
        let data: [String:Any] = [
            DBUser.CodingKeys.isInstructor.rawValue : isInstructor
        ]
        try await userDocument(userId: userId).updateData(data)
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
