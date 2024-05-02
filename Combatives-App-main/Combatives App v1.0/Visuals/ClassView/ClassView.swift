//
//  ClassView.swift
//  Combatives App v1.0
//
//  Created by James Huber on 2/15/24.
//

import SwiftUI

struct ClassView: View {
    var dbClass: DBClass?

    var body: some View {
        VStack {
            Text("Class Name: \(dbClass?.className ?? "Unknown")")
            // Display other details similarly
            NavigationLink("Show All Classes", destination: AllClassesView())
            NavigationLink("Add Students", destination: AddStudentView())
        }
        .navigationTitle("Class Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}


struct ClassView_Previews: PreviewProvider {
    static var previews: some View {
        ClassView()
    }
}

