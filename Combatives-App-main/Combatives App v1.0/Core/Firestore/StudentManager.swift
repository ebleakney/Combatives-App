//
//  StudentManager.swift
//  Combatives App v1.0
//
//  Created by Ethan Bleakney on 4/23/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct DBStudent: Codable {
    let id: String
    let standingGrGrade: Int?
    let groundGrGrade: Int?
    let name: String?
    let gender: String?
    let weight: Int?
    let skillLevel: Int?
    
    
    init(
        id : String,
        standingGrGrade : Int? = nil,
        groundGrGrade : Int? = nil,
        name : String? = nil,
        gender: String? = nil,
        weight: Int? = nil,
        skillLevel: Int? = nil
    ) {
        self.id = id
        self.standingGrGrade = standingGrGrade
        self.groundGrGrade = groundGrGrade
        self.name = name
        self.gender = gender
        self.weight = weight
        self.skillLevel = skillLevel
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case standingGrGrade = "standing_gr_grade"
        case groundGrGrade = "ground_gr_grade"
        case name = "name"
        case gender = "gender"
        case weight = "weight"
        case skillLevel = "skill_level"
    }

    // Custom initializer from Decoder
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        standingGrGrade = try container.decodeIfPresent(Int.self, forKey: .standingGrGrade)
        groundGrGrade = try container.decodeIfPresent(Int.self, forKey: .groundGrGrade)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        gender = try container.decodeIfPresent(String.self, forKey: .gender)
        weight = try container.decodeIfPresent(Int.self, forKey: .weight)
        skillLevel = try container.decodeIfPresent(Int.self, forKey: .skillLevel)
    }

    // Custom method to encode to an encoder
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encodeIfPresent(standingGrGrade, forKey: .standingGrGrade)
        try container.encodeIfPresent(groundGrGrade, forKey: .groundGrGrade)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(gender, forKey: .gender)
        try container.encodeIfPresent(weight, forKey: .weight)
        try container.encodeIfPresent(skillLevel, forKey: .skillLevel)
    }
    
    
}




final class StudentManager {
    static let shared = StudentManager()
    private init() {}
    
    private let studentCollection = Firestore.firestore().collection("students")
    
    private func studentDocument(studentId: String) -> DocumentReference {
        studentCollection.document(studentId)
    }
    
    
    
    func createNewStudent(student: DBStudent) async throws {
        try studentDocument(studentId: student.id).setData(from: student, merge: false)
    }
    
    func getStudent(studentId: String) async throws -> DBStudent {
        try await studentDocument(studentId: studentId).getDocument(as: DBStudent.self)
    }
    
    
    //update everything for the student
    //merge is true so we don't duplicate the user
    func updateStudent(student: DBStudent) async throws {
        try studentDocument(studentId: student.id).setData(from: student, merge: true)
    }
    
    //updates only the isInstructor value
    /*func updateGrades(studentId: String, standingGrGrade: Int, groundGrGrade: Int) async throws {
        let data: [String:Any] = [
            DBStudent.CodingKeys.standingGrGrade.rawValue: standingGrGrade
            DBStudent.CodingKeys.groundGrGrade.rawValue: groundGrGrade
        ]
        try await studentDocument(studentId: studentId).updateData(data)
    }*/

}

/*
//firebase documents all students will need
//create a separate struct for students bc they won't be authenticating/wont be actual DBusers?
let standingGrGrade: Int?
let groundGrGrade: Int?
let name: String?
let gender: String?
let weight: Int?
let skillLevel: Int?
 */



/*
self.standingGrGrade = 0
self.groundGrGrade = 0
self.name = "No Name Entered"
self.gender = "No Gender Entered"
self.weight = 99999
self.skillLevel = 0
 */
