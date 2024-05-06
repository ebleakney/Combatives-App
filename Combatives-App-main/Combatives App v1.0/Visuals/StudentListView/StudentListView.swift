//
//  StudentListView.swift
//  Combatives App v1.0
//
//  Created by Ethan Bleakney on 5/6/24.
//

import SwiftUI
import FirebaseFirestore

class StudentListViewModel: ObservableObject {
    @Published var students: [DBStudent] = []
    var classId: String
    private var classListener: ListenerRegistration?

    init(classId: String) {
        self.classId = classId
        subscribeToClassUpdates()
    }

    deinit {
        classListener?.remove()  // Remove listener when the view model is deallocated
    }

    func subscribeToClassUpdates() {
        let classRef = Firestore.firestore().collection("classes").document(classId)
        classListener = classRef.addSnapshotListener { [weak self] snapshot, error in
            guard let snapshot = snapshot, error == nil else {
                print("Error fetching class updates: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            if let studentIDs = snapshot.data()?["student_list"] as? [String] {
                self?.fetchStudents(studentIDs: studentIDs)
            }
        }
    }

    func fetchStudents(studentIDs: [String]) {
        var fetchedStudents: [DBStudent] = []
        let group = DispatchGroup()

        for id in studentIDs {
            group.enter()
            let studentRef = Firestore.firestore().collection("students").document(id)
            studentRef.getDocument { (document, error) in
                defer { group.leave() }
                if let document = document, let student = try? document.data(as: DBStudent.self) {
                    fetchedStudents.append(student)
                } else {
                    print("Error fetching student details: \(error?.localizedDescription ?? "Unknown error")")
                }
            }
        }

        group.notify(queue: .main) { [weak self] in
            self?.students = fetchedStudents.sorted(by: { $0.name ?? "" < $1.name ?? "" }) // Sort if needed
        }
    }
}


struct StudentListView: View {
    var classId: String
    @StateObject private var viewModel: StudentListViewModel
    @State private var isAddingStudent = false
    @Environment(\.presentationMode) var presentationMode

    init(classId: String) {
        self.classId = classId
        _viewModel = StateObject(wrappedValue: StudentListViewModel(classId: classId))
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.students, id: \.id) { student in
                    NavigationLink(destination: StudentView(student: student)) {
                        Text(student.name ?? "No Name")
                    }
                }
                .onDelete(perform: deleteStudents)
            }
            .navigationTitle("Students")
            .navigationBarItems(leading: Button("Add Student") {
                isAddingStudent = true
            }, trailing: Button("Done") {
                presentationMode.wrappedValue.dismiss()
            })
            .sheet(isPresented: $isAddingStudent) {
                AddStudentView(classId: classId)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func deleteStudents(at offsets: IndexSet) {
        for index in offsets {
            let student = viewModel.students[index]
            Task {
                do {
                    try await StudentManager.shared.deleteStudent(studentId: student.id)
                    viewModel.students.remove(at: index)
                } catch {
                    print("Failed to delete student: \(error.localizedDescription)")
                }
            }
        }
    }
}
