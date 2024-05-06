//
//StudentView.swift
//

import SwiftUI

struct StudentView: View {
    var student: DBStudent

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("Name: \(student.name ?? "Unknown")")
                Text("Gender: \(student.gender ?? "Not provided")")
                Text("Weight: \(student.weight.map(String.init) ?? "Not provided") lbs")
                Text("Skill Level: \(student.skillLevel.map(String.init) ?? "Not provided")")
                // Add more properties as needed
            }
            .navigationBarTitle("Student Details", displayMode: .inline)
            .padding()
        }
    }
}
