import SwiftUI
import Combine

struct GradeSheetView: View {
    @State private var studentName: String = ""
    @State private var studentWeight: String = ""
    @State private var selectedGender: Int = 0 // 0 for male, 1 for female
    @State private var optionalNotes: String = ""
    @State private var disciplineSliderValue: Double = 0
    @State private var staminaSliderValue: Double = 0
    @Binding var liveGrapplingPoints: Int
    @Binding var liveTotalPoints: Int
    
    private var letterGrade: String {
        switch liveGrapplingPoints {
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
        ZStack {   // rounded rectangle border
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.black, lineWidth: 1)
                .background(RoundedRectangle(cornerRadius: 8).foregroundColor(.white))
            
            VStack {
                VStack {
                    HStack {
                        Text("Name:")
                            .font(.headline)
                            .padding(.bottom, 2)
                            .underline()
                        
                        TextField("Enter Student's Name", text: $studentName)
                            .padding()
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .autocapitalization(.words)
                    }
                    .padding()
                    
                    HStack {
                        Text("Weight:")
                            .font(.headline)
                            .padding(.bottom, 2)
                            .underline()
                        
                        TextField("Enter Student's Weight", text: $studentWeight)
                            .padding()
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .autocapitalization(.none)
                            .keyboardType(.numberPad) // Set keyboard type to number pad
                            .onReceive(Just(studentWeight)) { newValue in
                                let filtered = newValue.filter { "0123456789".contains($0) }
                                if filtered != newValue {
                                    self.studentWeight = filtered
                                }
                            }
                        
                        Picker(selection: $selectedGender, label: Text("Gender")) {
                            Text("Male").tag(0)
                            Text("Female").tag(1)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(.leading, 8)
                    }
                    .padding()
                    
                    HStack {
                        Text("Notes:")
                            .font(.headline)
                            .padding(.bottom, 2)
                            .underline()
                        
                        TextField("Optional", text: $optionalNotes)
                            .padding()
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .autocapitalization(.words)
                    }
                    .padding()
                    
                    Text("Subjective Points:")
                        .font(.headline)
                        .padding(.bottom, 2)
                        .underline()
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Discipline:")
                                .font(.headline)
                                .padding(.trailing, 8)
                            Slider(value: $disciplineSliderValue, in: -10...10, step: 1)
                            Text("\(Int(disciplineSliderValue))")
                        }
                        Text("(-10 to 10 Points)")
                            .padding(.trailing)
                    }
                    .padding()
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Stamina:")
                                .font(.headline)
                                .padding(.trailing, 8)
                            Slider(value: $staminaSliderValue, in: -10...10, step: 1)
                            Text("\(Int(staminaSliderValue))")
                        }
                        Text("(-10 to 10 Points)")
                            .padding(.trailing)
                    }
                    .padding()
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Live Grappling:")
                                .font(.headline)
                                .padding(.bottom, 2)
                                .underline()
                            Text("(Max 80 Points)")
                                .padding(.trailing)
                            Text("Total Points:")
                                .font(.headline)
                                .padding(.bottom, 2)
                                .underline()
                            Text("Letter Grade:")
                                .font(.headline)
                                .padding(.top)
                                .underline()
                        }
                        
                        Spacer() // Add Spacer to push the next view to the right
                        VStack(alignment: .leading) {
                            Text("\(liveGrapplingPoints)")
                                .font(.headline)
                                .padding(.bottom, 2)
                                .foregroundColor(.blue)
                            Text("")
                                .padding(.trailing)
                            Text("")
                                .padding(.trailing)
                            Text("\(liveTotalPoints)")
                                .font(.headline)
                                .padding(.bottom, 2)
                                .foregroundColor(.blue)
                            Text("")
                                .padding(.trailing)
                            Text("")
                                .padding(.trailing)
                            Text("\(letterGrade)")
                                .font(.headline)
                                .padding(.bottom, 2)
                                .foregroundColor(.green)
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

struct ReContentView_Previews: PreviewProvider {
    static var previews: some View {
        GradeSheetView(liveGrapplingPoints: .constant(0), liveTotalPoints: .constant(0))
    }
}
