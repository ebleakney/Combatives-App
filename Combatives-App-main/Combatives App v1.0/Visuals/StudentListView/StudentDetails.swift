////
////  StudentDetails.swift
////  Combatives App v1.0
////
////  Created by Ethan Bleakney on 5/6/24.
////
//
//import Foundation
//import SwiftUI
//import FirebaseFirestore
//import FirebaseFirestoreSwift
//
//class StudentStore: ObservableObject {
//    @Published var students: [DBStudent] = []
//
//    private var db = Firestore.firestore()
//    private var studentCollection: CollectionReference
//
//    init(classId: String) {
//        studentCollection = db.collection("students")
//        fetchStudentsForClass(classId: classId)
//    }
//
//    private func fetchStudentsForClass(classId: String) {
//        // Assuming the class document contains an array of student IDs in 'studentList'
//        db.collection("classes").document(classId).getDocument { document, error in
//            if let document = document, document.exists, let studentIDs = document.data()?["student_list"] as? [String] {
//                self.loadStudents(studentIDs: studentIDs)
//            } else {
//                print("Error fetching class document: \(error?.localizedDescription ?? "Unknown error")")
//            }
//        }
//    }
//
//    private func loadStudents(studentIDs: [String]) {
//        for studentID in studentIDs {
//            studentCollection.document(studentID).getDocument { (document, error) in
//                if let document = document, document.exists, let student = try? document.data(as: DBStudent.self) {
//                    DispatchQueue.main.async {
//                        self.students.append(student)
//                    }
//                } else {
//                    print("Error fetching student: \(error?.localizedDescription ?? "Unknown error")")
//                }
//            }
//        }
//    }
//
//    func addStudent(student: DBStudent) async throws {
//        do {
//            try await studentCollection.document(student.id).setData(from: student)
//            DispatchQueue.main.async {
//                self.students.append(student)
//            }
//        } catch {
//            print("Error adding student: \(error)")
//        }
//    }
//
//    func deleteStudent(student: DBStudent) async throws {
//        do {
//            try await studentCollection.document(student.id).delete()
//            DispatchQueue.main.async {
//                self.students.removeAll { $0.id == student.id }
//            }
//        } catch {
//            print("Error deleting student: \(error)")
//        }
//    }
//
//    func updateStudent(student: DBStudent) async throws {
//        do {
//            try await studentCollection.document(student.id).setData(from: student, merge: true)
//        } catch {
//            print("Error updating student: \(error)")
//        }
//    }
//}
