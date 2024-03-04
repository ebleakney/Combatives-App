//
//  GradeListView.swift
//  Combatives App v1.0
//
//  Created by James Huber on 2/27/24.
//

import SwiftUI

struct GradeListView: View {
    var student: Student
    @ObservedObject var studentStore: StudentStore
    @State private var editedStandingGrade: String
    @State private var editedGroundGrade: String
    @State private var isAddingGrade = false
    @State private var newGrade: String = ""
    @State private var showConfirmationAlert = false
    
    init(student: Student, studentStore: StudentStore) {
        self.student = student
        self.studentStore = studentStore
        _editedStandingGrade = State(initialValue: "\(student.standingGrade.points)")
        _editedGroundGrade = State(initialValue: "\(student.groundGrade.points)")
    }
    
    var body: some View {
        VStack {
            Text("Grades for \(student.name)")
                .font(.title)
                .padding()
            
            HStack {
                Text("Standing GR:")
                TextField("Enter standing grade points", text: $editedStandingGrade)
                    .padding()
            }
            
            HStack {
                Text("Ground GR:")
                TextField("Enter ground grade points", text: $editedGroundGrade)
                    .padding()
            }
            
            Button("Save") {
                if let standingGrade = Int(editedStandingGrade), let groundGrade = Int(editedGroundGrade) {
                    let updatedStandingGrade = Grade(grade: "Standing GR", points: standingGrade)
                    let updatedGroundGrade = Grade(grade: "Ground GR", points: groundGrade)
                    studentStore.updateStudentGrades(student: student, standingGrade: updatedStandingGrade, groundGrade: updatedGroundGrade)
                    showConfirmationAlert = true
                }
            }
            .padding()
            
            Button("Add Grade") {
                isAddingGrade = true
            }
            .padding()
            .sheet(isPresented: $isAddingGrade) {
                AddGradeView(isPresented: $isAddingGrade, newGrade: $newGrade)
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Grades")
        .alert(isPresented: $showConfirmationAlert) {
            Alert(title: Text("Grade Saved"), message: Text("The grades have been saved successfully."), dismissButton: .default(Text("OK")))
        }
    }
}



/// Might be obselete at this point but idk
struct GradeRow: View {
    var grade: Grade
    
    var body: some View {
        HStack {
            Text(grade.grade)
            Spacer()
            Text("\(grade.points) points")
        }
        .padding()
    }
}
