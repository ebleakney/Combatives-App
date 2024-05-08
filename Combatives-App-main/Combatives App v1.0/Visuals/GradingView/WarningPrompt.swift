import SwiftUI

struct ROEView: View {
    @State private var allowToGrade: Bool = false
    var students: [DBStudent] // Array to hold students

    let roeList = [
        "No standing",
        "No slamming",
        "No striking",
        "No stacking",
        "No spinal cranks or headlocks",
        "No small digit manipulations",
        "Nothing 'dirty' (fish-hooks, hair pulling, etc.)",
        "Only use authorized submissions taught to the entire class and indicated by instructors",
        "Mouthpieces must be worn"
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("PE Combative's Rules of Engagement (ROEs)")
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 10)
                .underline()

            ForEach(0..<roeList.count, id: \.self) { index in
                HStack {
                    Text("\(index + 1).")
                        .fontWeight(.bold)
                    Text(self.roeList[index])
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.leading, 5)
                }
            }
            .padding(.bottom, 20)

            HStack {
                Spacer()

                Button(action: {
                    self.allowToGrade = true
                }) {
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .foregroundColor(.green)
                        .frame(width: 50, height: 50)
                }
                .padding()


                Spacer()
            }
        }
        .padding()
        .background(
            NavigationLink(destination:  /*TODO: NEED TO CONTINUE TO CONNECT DATA THROUGHOUT*/ ClosedGuardBlueDPView(/*students: students), isActive: $allowToGrade*/)) {
                EmptyView() // Invisible link to ClosedGuardBlueDPView
            }
        )
    }
}

struct ROEView_Previews: PreviewProvider {
    static var previews: some View {
        ROEView(students: []) // Empty array for preview purposes
    }
}
