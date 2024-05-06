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
        // Ensure that StudentView gets the necessary information, like classId
        StudentListView(classId: dbClass?.classId ?? "NO CLASS ID")
            .navigationTitle(dbClass?.className ?? "Unknown Class")
            .navigationBarTitleDisplayMode(.inline)
    }
}


struct ClassView_Previews: PreviewProvider {
    static var previews: some View {
        ClassView()
    }
}
