//
//  GridViewViewModel.swift
//  Combatives App v1.0
//
//  Created by Ethan Bleakney on 5/9/24.
//

import Foundation
import Combine

@MainActor
class GridViewViewModel: ObservableObject {
    @Published var classes = [DBClass]()
    @Published var selectedClasses = Set<String>()
    @Published var isSelectionMode = false

    init() {
        fetchClasses()
    }

    func fetchClasses() {
        Task {
            do {
                let snapshot = try await ClassManager.shared.classCollection.getDocuments()
                self.classes = snapshot.documents.compactMap { document in
                    try? document.data(as: DBClass.self)
                }
            } catch {
                print("Error fetching classes: \(error)")
            }
        }
    }

    func enterSelectionMode() {
        isSelectionMode = true
    }

    func cancelSelectionMode() {
        isSelectionMode = false
        selectedClasses.removeAll()
    }

    func confirmDeletion() {
        Task {
            for classId in selectedClasses {
                do {
                    let students = try await StudentManager.shared.fetchStudentsForClass(classId: classId)
                    for student in students {
                        try await StudentManager.shared.deleteStudent(studentId: student.id)
                    }
                    try await ClassManager.shared.deleteClass(classId: classId)
                } catch {
                    print("Error deleting class or students: \(error)")
                }
            }
            selectedClasses.removeAll()
            isSelectionMode = false
            await fetchClasses()
        }
    }

    func toggleSelection(classId: String) {
        if selectedClasses.contains(classId) {
            selectedClasses.remove(classId)
        } else {
            selectedClasses.insert(classId)
        }
    }
}
