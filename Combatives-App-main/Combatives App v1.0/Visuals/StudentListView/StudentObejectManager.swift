//
//  StudentObejectManager.swift
//  Combatives App v1.0
//
//  Created by James Huber on 2/27/24.
//

import SwiftUI

struct Student: Identifiable {
    let id = UUID()
    var name: String
    var standingGrade: Grade
    var groundGrade: Grade
}

class StudentStore: ObservableObject {
    @Published var students = [
        Student(name: "John Jacobs", standingGrade: Grade(grade: "Standing GR", points: 90), groundGrade: Grade(grade: "Ground GR", points: 85)),
        Student(name: "Emily Dipper", standingGrade: Grade(grade: "Standing GR", points: 95), groundGrade: Grade(grade: "Ground GR", points: 88)),
        Student(name: "Michael Johns", standingGrade: Grade(grade: "Standing GR", points: 88), groundGrade: Grade(grade: "Ground GR", points: 82))
    ]
    
    func addStudent(name: String, standingGrade: Grade, groundGrade: Grade) {
        students.append(Student(name: name, standingGrade: standingGrade, groundGrade: groundGrade))
    }
    
    func deleteStudent(at index: IndexSet) {
        students.remove(atOffsets: index)
    }
    
    func updateStudentGrades(student: Student, standingGrade: Grade, groundGrade: Grade) {
            if let index = students.firstIndex(where: { $0.id == student.id }) {
                students[index].standingGrade = standingGrade
                students[index].groundGrade = groundGrade
            }
        }
}

struct Grade {
    var grade: String
    var points: Int
}
