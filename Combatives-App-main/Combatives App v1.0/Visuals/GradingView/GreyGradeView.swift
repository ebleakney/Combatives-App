struct GreyGradeView: View {
    @ObservedObject var gradeManager: GradeManager  // Inject GradeManager

    @State private var navigateToNextView = false // State to manage navigation
    
    private var letterGrade: String {
        switch gradeManager.greyPlayerScore {
        case 90...100:
            return "A"
        case 80..<90:
            return "A-"
        case 70..<80:
            return "B+"
        case 60..<70:
            return "B"
        case 40..<60:
            return "B-"
        case 30..<40:
            return "C+"
        case 20..<30:
            return "C"
        case 10..<20:
            return "C-"
        case 1..<10:
            return "D"
        case 0:
            return "F"
        default:
            return ""
        }
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.black, lineWidth: 1)
                .background(RoundedRectangle(cornerRadius: 8).foregroundColor(.white))
            
            VStack {
                Text("Grey Final Grade")
                    .font(.title)
                    .padding()

                VStack {
                    HStack {
                        Text("Name:")
                            .font(.headline)
                            .underline()
                        
                        TextField("Enter Student's Name", text: $gradeManager.greyPlayerName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .autocapitalization(.words)
                    }
                    .padding()

                    HStack {
                        Text("Weight:")
                            .font(.headline)
                            .underline()
                        
                        TextField("Enter Student's Weight", value: $gradeManager.greyPlayerWeight, formatter: NumberFormatter())
                            .keyboardType(.numberPad)
                        
                        Picker(selection: $gradeManager.greyPlayerGender, label: Text("Gender")) {
                            Text("Male").tag("Male")
                            Text("Female").tag("Female")
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    .padding()

                    SliderInputView(title: "Discipline", value: $gradeManager.greyPlayerDiscipline)
                    SliderInputView(title: "Stamina", value: $gradeManager.greyPlayerStamina)

                    LiveScoresView(gradeManager: gradeManager, score: $gradeManager.greyPlayerScore)

                    Button("Next View") {
                        navigateToNextView = true // Placeholder for navigation action
                    }
                    .buttonStyle()
                }
            }
        }
    }
}

struct GreySliderInputView: View {
    var title: String
    @Binding var value: Double
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(title): \(Int(value))")
            Slider(value: $value, in: -10...10, step: 1)
                .padding()
        }
    }
}

struct GreyLiveScoresView: View {
    @ObservedObject var gradeManager: GradeManager
    @Binding var score: Int
    
    var body: some View {
        VStack {
            Text("Total Points: \(score)")
            // Display other live scores and calculations as needed
        }
    }
}
