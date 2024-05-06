//
//  ClassView.swift
//  Combatives App v1.0
//
//  Created by James Huber on 2/15/24.
//

import SwiftUI

struct ClassView: View {
    var dbClass: DBClass?

    var body: some View {
        VStack {
            Text("Class Name: \(dbClass?.className ?? "Unknown")")
            NavigationLink("Student List", destination: StudentView())
        }
        .navigationTitle("Class Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}


struct ClassView_Previews: PreviewProvider {
    static var previews: some View {
        ClassView()
    }
}

/*
struct Student: Identifiable, Codable {
    @DocumentID var id: String? // Automatically generated ID
    var name: String
    var age: Int
}

struct ClassView: View {
    @State private var students: [Student] = [] // Array to hold students from Firestore

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(students) { student in
                        Text(student.name)
                    }
                    .onDelete(perform: deleteStudent) // Swipe to delete
                }
                
                // Add Student button
                Button(action: {
                    // Action to perform when Add Student button is tapped
                }) {
                    Label("Add Student", systemImage: "plus.circle.fill")
                        .foregroundColor(.green)
                        .padding()
                }
                .padding(.bottom) // Add padding to bottom
                
            }
            .navigationTitle("Class Details")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            fetchStudents() // Fetch students from Firestore when the view appears
        }
    }

    // Function to fetch students from Firestore
    func fetchStudents() {
        let db = Firestore.firestore()
        db.collection("students").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            students = documents.compactMap { queryDocumentSnapshot in
                try? queryDocumentSnapshot.data(as: Student.self)
            }
        }
    }

    // Function to delete student from Firestore
    func deleteStudent(at offsets: IndexSet) {
        let db = Firestore.firestore()
        offsets.forEach { index in
            let student = students[index]
            if let studentID = student.id {
                db.collection("students").document(studentID).delete { error in
                    if let error = error {
                        print("Error deleting student: \(error)")
                    } else {
                        // Remove student from local array
                        students.remove(at: index)
                    }
                }
            }
        }
    }
}

struct ClassView_Previews: PreviewProvider {
    static var previews: some View {
        ClassView()
    }
}
*/
