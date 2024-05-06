//
//  GradeListView.swift
//  Combatives App v1.0
//
//  Created by James Huber on 2/27/24.
//

import SwiftUI

struct GradeListView: View {
    var student: DBStudent
    @State private var editedStandingGrade: String
    @State private var editedGroundGrade: String
    @State private var showConfirmationAlert = false
    
    init(student: DBStudent) {
        self.student = student
        _editedStandingGrade = State(initialValue: "\(student.standingGrGrade ?? 0)")
        _editedGroundGrade = State(initialValue: "\(student.groundGrGrade ?? 0)")
    }
    
    var body: some View {
        VStack {
            Text("Grades for \(student.name ?? "Unknown")")
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
                    Task {
                        do {
                            try await StudentManager.shared.updateGrades(studentId: student.id, standingGrGrade: standingGrade, groundGrGrade: groundGrade)
                            showConfirmationAlert = true
                        } catch {
                            print("Error updating grades: \(error)")
                        }
                    }
                }
            }
            .padding()
            
            Spacer()
        }
        .padding()
        .navigationTitle("Grades")
        .alert(isPresented: $showConfirmationAlert) {
            Alert(title: Text("Grade Saved"), message: Text("The grades have been saved successfully."), dismissButton: .default(Text("OK")))
        }
    }
}
