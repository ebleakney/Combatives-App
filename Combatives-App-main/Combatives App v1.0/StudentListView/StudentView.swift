import SwiftUI

struct StudentListView: View {
    @ObservedObject var studentStore = StudentStore()
    @Environment(\.presentationMode) var presentationMode
    @State private var isAddingStudent = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(studentStore.students) { student in
                    NavigationLink(destination: GradeListView(student: student, studentStore: studentStore)) {
                        Text(student.name)
                    }
                }
                .onDelete(perform: studentStore.deleteStudent)
            }
            .navigationTitle("Students")
            .navigationBarItems(trailing: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "arrow.right")
            })
            .navigationBarItems(leading: Button(action: {
                isAddingStudent = true
            }) {
                Image(systemName: "plus")
                    .foregroundColor(.green)
            })
            .sheet(isPresented: $isAddingStudent) {
                AddStudentView(studentStore: studentStore, isPresented: $isAddingStudent)
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
