//
//  AddStudentView.swift
//  Combatives App v1.0
//
//  Created by James Huber on 2/27/24.
//

import SwiftUI

struct AddStudentView: View {
    @ObservedObject var studentStore: StudentStore
    @Binding var isPresented: Bool
    @State private var newStudentName = ""
    @State private var newStudentStandingGrade = ""
    @State private var newStudentGroundGrade = ""
    
    var body: some View {
        VStack {
            TextField("Enter student name", text: $newStudentName)
                .padding()
            
            TextField("Enter standing grade points", text: $newStudentStandingGrade)
                .padding()
            
            TextField("Enter ground grade points", text: $newStudentGroundGrade)
                .padding()
            
            Button("Add Student") {
                if let standingGrade = Int(newStudentStandingGrade),
                   let groundGrade = Int(newStudentGroundGrade) {
                    studentStore.addStudent(name: newStudentName, standingGrade: Grade(grade: "Standing GR", points: standingGrade), groundGrade: Grade(grade: "Ground GR", points: groundGrade))
                    isPresented = false
                }
            }
            .padding()
            
            Spacer()
        }
        .padding()
    }
}
