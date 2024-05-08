//
//StudentView.swift
//

import SwiftUI

struct StudentView: View {
    var student: DBStudent
    @State private var showAddGradeView = false  // State to control the presentation of AddGradeView

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                GroupBox(label: Label("Student Details", systemImage: "person.fill")) {
                    VStack(alignment: .leading, spacing: 10) {
                        DetailView(title: "Name", value: student.name ?? "Unknown")
                        DetailView(title: "Gender", value: student.gender ?? "Not provided")
                        DetailView(title: "Weight", value: "\(student.weight.map(String.init) ?? "Not provided") lbs")
                        DetailView(title: "Skill Level", value: student.skillLevel.map(String.init) ?? "Not provided")
                        DetailView(title: "Standing GR Grade", value: student.standingGrGrade.map(String.init) ?? "Not provided")
                        DetailView(title: "Ground GR Grade", value: student.groundGrGrade.map(String.init) ?? "Not provided")
                    }
                }
                .padding()

                // Centered buttons just under the details
                HStack {
                    Spacer() // Spacer before the buttons for center alignment
                    // Navigate to Edit GR Grades
                    NavigationLink(destination: GradeListView(student: student)) {
                        Text("Edit GR Grades")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding(.trailing, 10) // Add padding between buttons
                    /*
                    // Button to show AddGradeView
                    Button("Grade Ground Gr") {
                        showAddGradeView = true
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(10)
                     */
                    Spacer() // Spacer after the buttons for center alignment
                }
                .padding(.top) // Additional padding on top of the buttons

                Spacer() // This spacer pushes all content up
            }
            .navigationBarTitle("Student Details", displayMode: .inline)
            .sheet(isPresented: $showAddGradeView) {
                AddGradeView(isPresented: $showAddGradeView, studentId: student.id)
            }
        }
    }
}

struct DetailView: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text("\(title):")
                .bold()
            Spacer()
            Text(value)
        }
    }
}


