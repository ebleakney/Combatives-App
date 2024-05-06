//
//  AddStudentView.swift
//  Combatives App v1.0
//
//  Created by James Huber on 2/27/24.
//

import SwiftUI

struct AddStudentView: View {
    var classId: String?
    @Environment(\.presentationMode) var presentationMode

    @State private var newStudentName = ""
    @State private var newStudentGender = "M"
    @State private var newStudentWeight = ""
    @State private var newStudentSkillLevel = 0
    @State private var newStudentStandingGrade = "0"
    @State private var newStudentGroundGrade = "0"
    @State private var errorMessage: String? = nil
    
    let genders = ["M", "F"]
    let skillLevels = Array(0...5)

    var body: some View {
        NavigationStack {
            Form {
                TextField("Enter student name", text: $newStudentName)
                    .padding()

                Picker("Gender", selection: $newStudentGender) {
                    ForEach(genders, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                TextField("Enter student weight", text: $newStudentWeight)
                    .keyboardType(.numberPad)
                    .padding()

                Picker("Skill Level", selection: $newStudentSkillLevel) {
                    ForEach(skillLevels, id: \.self) { level in
                        Text("\(level)")
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .padding()

                TextField("Standing Grade Points", text: $newStudentStandingGrade)
                    .keyboardType(.numberPad)
                    .padding()
                    .onReceive(newStudentStandingGrade.publisher.collect()) {
                        self.newStudentStandingGrade = String($0.prefix(3))
                        if let val = Int(newStudentStandingGrade), val > 100 {
                            newStudentStandingGrade = "100"
                        }
                    }

                TextField("Ground Grade Points", text: $newStudentGroundGrade)
                    .keyboardType(.numberPad)
                    .padding()
                    .onReceive(newStudentGroundGrade.publisher.collect()) {
                        self.newStudentGroundGrade = String($0.prefix(3))
                        if let val = Int(newStudentGroundGrade), val > 100 {
                            newStudentGroundGrade = "100"
                        }
                    }
                
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
                
                Button("Done") {
                    addStudent()
                }
            }
            .navigationBarTitle("Add New Student")
        }
    }
    
    private func addStudent() {
        guard let classId = classId,
              let weight = Int(newStudentWeight),
              let standingGrGrade = Int(newStudentStandingGrade),
              let groundGrGrade = Int(newStudentGroundGrade) else {
            errorMessage = "Please ensure all fields are correctly filled."
            return
        }

        let newStudent = DBStudent(
            id: UUID().uuidString,
            standingGrGrade: standingGrGrade,
            groundGrGrade: groundGrGrade,
            name: newStudentName,
            gender: newStudentGender,
            weight: weight,
            skillLevel: newStudentSkillLevel
        )
        
        Task {
            do {
                try await StudentManager.shared.createNewStudent(student: newStudent, classId: classId)
                DispatchQueue.main.async {
                    presentationMode.wrappedValue.dismiss()
                }
            } catch {
                DispatchQueue.main.async {
                    errorMessage = "Failed to add student: \(error.localizedDescription)"
                }
            }
        }
    }
}
