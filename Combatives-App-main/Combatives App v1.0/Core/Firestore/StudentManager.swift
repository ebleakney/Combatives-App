//
//  StudentManager.swift
//  Combatives App v1.0
//
//  Created by Ethan Bleakney on 4/23/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct DBStudent: Codable, Identifiable {
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
    
    let studentCollection = Firestore.firestore().collection("students")
    let classCollection = Firestore.firestore().collection("classes")
    
    private func studentDocument(studentId: String) -> DocumentReference {
        studentCollection.document(studentId)
    }
    
//    private func classDocument(classId: String) -> DocumentReference {
//        classCollection.document(classId)
//    }
    
    
    // Create a new student and add their ID to the class's student list
    func createNewStudent(student: DBStudent, classId: String) async throws {
        try studentDocument(studentId: student.id).setData(from: student, merge: false)

        // Fetch the class document
        let classRef = classCollection.document(classId)
        let classDoc = try await classRef.getDocument()
        
        if var studentList = classDoc.data()?["student_list"] as? [String] {
            // Append the new student's ID to the list
            studentList.append(student.id)
            // Update the class document
            try await classRef.updateData(["student_list": studentList])
        } else {
            // Initialize the list if it doesn't exist
            try await classRef.updateData(["student_list": [student.id]])
        }
    }
    
    // create a new student regularly
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
    
    //updates only the gr grades
    func updateGrades(studentId: String, standingGrGrade: Int, groundGrGrade: Int) async throws {
        let data: [String:Any] = [
            DBStudent.CodingKeys.standingGrGrade.rawValue: standingGrGrade,
            DBStudent.CodingKeys.groundGrGrade.rawValue: groundGrGrade
        ]
        try await studentDocument(studentId: studentId).updateData(data)
    }
    
    func deleteStudent(studentId: String) async throws {
        let studentDoc = studentDocument(studentId: studentId)
        try await studentDoc.delete()
    }

    //update only the standing gr grade
    func updateStandingGrGrade(studentId: String, standingGrGrade: Int?) async throws {
        var data = [String: Any]()
        if let standingGrGrade = standingGrGrade {
            data["standing_gr_grade"] = standingGrGrade
        }
        let studentDoc = studentDocument(studentId: studentId)
        try await studentDoc.updateData(data)
    }
    
    //update only the ground gr grade
    func updateGroundGrGrade(studentId: String, groundGrGrade: Int?) async throws {
        var data = [String: Any]()
        if let groundGrGrade = groundGrGrade {
            data["ground_gr_grade"] = groundGrGrade
        }
        let studentDoc = studentDocument(studentId: studentId)
        try await studentDoc.updateData(data)
    }
    
    // Method to fetch all students for a given class ID
    func fetchStudentsForClass(classId: String) async throws -> [DBStudent] {
        let classDoc = try await Firestore.firestore().collection("classes").document(classId).getDocument()
        guard let studentIDs = classDoc.data()?["student_list"] as? [String] else {
            return []
        }
        return try await fetchStudents(studentIDs: studentIDs)
    }

    // fetch multiple students based on studentId
    func fetchStudents(studentIDs: [String]) async throws -> [DBStudent] {
        var students: [DBStudent] = []
        for id in studentIDs {
            let student = try await getStudent(studentId: id)
            students.append(student)
        }
        return students
    }
}
