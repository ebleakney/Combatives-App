//
//  AddClassView.swift
//  Combatives App v1.0
//
//  Created by Ethan Bleakney on 5/2/24.
//
import SwiftUI
import Combine

@MainActor
final class AddClassViewModel: ObservableObject {
    @Published var classId = UUID().uuidString
    @Published var className: String = ""
    @Published var goPeriod: String = ""
    @Published var semester: String = ""
    @Published var year: String = ""
    @Published var studentList: [String] = []
    @Published var section: String = ""
    
    // Navigation trigger
    @Published var navigateToClassView = false
    @Published var createdClass: DBClass? = nil

    func createNewClass() async {
        let newClass = DBClass(
            classId: classId,
            className: className,
            goPeriod: goPeriod,
            semester: semester,
            year: Int(year) ?? 2024,
            studentList: studentList,
            section: section
        )
        
        do {
            try await ClassManager.shared.createNewClass(DBClass: newClass)
            createdClass = newClass
            navigateToClassView = true
        } catch {
            print("Failed to add class: \(error)")
        }
    }
}



struct AddClassView: View {
    @StateObject private var viewModel = AddClassViewModel()

    var body: some View {
        NavigationStack {
            Form {
                TextField("Class Name", text: $viewModel.className)
                TextField("Go Period", text: $viewModel.goPeriod)
                TextField("Semester", text: $viewModel.semester)
                TextField("Year", text: $viewModel.year)
                TextField("Section", text: $viewModel.section)
                
                Button("Submit") {
                    Task {
                        await viewModel.createNewClass()
                    }
                }
                .disabled(viewModel.className.isEmpty || viewModel.semester.isEmpty)
            }
            .navigationTitle("Add New Class")
            .navigationDestination(isPresented: $viewModel.navigateToClassView) {
                // Assuming ClassView is correctly implemented to accept a DBClass
                if let createdClass = viewModel.createdClass {
                    ClassView(dbClass: createdClass)
                } else {
                    // Handle the case where the navigation is triggered without a valid class
                    Text("Error: No class data available.").foregroundColor(.red)
                }
            }
        }
    }
}


struct AddClassView_Previews: PreviewProvider {
    static var previews: some View {
        AddClassView()
    }
}
