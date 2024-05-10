//
//  GreyGradeView.swift
//  Combatives App v1.0
//
//  Created by Ethan Bleakney on 5/9/24.
//

import SwiftUI
import Combine

struct GreyGradeView: View {
    @State private var studentName: String = ""
    @State private var studentWeight: String = ""
    @State private var selectedGender: Int = 0 // 0 for male, 1 for female
    @State private var optionalNotes: String = ""
    @State private var disciplineSliderValue: Double = 0
    @State private var staminaSliderValue: Double = 0
    @Binding var liveGrapplingPoints: Int
    @Binding var liveTotalPoints: Int
    @Environment(\.presentationMode) var presentationMode

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
        .navigationTitle("Grey Final Grade")
    }
    
    private var formFields: some View {
        VStack {
            studentInfoSection
            subjectivePointsSection
            scoringSummarySection
        }
    }
    
    private var studentInfoSection: some View {
        VStack {
            Text("Student Information")
                .font(.headline)
                .padding(.bottom, 2)
                .underline()
            HStack {
                Label("Name:", systemImage: "person.fill")
                TextField("Enter Student's Name", text: $studentName)
            }
            HStack {
                Label("Weight:", systemImage: "scalemass.fill")
                TextField("Enter Student's Weight", text: $studentWeight)
                    .keyboardType(.numberPad)
                    .onReceive(Just(studentWeight)) { newValue in
                        let filtered = newValue.filter { "0123456789".contains($0) }
                        if filtered != newValue {
                            self.studentWeight = filtered
                        }
                    }
            }
            genderPicker
            notesField
        }
    }
    
    private var genderPicker: some View {
        Picker(selection: $selectedGender, label: Text("Gender")) {
            Text("Male").tag(0)
            Text("Female").tag(1)
        }
        .pickerStyle(SegmentedPickerStyle())
    }
    
    private var notesField: some View {
        TextField("Optional Notes", text: $optionalNotes)
    }
    
    private var subjectivePointsSection: some View {
        VStack {
            Text("Subjective Points")
                .font(.headline)
                .padding(.bottom, 2)
                .underline()
            SliderView(label: "Discipline", value: $disciplineSliderValue)
            SliderView(label: "Stamina", value: $staminaSliderValue)
        }
    }
    
    private var scoringSummarySection: some View {
        VStack {
            Text("Scoring Summary")
                .font(.headline)
                .padding(.bottom, 2)
                .underline()
            HStack {
                Text("Live Grappling:")
                Spacer()
                Text("\(liveGrapplingPoints)")
            }
            HStack {
                Text("Total Points:")
                Spacer()
                Text("\(liveTotalPoints)")
            }
            HStack {
                Text("Letter Grade:")
                Spacer()
                Text(letterGrade)
            }
        }
    }
    
    private var submitButton: some View {
        Button(action: submitAction) {
            Text("Submit Grades")
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
        // Example action: print grades and navigate back
        print("Submitting grades for \(studentName)")
        presentationMode.wrappedValue.dismiss()
    }
}

struct SliderView: View {
    var label: String
    @Binding var value: Double
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(label): \(Int(value))")
            Slider(value: $value, in: -10...10, step: 1)
        }
    }
}

// Usage of the GreyGradeView needs a NavigationView wrapper in parent if standalone testing:

struct GreyGradeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            GreyGradeView(liveGrapplingPoints: .constant(50), liveTotalPoints: .constant(70))
        }
    }
}

