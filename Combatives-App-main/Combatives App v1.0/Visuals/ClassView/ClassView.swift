//
//  ClassView.swift
//  Combatives App v1.0
//
//  Created by James Huber on 2/15/24.
//

import SwiftUI

struct ClassDetailView: View {
    let className: String
    @State private var selectedOption: Option? = nil

    enum Option: String, CaseIterable {
        case students = "Students"
        case instructors = "Instructors"
        case syllabusAndTools = "Syllabus and Tools"
    }

    var body: some View {
        VStack(spacing: 20) {
            Text("Details for \(className)")
                .font(.title)

            Spacer()

            if let selectedOption = selectedOption {
                switch selectedOption {
                case .students:
                    Text("Students details for \(className)")
                case .instructors:
                    Text("Instructors details for \(className)")
                case .syllabusAndTools:
                    Text("Syllabus and Tools details for \(className)")
                }
            } else {
                ForEach(Option.allCases, id: \.self) { option in
                    Button(action: {
                        selectedOption = option
                    }) {
                        Text(option.rawValue)
                            .font(.headline)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
            }

            Spacer()
        }
        .padding()
        .navigationTitle(className)
    }
}

struct ClassDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ClassDetailView(className: "Sample Class")
    }
}

