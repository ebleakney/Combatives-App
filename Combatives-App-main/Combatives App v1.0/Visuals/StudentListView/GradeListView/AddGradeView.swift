//
//  AddGradeView.swift
//  Combatives App v1.0
//
//  Created by James Huber on 2/27/24.
//
/*
import SwiftUI

struct AddGradeView: View {
    @Binding var isPresented: Bool
    var studentId: String
    @State private var $studentName: String = ""
    @State private var isStandingGrade: Bool = true // Default to true
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter matchup name", value: $studentName)
                    .keyboardType(.numberPad)
                    .padding()
                
                Button("Begin Match") {
                    Task {
                        do {
                            if isStandingGrade {
                                try await StudentManager.shared.updateStandingGrGrade(studentId: studentId, standingGrGrade: gradePoints)
                            } else {
                                try await StudentManager.shared.updateGroundGrGrade(studentId: studentId, groundGrGrade: gradePoints)
                            }
                            isPresented = false
                        } catch {
                            print("Failed to start match: \(error)")
                        }
                    }
                }
                .padding()
                
                Spacer()
            }
            .navigationTitle("Matchup Creator")
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .edgesIgnoringSafeArea(.all)
    }
}
*/
