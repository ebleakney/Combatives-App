//
//  BlueGradeView.swift
//  Combatives App v1.0
//
//  Created by Ethan Bleakney on 5/9/24.
//

import SwiftUI
import Combine



struct BlueGradeView: View {
    @State private var studentName: String = ""
    @State private var studentWeight: String = ""
    @State private var selectedGender: Int = 0 // 0 for male, 1 for female
    @State private var optionalNotes: String = ""
    @State private var disciplineSliderValue: Double = 0
    @State private var staminaSliderValue: Double = 0
    @Binding var liveGrapplingPoints: Int
    @Binding var liveTotalPoints: Int

    @State private var navigateToGreyGrade = false // State to manage navigation
    
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
        NavigationStack {
            VStack {
                ScrollView {
                    VStack {
                        formFields
                        submitButton
                    }
                    .padding()
                }
                .background(Color(.systemGroupedBackground))
                .cornerRadius(8)
            }
            .navigationTitle("Blue Final Grade")
            .background(
                NavigationLink(destination: GreyGradeView(liveGrapplingPoints: $liveGrapplingPoints, liveTotalPoints: $liveTotalPoints), isActive: $navigateToGreyGrade) {
                    EmptyView() // This stays as an invisible link
                }
            )
        }
    }
    
    private var formFields: some View {
        VStack {
            studentInfoSection
            subjectivePointsSection
            scoringSummarySection
        }
    }
    
    private var studentInfoSection: some View {
        Group {
            TextField("Enter Student's Name", text: $studentName)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            TextField("Enter Student's Weight", text: $studentWeight)
                .keyboardType(.numberPad)
                .onReceive(Just(studentWeight)) { newValue in
                    let filtered = newValue.filter { "0123456789".contains($0) }
                    if filtered != newValue {
                        self.studentWeight = filtered
                    }
                }
            
            Picker("Gender", selection: $selectedGender) {
                Text("Male").tag(0)
                Text("Female").tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            
            TextField("Optional Notes", text: $optionalNotes)
        }
        .padding()
    }
    
    private var subjectivePointsSection: some View {
        Group {
            Slider(value: $disciplineSliderValue, in: -10...10, step: 1)
            Text("Discipline: \(Int(disciplineSliderValue)) Points")
            Slider(value: $staminaSliderValue, in: -10...10, step: 1)
            Text("Stamina: \(Int(staminaSliderValue)) Points")
        }
        .padding()
    }
    
    private var scoringSummarySection: some View {
        VStack {
            Text("Live Grappling: \(liveGrapplingPoints) Points")
            Text("Total Points: \(liveTotalPoints)")
            Text("Letter Grade: \(letterGrade)")
        }
        .padding()
    }
    
    private var submitButton: some View {
        Button(action: submitAction) {
            Text("Submit")
                .bold()
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(10)
        }
        .padding()
    }
    
    private func submitAction() {
        // Example action: print grades and navigate to GreyGradeView
        print("Submitting grades for \(studentName)")
        navigateToGreyGrade = true
    }
}

struct BlueContentView_Previews: PreviewProvider {
    static var previews: some View {
        BlueGradeView(liveGrapplingPoints: .constant(50), liveTotalPoints: .constant(70))
    }
}


