//
//  AddGradeView.swift
//  Combatives App v1.0
//
//  Created by James Huber on 2/27/24.
//

import SwiftUI

struct AddGradeView: View {
    @Binding var isPresented: Bool
    @Binding var newGrade: String
    @State private var selectedGradeType = "Standing GR"
    
    var body: some View {
        VStack {
            Picker("Grade Type", selection: $selectedGradeType) {
                Text("Standing GR").tag("Standing GR")
                Text("Ground GR").tag("Ground GR")
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            TextField("Enter grade", text: $newGrade)
                .padding()
            
            Button("Add") {
                // Add logic to save the new grade
                isPresented = false
            }
            .padding()
            
            Spacer()
        }
        .padding()
        .navigationTitle("Add Grade")
    }
}
