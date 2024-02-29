import SwiftUI

struct Student: Identifiable {
    let id = UUID()
    var name: String
}

class StudentStore: ObservableObject {
    @Published var students = [
        Student(name: "John Jacobs"),
        Student(name: "Emily Dipper"),
        Student(name: "Michael Johns")
    ]
    
    func addStudent(name: String) {
        students.append(Student(name: name))
    }
    
    func deleteStudent(at index: IndexSet) {
        students.remove(atOffsets: index)
    }
}

struct StudentListView: View {
    @ObservedObject var studentStore = StudentStore()
    @Environment(\.presentationMode) var presentationMode
    @State private var newStudentName = ""
    @State private var isAddingStudent = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(studentStore.students) { student in
                    Text(student.name)
                }
                .onDelete(perform: studentStore.deleteStudent)
            }
            .navigationTitle("Students")
            .navigationBarItems(trailing: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "arrow.right")
            })
            .navigationBarItems(leading: HStack {
                Button(action: {
                    isAddingStudent = true
                }) {
                    Label("Add Student", systemImage: "plus")
                }
                .foregroundColor(.green)
            })
            .sheet(isPresented: $isAddingStudent, onDismiss: {
                // Add new student when the sheet is dismissed
                if !newStudentName.isEmpty {
                    studentStore.addStudent(name: newStudentName)
                    newStudentName = "" // Reset the name field
                }
            }) {
                // Sheet for adding a new student
                VStack {
                    TextField("Enter student name", text: $newStudentName)
                        .padding()
                    Spacer()
                }
                .padding()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct StudentView: View {
    var body: some View {
        StudentListView()
    }
}

struct StudentView_Previews: PreviewProvider {
    static var previews: some View {
        StudentView()
    }
}
