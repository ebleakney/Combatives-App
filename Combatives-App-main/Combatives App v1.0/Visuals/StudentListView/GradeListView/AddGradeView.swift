import SwiftUI

struct AddGradeView: View {
    @Binding var isPresented: Bool
    @Binding var newGrade: String
    @State private var selectedGradeType: String? = nil
    @State private var navigateToROEView = false // State variable to control navigation

    var body: some View {
        NavigationView {
            VStack {
                Button(action: {
                    selectedGradeType = "Standing GR"
                    isPresented = false // Dismiss the view
                }) {
                    Text("Standing GR")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .padding()
                
                NavigationLink(destination: ROEView(), isActive: $navigateToROEView) {
                    EmptyView() // Invisible link to ROEView
                }
                
                Button(action: {
                    selectedGradeType = "Ground GR"
                    isPresented = true // Dismiss the view
                    navigateToROEView = true // Activate navigation to ROEView
                }) {
                    Text("Ground GR")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .padding()
                
                Spacer()
            }
            .navigationTitle("Add Grade")
        }
        .navigationViewStyle(StackNavigationViewStyle()) // Set navigation style for iPad
        .edgesIgnoringSafeArea(.all) // Ignore safe area to fit full screen
    }
}

struct AddGradeView_Previews: PreviewProvider {
    static var previews: some View {
        AddGradeView(isPresented: .constant(false), newGrade: .constant(""))
            .previewDevice("iPad Pro (12.9-inch) (5th generation)")
    }
}
