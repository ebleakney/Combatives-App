//
//  ClassManager.swift
//  Combatives App v1.0
//
//  Created by Ethan Bleakney on 4/23/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


struct DBClass: Codable {
    var classId: String
    var className: String?
    var goPeriod: String?
    var semester: String?
    var year: Int?
    var studentList: [String]?
    var section: String?
    
    init(
        classId: String,
        className: String? = nil,
        goPeriod: String? = nil,
        semester: String? = nil,
        year: Int? = nil,
        studentList: [String]? = nil,
        section: String? = nil
    ) {
        self.classId = classId
        self.className = className
        self.goPeriod = goPeriod
        self.semester = semester
        self.year = year
        self.studentList = studentList
        self.section = section
    }
    
    enum CodingKeys: String, CodingKey {
        case classId = "class_id"
        case className = "class_name"
        case goPeriod = "go_period"
        case semester = "semester"
        case year = "year"
        case studentList = "student_list"
        case section = "section"
    }
    
    // Custom initializer from Decoder
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        classId = try container.decode(String.self, forKey: .classId)
        className = try container.decodeIfPresent(String.self, forKey: .className)
        goPeriod = try container.decodeIfPresent(String.self, forKey: .goPeriod)
        semester = try container.decodeIfPresent(String.self, forKey: .semester)
        year = try container.decodeIfPresent(Int.self, forKey: .year)
        studentList = try container.decodeIfPresent([String].self, forKey: .studentList)
        section = try container.decodeIfPresent(String.self, forKey: .section)
    }
    
    // Custom method to encode to an encoder
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(classId, forKey: .classId)
        try container.encodeIfPresent(className, forKey: .className)
        try container.encodeIfPresent(goPeriod, forKey: .goPeriod)
        try container.encodeIfPresent(semester, forKey: .semester)
        try container.encodeIfPresent(year, forKey: .year)
        try container.encodeIfPresent(studentList, forKey: .studentList)
        try container.encodeIfPresent(section, forKey: .section)
    }
}

final class ClassManager {
    static let shared = ClassManager()
    private init() { }
    
    let classCollection = Firestore.firestore().collection("classes")
    
    func classDocument(classId: String) -> DocumentReference {
        classCollection.document(classId)
    }
    
    
    func createNewClass(DBClass: DBClass) async throws {
        try classDocument(classId: DBClass.classId).setData(from: DBClass, merge: false)
    }
    
    func getClass(classId: String) async throws -> DBClass {
        try await classDocument(classId: classId).getDocument(as: DBClass.self)
    }
    
    
    //update everything for the student
    //merge is true so we don't duplicate the user
    func updateClass(DBClass: DBClass) async throws {
        try classDocument(classId: DBClass.classId).setData(from: DBClass, merge: true)
    }
}
