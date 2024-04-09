import SwiftUI

struct AddGradeView: View {
    @Binding var isPresented: Bool
    @Binding var newGrade: String
    @State private var selectedGradeType: String? = nil
    
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
                
                Button(action: {
                    selectedGradeType = "Ground GR"
                    isPresented = false // Dismiss the view
                    //ROEView()
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
