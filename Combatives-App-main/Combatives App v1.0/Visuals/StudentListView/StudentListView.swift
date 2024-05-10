//
//  StudentListView.swift
//  Combatives App v1.0
//
//  Created by Ethan Bleakney on 5/6/24.
//

import SwiftUI
import FirebaseFirestore

class StudentListViewModel: ObservableObject {
    @Published var studentGroups: [String: [DBStudent]] = [:]
    var classId: String
    private var classListener: ListenerRegistration?

    private let weightClasses = [125, 133, 141, 149, 157, 165, 174, 187, 195, 205]

    init(classId: String) {
        self.classId = classId
        subscribeToClassUpdates()
    }

    deinit {
        classListener?.remove()
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
            self?.groupStudentsByWeight(students: fetchedStudents)
        }
    }

    private func groupStudentsByWeight(students: [DBStudent]) {
        var groups: [String: [DBStudent]] = [:]
        for student in students {
            let weightClass = classifyWeight(weight: student.weight ?? 0)
            groups[weightClass, default: []].append(student)
        }
        self.studentGroups = groups.mapValues { $0.sorted { ($0.name ?? "") < ($1.name ?? "") } }
    }

    private func classifyWeight(weight: Int) -> String {
        for w in weightClasses {
            if weight <= w + 8 {
                return "\(max(0, w - 8))-\(w + 8) lbs"
            }
        }
        return "205+ lbs"
    }
}



struct StudentListView: View {
    var classId: String
    @StateObject private var viewModel: StudentListViewModel
    @State private var isAddingStudent = false
    @State private var showingROEView = false
    @State private var isSelectingMatchup = false
    @State private var selectedStudents: [DBStudent] = []
    @Environment(\.presentationMode) var presentationMode

    init(classId: String) {
        self.classId = classId
        _viewModel = StateObject(wrappedValue: StudentListViewModel(classId: classId))
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.studentGroups.keys.sorted(), id: \.self) { key in
                    Section(header: Text(key)) {
                        ForEach(viewModel.studentGroups[key] ?? [], id: \.id) { student in
                            StudentRow(student: student, isSelectingMatchup: $isSelectingMatchup, selectedStudents: $selectedStudents)
                        }
                    }
                }
            }
            .navigationTitle("Students")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItemGroup(placement: .bottomBar) {
                    if !isSelectingMatchup {
                        Button("Select Students for GR") {
                            isSelectingMatchup = true
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                    } else {
                        Button("Exit Toggling") {
                            isSelectingMatchup = false
                            selectedStudents.removeAll()
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                    }

                    if isSelectingMatchup && selectedStudents.count == 2 {
                        Button("Continue") {
                            showingROEView = true
                            isSelectingMatchup = false // Reset selection mode after continuing
                            selectedStudents.removeAll() // Clear selection
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                    }

                    Button("Add Student") {
                        isAddingStudent = true
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                }
            }
            .sheet(isPresented: $showingROEView) {
                ROEView(students: selectedStudents)
            }
            .sheet(isPresented: $isAddingStudent) {
                AddStudentView(classId: classId)
            }
        }
    }
}

struct StudentRow: View {
    var student: DBStudent
    @Binding var isSelectingMatchup: Bool
    @Binding var selectedStudents: [DBStudent]

    var body: some View {
        if !isSelectingMatchup {
            NavigationLink(destination: StudentView(student: student)) {
                StudentCell(student: student, isSelected: false)
            }
        } else {
            StudentCell(student: student, isSelected: selectedStudents.contains { $0.id == student.id })
            .onTapGesture {
                toggleSelection(for: student)
            }
        }
    }

    private func toggleSelection(for student: DBStudent) {
        if let index = selectedStudents.firstIndex(where: { $0.id == student.id }) {
            selectedStudents.remove(at: index)
        } else if selectedStudents.count < 2 {
            selectedStudents.append(student)
        }
    }
}

struct StudentCell: View {
    var student: DBStudent
    var isSelected: Bool

    var body: some View {
        HStack {
            Text(student.name ?? "No Name")
            Spacer()
            Text("\(student.weight ?? 0) lbs - \(student.gender ?? "N/A")")
        }
        .background(isSelected ? Color.blue.opacity(0.2) : Color.clear)
    }
}




