//
//  AddGradeView.swift
//  Combatives App v1.0
//
//  Created by James Huber on 2/27/24.
//

import SwiftUI

struct AddGradeView: View {
    @Binding var isPresented: Bool
    var studentId: String
    @State private var gradePoints: Int = 0
    @State private var isStandingGrade: Bool = true // Default to true
    
    var body: some View {
        NavigationView {
            VStack {
                Toggle("Is Standing Grade", isOn: $isStandingGrade)
                    .padding()
                
                TextField("Grade Points", value: $gradePoints, formatter: NumberFormatter())
                    .keyboardType(.numberPad)
                    .padding()
                
                Button("Save Grade") {
                    Task {
                        do {
                            if isStandingGrade {
                                try await StudentManager.shared.updateStandingGrGrade(studentId: studentId, standingGrGrade: gradePoints)
                            } else {
                                try await StudentManager.shared.updateGroundGrGrade(studentId: studentId, groundGrGrade: gradePoints)
                            }
                            isPresented = false
                        } catch {
                            print("Failed to add/update grade: \(error)")
                        }
                    }
                }
                .padding()
                
                Spacer()
            }
            .navigationTitle("Add/Edit Grade")
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .edgesIgnoringSafeArea(.all)
    }
}
