//
//  AddStudentView.swift
//  Combatives App v1.0
//
//  Created by James Huber on 2/27/24.
//

import SwiftUI

struct AddStudentView: View {
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
            
            Spacer()
        }
        .padding()
    }
}
