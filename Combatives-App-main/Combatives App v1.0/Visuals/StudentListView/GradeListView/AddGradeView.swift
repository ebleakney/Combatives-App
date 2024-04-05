import SwiftUI

struct AddGradeView: View {
    @Binding var isPresented: Bool
    @Binding var newGrade: String
    @State private var selectedGradeType: String? = nil
    @State private var shouldNavigate: Bool = false // Added to control navigation programmatically
    
    var body: some View {
        NavigationStack {
            VStack {
                Picker("Grade Type", selection: $selectedGradeType) {
                    Text("Standing GR").tag("Standing GR")
                    Text("Ground GR").tag("Ground GR")
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                TextField("Enter grade", text: $newGrade)
                    .padding()
                
                NavigationLink(destination: ROEView(), isActive: $shouldNavigate) {
                    EmptyView()
                }
                /*navigationDestination(isPresented: $shouldNavigate) {
                    ROEView()
                }*/
                
                Button("Add") {
                    // Add logic to save the new grade
                    if selectedGradeType == "Ground GR" {
                        shouldNavigate = true
                        isPresented = false
                    }
                }
                .padding()
                
                Spacer()
            }
            .padding()
            .navigationTitle("Add Grade")
        }
    }
}

struct AddGradeView_Previews: PreviewProvider {
    static var previews: some View {
        AddGradeView(isPresented: .constant(false), newGrade: .constant(""))
    }
}
