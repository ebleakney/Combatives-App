//
//  ActionsView.swift
//  Combatives App v1.0
//
//  Created by Ethan Bleakney on 4/23/24.
//

import SwiftUI

@MainActor
final class ActionsViewModel: ObservableObject {
    @Published private(set) var student: DBStudent? = nil
    
    func updateStudentInfo() {
        guard let student else {return}
        let curVal = student
        
        Task {
            //try await UserManager.shared.updateInstructorStatus(userId: user.userId, isInstructor: !curVal)
            //self.user = try await UserManager.shared.getUser(userId: user.userId)
        }
    }
}

// Actions view is meant for the teacher to be able to add classes
// in the app, and be able to upload files
//(like student roster excel files)
struct ActionsView: View {
    var body: some View {
        Text("Actions View")
        
//        Button {
//            let newStudent = DBStudent()
//            try await StudentManager.shared.createNewStudent(student: newStudent)
//        } label: {
//            
//        }
    }
}

#Preview {
    ActionsView()
}
